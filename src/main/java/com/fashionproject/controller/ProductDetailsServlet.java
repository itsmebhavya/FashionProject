package com.fashionproject.controller;

import com.fashionproject.dao.ProductDAO;
import com.fashionproject.dao.impl.ProductDAOImpl;
import com.fashionproject.model.Product;
import com.fashionproject.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/product-detail")
public class ProductDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final ProductDAO productDao = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }
            
            int productId = Integer.parseInt(idParam);

            Product product = productDao.getProductById(productId);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            List<ProductVariant> variants = productDao.getVariantsByProductId(productId);

            List<Product> relatedProducts = new ArrayList<>();
            try {
                List<Product> rawRelated = productDao.getProductsByCategory(product.getCategoryId());
                Map<String, Product> uniqueRelatedMap = new LinkedHashMap<>();
                if (rawRelated != null) {
                    for (Product p : rawRelated) {
                        if (p.getProductName() != null && p.getProductId() != productId) {
                            String nameKey = p.getProductName().trim().toLowerCase();
                            uniqueRelatedMap.putIfAbsent(nameKey, p);
                        }
                    }
                }
                relatedProducts = new ArrayList<>(uniqueRelatedMap.values());
            } catch (Exception e) {
                // Ignore if unavailable
            }

            request.setAttribute("product", product);
            request.setAttribute("variants", variants);
            request.setAttribute("relatedProducts", relatedProducts);

            request.getRequestDispatcher("/WEB-INF/views/product-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while loading product details.");
        }
    }
}