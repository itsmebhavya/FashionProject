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
import com.fashionproject.model.Order;
import com.fashionproject.model.User;

@WebServlet("/admin/order-details")
public class OrderDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // Verify admin authentication
        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            System.out.println("DEBUG: Admin authentication failed.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String idParam = request.getParameter("id");
            System.out.println("DEBUG: Received idParam = " + idParam);
            
            if (idParam != null && !idParam.trim().isEmpty()) {
                int orderId = Integer.parseInt(idParam);
                
                OrderDAO orderDAO = new OrderDAOImpl();
                Order order = orderDAO.getOrderById(orderId);
                
                System.out.println("DEBUG: Fetched order object = " + order);
                
                if (order != null) {
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("/WEB-INF/views/admin/order-details.jsp").forward(request, response);
                    return;
                } else {
                    System.out.println("DEBUG: Order not found in database for ID: " + orderId);
                }
            }
        } catch (Exception e) {
            System.out.println("DEBUG: Exception caught in OrderDetailsServlet:");
            e.printStackTrace();
        }
        
        // Fallback redirect if the order ID is missing, order is null, or an exception occurred
        System.out.println("DEBUG: Triggering fallback redirect to /admin/orders");
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}