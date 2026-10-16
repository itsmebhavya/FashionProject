package com.fashionproject.controller;

import java.io.IOException;

import com.fashionproject.dao.UserDAO;
import com.fashionproject.dao.impl.UserDAOImpl;
import com.fashionproject.util.EmailService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email address is required.");
            request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
            return;
        }

        // Check if email exists in the database
        if (!userDAO.emailExists(email.trim())) {
            request.setAttribute("errorMessage", "No account found with this email address.");
            request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
            return;
        }

        // Compose the reset email with a link containing their email
        String subject = "Password Reset Request - Fashion Project";
        String resetLink = "http://localhost:8080/FashionProject/reset-password?email=" + email.trim();
        String body = "Hello,\n\nWe received a request to reset your password. Click the link below to proceed:\n" 
                    + resetLink 
                    + "\n\nIf you didn't request this, please ignore this email.";

        // Send email via EmailService
        boolean isSent = EmailService.sendEmail(email.trim(), subject, body);

        if (isSent) {
            request.setAttribute("successMessage", "Password reset link has been sent to your email!");
        } else {
            request.setAttribute("errorMessage", "Failed to send email. Please check your SMTP configuration.");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
    }
}