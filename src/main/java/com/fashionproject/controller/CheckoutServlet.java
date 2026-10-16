package com.fashionproject.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionproject.dao.CartItemDAO;
import com.fashionproject.dao.OrderDAO;
import com.fashionproject.dao.impl.CartItemDAOImpl;
import com.fashionproject.dao.impl.OrderDAOImpl;
import com.fashionproject.model.CartItem;
import com.fashionproject.model.Order;
import com.fashionproject.model.User;
import com.fashionproject.util.DBConnection;
import com.fashionproject.util.EmailUtil;
import com.fashionproject.util.SmsService;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CartItemDAO cartItemDAO = new CartItemDAOImpl();
    private final OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedInUser = getLoggedInUser(request);
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int cartId = getCartIdForUser(loggedInUser);
        List<CartItem> cartItems = cartItemDAO.getCartItemsByCartId(cartId);

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        BigDecimal cartTotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            BigDecimal itemPrice = BigDecimal.valueOf(item.getPrice());
            BigDecimal itemSubtotal = itemPrice.multiply(BigDecimal.valueOf(item.getQuantity()));
            cartTotal = cartTotal.add(itemSubtotal);
        }

        request.setAttribute("loggedInUser", loggedInUser);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);

        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedInUser = getLoggedInUser(request);
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Read form parameters matching checkout.jsp inputs precisely with "delivery" prefix
        String paymentMethod = request.getParameter("paymentMethod");
        String deliveryName = request.getParameter("deliveryName");
        String deliveryPhone = request.getParameter("deliveryPhone");
        String addressLine1 = request.getParameter("deliveryAddressLine1");
        String addressLine2 = request.getParameter("deliveryAddressLine2");
        String city = request.getParameter("deliveryCity");
        String state = request.getParameter("deliveryState");
        String pincode = request.getParameter("deliveryPincode");
        String country = request.getParameter("deliveryCountry");

        int cartId = getCartIdForUser(loggedInUser);
        List<CartItem> cartItems = cartItemDAO.getCartItemsByCartId(cartId);

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        BigDecimal totalAmount = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            BigDecimal itemPrice = BigDecimal.valueOf(item.getPrice());
            BigDecimal itemSubtotal = itemPrice.multiply(BigDecimal.valueOf(item.getQuantity()));
            totalAmount = totalAmount.add(itemSubtotal);
        }

        Order order = new Order();
        order.setUserId(loggedInUser.getUserId());
        order.setTotalAmount(totalAmount);
        order.setPaymentMethod(paymentMethod != null ? paymentMethod : "UPI");
        order.setOrderStatus("Processing");

        order.setDeliveryName(deliveryName != null && !deliveryName.trim().isEmpty() ? deliveryName : loggedInUser.getName());
        order.setDeliveryPhone(deliveryPhone != null && !deliveryPhone.trim().isEmpty() ? deliveryPhone : loggedInUser.getPhone());
        order.setDeliveryAddressLine1(addressLine1 != null && !addressLine1.trim().isEmpty() ? addressLine1 : loggedInUser.getAddressLine1());
        order.setDeliveryAddressLine2(addressLine2 != null ? addressLine2 : loggedInUser.getAddressLine2());
        order.setDeliveryCity(city != null && !city.trim().isEmpty() ? city : loggedInUser.getCity());
        order.setDeliveryState(state != null && !state.trim().isEmpty() ? state : loggedInUser.getState());
        order.setDeliveryPincode(pincode != null && !pincode.trim().isEmpty() ? pincode : loggedInUser.getPincode());
        order.setDeliveryCountry(country != null && !country.trim().isEmpty() ? country : "India");

        try {
            boolean success = orderDAO.createOrder(order, cartItems);

            if (success) {
                cartItemDAO.clearCart(cartId);

                // TRIGGER ASYNC EMAIL NOTIFICATION
                if (loggedInUser.getEmail() != null && !loggedInUser.getEmail().trim().isEmpty()) {
                    String orderIdStr = String.valueOf(order.getOrderId());
                    EmailUtil.sendOrderConfirmationAsync(
                        loggedInUser.getEmail(), 
                        orderIdStr, 
                        totalAmount.doubleValue()
                    );
                }

                // TRIGGER ASYNC SMS NOTIFICATION (Twilio)
                String targetPhone = order.getDeliveryPhone();
                if (targetPhone != null && !targetPhone.trim().isEmpty()) {
                    String smsMessage = "Fashion Project: Order #" + order.getOrderId() + " confirmed! Total: ₹" + totalAmount + ". Thank you for shopping with us!";
                    SmsService.sendSmsAsync(targetPhone, smsMessage);
                }

                request.setAttribute("orderItems", cartItems);
                request.getRequestDispatcher("/WEB-INF/views/order-success.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to process your order. Please try again.");
                request.setAttribute("loggedInUser", loggedInUser);
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("cartTotal", totalAmount);
                request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); 
            request.setAttribute("errorMessage", "An error occurred while processing your order: " + e.getMessage());
            request.setAttribute("loggedInUser", loggedInUser);
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartTotal", totalAmount);
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
        }
    }

    private User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("loggedInUser");
            if (user == null) {
                user = (User) session.getAttribute("user");
            }
            return user;
        }
        return null;
    }

    private int getCartIdForUser(User user) {
        int cartId = user.getUserId();
        String queryCartIdSQL = "SELECT cart_id FROM cart WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(queryCartIdSQL)) {
            pstmt.setInt(1, user.getUserId());
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cartId = rs.getInt("cart_id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartId;
    }
}