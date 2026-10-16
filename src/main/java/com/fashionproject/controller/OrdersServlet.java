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

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedInUser = getLoggedInUser(request);
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Fetch all orders belonging to this user
        List<Order> userOrders = orderDAO.getOrdersByUserId(loggedInUser.getUserId());

        request.setAttribute("loggedInUser", loggedInUser);
        request.setAttribute("userOrders", userOrders);

        // Forward to the customer order history view
        request.getRequestDispatcher("/WEB-INF/views/orders.jsp").forward(request, response);
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
}