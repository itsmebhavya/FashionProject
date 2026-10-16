package com.fashionproject.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionproject.dao.OrderDAO;
import com.fashionproject.dao.impl.OrderDAOImpl;
import com.fashionproject.model.User;

@WebServlet("/admin/order/update-status")
public class UpdateOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Read order ID and new status
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("orderStatus");

        // Update status using OrderDAO
        OrderDAO orderDAO = new OrderDAOImpl();
        orderDAO.updateOrderStatus(orderId, newStatus);

        // Redirect back to the admin orders list
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}