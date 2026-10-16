package com.fashionproject.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionproject.dao.OrderDAO;
import com.fashionproject.dao.impl.OrderDAOImpl;
import com.fashionproject.model.Cart;
import com.fashionproject.model.CartItem;
import com.fashionproject.model.Order;
import com.fashionproject.model.User;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            loggedInUser = (User) session.getAttribute("loggedInUser");
        }

        // 1. Check if user is logged in
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Check if cart exists and is not empty
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?error=empty");
            return;
        }

        // 3. Read shipping and payment details from request parameters
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String addressLine1 = request.getParameter("address");
        String addressLine2 = request.getParameter("address2");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");
        String country = request.getParameter("country");
        String paymentMethod = request.getParameter("paymentMethod");

        // 4. Compute total amount from cart items safely using BigDecimal.valueOf()
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (CartItem item : cart.getItems()) {
            BigDecimal itemTotal = BigDecimal.valueOf(item.getPrice()).multiply(BigDecimal.valueOf(item.getQuantity()));
            totalAmount = totalAmount.add(itemTotal);
        }

        // 5. Create Order object and map fields matching Order.java model
        Order order = new Order();
        order.setUserId(loggedInUser.getUserId());
        order.setTotalAmount(totalAmount);
        order.setOrderDate(new Date());
        order.setOrderStatus("PENDING");
        order.setPaymentMethod(paymentMethod != null ? paymentMethod : "COD");

        // Map delivery fields
        order.setDeliveryName(fullName != null ? fullName : loggedInUser.getName());
        order.setDeliveryPhone(phone);
        order.setDeliveryAddressLine1(addressLine1);
        order.setDeliveryAddressLine2(addressLine2);
        order.setDeliveryCity(city);
        order.setDeliveryState(state);
        order.setDeliveryPincode(pincode);
        order.setDeliveryCountry(country != null ? country : "India");

        try {
            // 6. Save order and items using DAO transaction
            boolean isCreated = orderDAO.createOrder(order, cart.getItems());

            if (isCreated) {
                // Clear the cart after successful order placement
                session.removeAttribute("cart");
                
                // Redirect to an order success confirmation page
                response.sendRedirect(request.getContextPath() + "/orderSuccess.jsp?orderId=" + order.getOrderId());
            } else {
                response.sendRedirect(request.getContextPath() + "/checkout.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/checkout.jsp?error=exception");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/checkout.jsp");
    }
}