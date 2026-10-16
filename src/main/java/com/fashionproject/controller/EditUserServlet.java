package com.fashionproject.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.fashionproject.dao.UserDAO;
import com.fashionproject.dao.impl.UserDAOImpl;
import com.fashionproject.model.User;

@WebServlet("/admin/user/edit")
public class EditUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int userId = Integer.parseInt(idParam);
                UserDAO userDao = new UserDAOImpl();
                User user = userDao.getUserById(userId);
                
                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/WEB-INF/views/admin/edit-user.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}