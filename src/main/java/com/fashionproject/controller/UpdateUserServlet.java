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

@WebServlet("/admin/user/update")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Read form inputs
            int userId = Integer.parseInt(request.getParameter("userId"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String city = request.getParameter("city");
            String role = request.getParameter("role");

            // Update user using UserDAO
            UserDAO userDAO = new UserDAOImpl();
            User targetUser = userDAO.getUserById(userId);
            
            if (targetUser != null) {
                if (name != null) targetUser.setName(name);
                if (email != null) targetUser.setEmail(email);
                if (phone != null) targetUser.setPhone(phone);
                if (city != null) targetUser.setCity(city);
                if (role != null) targetUser.setRole(role);

                userDAO.updateUser(targetUser);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the admin users list
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}