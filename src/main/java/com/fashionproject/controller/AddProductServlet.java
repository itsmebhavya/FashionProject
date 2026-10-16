package com.fashionproject.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionproject.dao.CategoryDAO;
import com.fashionproject.dao.ProductDAO;
import com.fashionproject.dao.impl.CategoryDAOImpl;
import com.fashionproject.dao.impl.ProductDAOImpl;
import com.fashionproject.model.Category;
import com.fashionproject.model.Product;
import com.fashionproject.model.User;

@WebServlet({"/admin/add-product", "/admin/product/add"})
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            CategoryDAO categoryDAO = new CategoryDAOImpl();
            List<Category> categoryList = categoryDAO.getAllCategories();
            request.setAttribute("categoryList", categoryList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/add-product.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String productName = request.getParameter("productName");
            String brand = request.getParameter("brand");
            String description = request.getParameter("description");
            
            String priceStr = request.getParameter("price");
            BigDecimal price = (priceStr != null && !priceStr.trim().isEmpty()) ? new BigDecimal(priceStr) : BigDecimal.ZERO;
            
            String color = request.getParameter("color");
            String imageUrl = request.getParameter("imageUrl");

            Product product = new Product();
            product.setCategoryId(categoryId);
            product.setProductName(productName);
            product.setBrand(brand);
            product.setDescription(description);
            product.setPrice(price);
            product.setColor(color);
            product.setImageUrl(imageUrl);
            product.setActive(true);

            ProductDAO productDAO = new ProductDAOImpl();
            productDAO.addProduct(product);

            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/add-product?error=1");
        }
    }
}