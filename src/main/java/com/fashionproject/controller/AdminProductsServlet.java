package com.fashionproject.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionproject.dao.ProductDAO;
import com.fashionproject.dao.impl.ProductDAOImpl;
import com.fashionproject.model.Product;
import com.fashionproject.model.User;

@WebServlet("/admin/products")
public class AdminProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // Verify if user is logged in and is an ADMIN
        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch all products using your ProductDAO
        ProductDAO productDAO = new ProductDAOImpl();
        List<Product> productList = productDAO.getAllProducts();

        // Pass product list to the admin view
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("/WEB-INF/views/admin/admin-products.jsp").forward(request, response);
    }
}