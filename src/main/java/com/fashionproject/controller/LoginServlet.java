package com.fashionproject.controller;

import java.io.IOException;
import java.util.Random;

import com.fashionproject.dao.UserDAO;
import com.fashionproject.dao.impl.UserDAOImpl;
import com.fashionproject.model.User;
import com.fashionproject.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/login.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);

        String loginType = request.getParameter("loginType");

        // ==========================================
        // FLOW 1: MOBILE NUMBER & OTP LOGIN
        // ==========================================
        if ("otp".equals(loginType)) {
            String action = request.getParameter("action");
            String phone = request.getParameter("phone");

            if (phone == null || phone.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please enter your mobile number.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            }

            // Checks the 'phone' column in your database via DAO
            User user = userDAO.getUserByPhone(phone.trim());
            if (user == null) {
                request.setAttribute("errorMessage", "No account found with this mobile number.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            }

            if ("sendOtp".equals(action)) {
                String generatedOtp = String.format("%06d", new Random().nextInt(1000000));
                
                session.setAttribute("generatedOtp", generatedOtp);
                session.setAttribute("otpPhone", phone.trim());

                // For testing/development, the OTP is displayed right on screen
                System.out.println("=== DEV OTP FOR " + phone + ": " + generatedOtp + " ===");
                
                request.setAttribute("successMessage", "OTP sent successfully! (Dev OTP: " + generatedOtp + ")");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            } 
            else if ("verifyOtp".equals(action)) {
                String enteredOtp = request.getParameter("otp");
                String sessionOtp = (String) session.getAttribute("generatedOtp");
                String sessionPhone = (String) session.getAttribute("otpPhone");

                if (sessionOtp == null || sessionPhone == null || !phone.trim().equals(sessionPhone)) {
                    request.setAttribute("errorMessage", "Please request a new OTP first.");
                    request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                    return;
                }

                if (sessionOtp.equals(enteredOtp)) {
                    session.removeAttribute("generatedOtp");
                    session.removeAttribute("otpPhone");

                    session.invalidate();
                    HttpSession newSession = request.getSession(true);
                    newSession.setAttribute("loggedInUser", user);

                    if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/products");
                    }
                    return;
                } else {
                    request.setAttribute("errorMessage", "Invalid OTP. Please try again.");
                    request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                    return;
                }
            }
        }

        // ==========================================
        // FLOW 2: STANDARD EMAIL & PASSWORD LOGIN
        // ==========================================
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()
                || password == null || password.isEmpty()) {

            request.setAttribute("errorMessage", "Please enter email and password.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.getUserByEmail(email.trim());
        boolean isAuthenticated = false;

        if (user != null && user.getPassword() != null) {
            String storedHash = user.getPassword();
            
            if (storedHash.startsWith("$2a$") || storedHash.startsWith("$2b$") || storedHash.startsWith("$2y$")) {
                isAuthenticated = PasswordUtil.checkPassword(password, storedHash);
            } else {
                isAuthenticated = storedHash.equals(password);
            }
        }

        if (isAuthenticated) {
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("loggedInUser", user);

            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/products");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}