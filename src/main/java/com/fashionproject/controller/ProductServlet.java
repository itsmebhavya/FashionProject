package com.fashionproject.controller;

import com.fashionproject.dao.CategoryDAO;
import com.fashionproject.dao.ProductDAO;
import com.fashionproject.dao.impl.CategoryDAOImpl;
import com.fashionproject.dao.impl.ProductDAOImpl;
import com.fashionproject.model.Category;
import com.fashionproject.model.Product;
import com.fashionproject.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/products", "/product"})
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAOImpl();
    private final CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if an individual product ID is requested (e.g., /product?id=1)
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(idStr);
                Product product = productDAO.getProductById(productId);
                
                if (product != null) {
                    List<ProductVariant> variants = productDAO.getVariantsByProductId(productId);
                    request.setAttribute("product", product);
                    request.setAttribute("variants", variants);
                    request.getRequestDispatcher("/WEB-INF/views/product-details.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException ignored) {}
        }

        // Otherwise, handle the standard product filtering, searching, and catalog listing
        String keyword = request.getParameter("keyword");
        if (keyword == null || keyword.trim().isEmpty()) {
            keyword = request.getParameter("search");
        }

        String categoryIdStr = request.getParameter("categoryId");
        String categoryParam = request.getParameter("category");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String sortBy = request.getParameter("sortBy");

        Integer categoryId = null;

        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException ignored) {}
        } 
        else if (categoryParam != null && !categoryParam.trim().isEmpty()) {
            try {
                List<Category> allCategories = categoryDAO.getAllCategories();
                for (Category cat : allCategories) {
                    if (cat.getCategoryName().equalsIgnoreCase(categoryParam.trim())) {
                        categoryId = cat.getCategoryId();
                        break;
                    }
                }
            } catch (Exception ignored) {}
        }

        BigDecimal minPrice = null;
        if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
            try {
                minPrice = new BigDecimal(minPriceStr);
            } catch (NumberFormatException ignored) {}
        }

        BigDecimal maxPrice = null;
        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            try {
                maxPrice = new BigDecimal(maxPriceStr);
            } catch (NumberFormatException ignored) {}
        }

        List<Product> rawProductList = productDAO.getFilteredProducts(keyword, categoryId, minPrice, maxPrice, sortBy);
        
        Map<String, Product> uniqueProductsMap = new LinkedHashMap<>();
        if (rawProductList != null) {
            for (Product product : rawProductList) {
                if (product.getProductName() != null) {
                    String nameKey = product.getProductName().trim().toLowerCase();
                    if (!uniqueProductsMap.containsKey(nameKey)) {
                        uniqueProductsMap.put(nameKey, product);
                    }
                }
            }
        }
        List<Product> productList = new ArrayList<>(uniqueProductsMap.values());

        List<Category> categoryList = categoryDAO.getAllCategories();

        request.setAttribute("products", productList);
        request.setAttribute("categories", categoryList);
        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}