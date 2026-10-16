package com.fashionproject.controller;

import java.io.IOException;

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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/register.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String addressLine1 = request.getParameter("addressLine1");
        String addressLine2 = request.getParameter("addressLine2");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");

        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()
                || addressLine1 == null || addressLine1.trim().isEmpty()
                || city == null || city.trim().isEmpty()
                || state == null || state.trim().isEmpty()
                || pincode == null || pincode.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Please fill all required fields.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Password must contain at least 6 characters.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (!phone.trim().matches("\\d{10}")) {
            request.setAttribute("errorMessage", "Phone number must contain exactly 10 digits.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (!pincode.trim().matches("\\d{6}")) {
            request.setAttribute("errorMessage", "Pincode must contain exactly 6 digits.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.emailExists(email.trim())) {
            request.setAttribute("errorMessage", "An account with this email already exists.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.phoneExists(phone.trim())) {
            request.setAttribute("errorMessage", "An account with this phone number already exists.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setName(name.trim());
        user.setEmail(email.trim());
        
        // Securely hash password using BCrypt via PasswordUtil
        user.setPassword(PasswordUtil.hashPassword(password));
        
        user.setPhone(phone.trim());
        user.setAddressLine1(addressLine1.trim());

        if (addressLine2 != null && !addressLine2.trim().isEmpty()) {
            user.setAddressLine2(addressLine2.trim());
        } else {
            user.setAddressLine2(null);
        }

        user.setCity(city.trim());
        user.setState(state.trim());
        user.setPincode(pincode.trim());
        user.setRole("CUSTOMER");

        boolean isRegistered = userDAO.registerUser(user);

        if (isRegistered) {
            User registeredUser = userDAO.getUserByEmail(email.trim());

            if (registeredUser != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", registeredUser);
            }

            response.sendRedirect(request.getContextPath() + "/products");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}