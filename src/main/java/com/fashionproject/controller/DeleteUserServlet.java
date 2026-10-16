package com.fashionproject.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionproject.dao.UserDAO;
import com.fashionproject.dao.impl.UserDAOImpl;
import com.fashionproject.model.User;

@WebServlet("/admin/user/delete")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // Security check: Ensure only admins can delete users
        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.trim().isEmpty()) {
                int userId = Integer.parseInt(idParam);
                
                // Prevent admin from accidentally deleting their own currently logged-in account
                if (userId != adminUser.getUserId()) {
                    UserDAO userDAO = new UserDAOImpl();
                    userDAO.deleteUser(userId);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the admin users list
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}