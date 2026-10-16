package com.fashionproject.controller;

import com.fashionproject.dao.ProductDAO;
import com.fashionproject.dao.impl.ProductDAOImpl;
import com.fashionproject.model.Product;
import jakarta.servlet.RequestDispatcher;
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

@WebServlet(urlPatterns = {"/", "/home"})
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ProductDAO productDao = new ProductDAOImpl();
            List<Product> rawProducts = productDao.getAllActiveProducts();
            
            List<Product> latestProducts = new ArrayList<>();
            if (rawProducts != null) {
                Map<String, Product> uniqueProductsMap = new LinkedHashMap<>();
                for (Product product : rawProducts) {
                    if (product != null && product.getProductName() != null) {
                        // Use normalized product name as key to prevent identical items from repeating
                        String nameKey = product.getProductName().trim().toLowerCase();
                        uniqueProductsMap.putIfAbsent(nameKey, product);
                    }
                }
                latestProducts = new ArrayList<>(uniqueProductsMap.values());
            }
            
            request.setAttribute("latestProducts", latestProducts);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("latestProducts", new ArrayList<>());
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/home.jsp");
        dispatcher.forward(request, response);
    }
}