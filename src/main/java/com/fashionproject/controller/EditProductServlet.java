package com.fashionproject.controller;

import com.fashionproject.dao.CategoryDAO;
import com.fashionproject.dao.ProductDAO;
import com.fashionproject.dao.impl.CategoryDAOImpl;
import com.fashionproject.dao.impl.ProductDAOImpl;
import com.fashionproject.model.Category;
import com.fashionproject.model.Product;
import com.fashionproject.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin/edit-product")
public class EditProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    public void init() {
        productDAO = new ProductDAOImpl();
        categoryDAO = new CategoryDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Validate admin session
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int productId = Integer.parseInt(idStr);
                Product product = productDAO.getProductById(productId);
                
                if (product != null) {
                    // Fetch categories for the dropdown menu
                    List<Category> categoryList = categoryDAO.getAllCategories();
                    
                    request.setAttribute("product", product);
                    request.setAttribute("categoryList", categoryList);
                    
                    request.getRequestDispatcher("/WEB-INF/views/admin/edit-product.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Validate admin session
        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String productName = request.getParameter("productName");
            String brand = request.getParameter("brand");
            String description = request.getParameter("description");
            
            String priceStr = request.getParameter("price");
            BigDecimal price = (priceStr != null && !priceStr.trim().isEmpty()) ? new BigDecimal(priceStr) : BigDecimal.ZERO;
            
            String color = request.getParameter("color");
            String imageUrl = request.getParameter("imageUrl");
            boolean isActive = request.getParameter("isActive") != null; // True if checkbox is checked

            Product product = new Product();
            product.setProductId(productId);
            product.setCategoryId(categoryId);
            product.setProductName(productName);
            product.setBrand(brand);
            product.setDescription(description);
            product.setPrice(price);
            product.setColor(color);
            product.setImageUrl(imageUrl);
            product.setActive(isActive);

            productDAO.updateProduct(product);

            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products?error=update_failed");
        }
    }
}