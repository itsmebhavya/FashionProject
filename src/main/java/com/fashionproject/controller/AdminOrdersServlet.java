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
import com.fashionproject.dao.impl.OrderDAOImpl;
import com.fashionproject.model.Order;
import com.fashionproject.model.User;

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // Verify if user is logged in and is an ADMIN
        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Fetch all orders using OrderDAO
            OrderDAO orderDAO = new OrderDAOImpl();
            List<Order> orderList = orderDAO.getAllOrders();

            // Pass order list to the admin view
            request.setAttribute("orderList", orderList);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading orders: " + e.getMessage());
        }

        // Forward to the secure WEB-INF admin view
        request.getRequestDispatcher("/WEB-INF/views/admin/admin-orders.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}