package com.fashionproject.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionproject.dao.OrderDAO;
import com.fashionproject.dao.OrderItemDAO;
import com.fashionproject.dao.impl.OrderDAOImpl;
import com.fashionproject.dao.impl.OrderItemDAOImpl;
import com.fashionproject.model.Order;
import com.fashionproject.model.OrderItem;
import com.fashionproject.model.User;

@WebServlet("/order-confirmation")
public class OrderConfirmationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAOImpl();
    private final OrderItemDAO orderItemDAO = new OrderItemDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr != null) {
                int orderId = Integer.parseInt(orderIdStr);
                Order order = orderDAO.getOrderById(orderId);
                
                // Fixed to match the method name defined in your OrderItemDAO interface
                List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrderId(orderId);

                request.setAttribute("order", order);
                request.setAttribute("orderItems", orderItems);
            }

            request.getRequestDispatcher("/WEB-INF/views/order-confirmation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home?error=server");
        }
    }
}