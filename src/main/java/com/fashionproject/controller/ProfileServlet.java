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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Fetch fresh user details from database
        User user = userDAO.getUserById(loggedInUser.getUserId());
        request.setAttribute("user", user);

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String name = request.getParameter("name");
        String email = request.getParameter("email");

        loggedInUser.setName(name);
        loggedInUser.setEmail(email);

        boolean updated = userDAO.updateUser(loggedInUser);

        if (updated) {
            session.setAttribute("loggedInUser", loggedInUser);
            request.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
        }

        request.setAttribute("user", loggedInUser);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
}