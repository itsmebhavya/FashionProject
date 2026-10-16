package com.fashionproject.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionproject.dao.UserDAO;
import com.fashionproject.dao.impl.UserDAOImpl;
import com.fashionproject.model.User;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // Verify if user is logged in and is an ADMIN
        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch all users from database using DAO
        UserDAO userDAO = new UserDAOImpl();
        List<User> userList = userDAO.getAllUsers();

        // Pass list to JSP view inside WEB-INF/views/admin/
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/WEB-INF/views/admin/admin-users.jsp").forward(request, response);
    }
}