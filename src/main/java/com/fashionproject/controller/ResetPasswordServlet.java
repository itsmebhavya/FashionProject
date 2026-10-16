package com.fashionproject.controller;

import java.io.IOException;

import com.fashionproject.dao.UserDAO;
import com.fashionproject.dao.impl.UserDAOImpl;
import com.fashionproject.util.PasswordValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the reset password view when the user clicks the email link
        request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate that both password fields match
        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
            return;
        }

        // Validate password strength using PasswordValidator
        if (!PasswordValidator.isValid(newPassword)) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one number, and one special character.");
            request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
            return;
        }

        // Validate that email is present
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Invalid password reset session. Please request a new link.");
            request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
            return;
        }

        // Update the password securely in the database
        boolean isUpdated = userDAO.updatePasswordByEmail(email.trim(), newPassword);

        if (isUpdated) {
            // Redirect to login page with a success query parameter
            response.sendRedirect(request.getContextPath() + "/login.jsp?reset=success");
        } else {
            request.setAttribute("errorMessage", "Failed to update password. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
        }
    }
}