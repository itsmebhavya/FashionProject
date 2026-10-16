package com.fashionproject.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionproject.model.User;
import com.fashionproject.util.DBConnection;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (user == null) {
            user = (session != null) ? (User) session.getAttribute("user") : null;
        }

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if ("remove".equals(action)) {
            removeItem(request, user.getUserId());
            response.sendRedirect(request.getContextPath() + "/wishlist");
            return;
        } else if ("add".equals(action)) {
            addItem(request, user.getUserId());
            response.sendRedirect(request.getContextPath() + "/wishlist");
            return;
        }

        List<WishlistItem> wishlistItems = new ArrayList<>();
        
        String fullSql = "SELECT w.wishlist_id, w.variant_id, p.product_name AS product_name, p.image_url, pv.size, p.price " +
                         "FROM wishlist w JOIN product_variants pv ON w.variant_id = pv.variant_id " +
                         "JOIN products p ON pv.product_id = p.product_id WHERE w.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(fullSql)) {
            pstmt.setInt(1, user.getUserId());
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    WishlistItem item = new WishlistItem();
                    item.setWishlistId(rs.getInt("wishlist_id"));
                    item.setVariantId(rs.getInt("variant_id"));
                    item.setProductName(rs.getString("product_name"));
                    item.setImageUrl(rs.getString("image_url"));
                    item.setSize(rs.getString("size"));
                    item.setPrice(rs.getBigDecimal("price"));
                    wishlistItems.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("wishlistItems", wishlistItems);
        request.getRequestDispatcher("/WEB-INF/views/wishlist.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void addItem(HttpServletRequest request, int userId) {
        try {
            int variantId = Integer.parseInt(request.getParameter("variantId"));
            String checkSql = "SELECT wishlist_id FROM wishlist WHERE user_id = ? AND variant_id = ?";
            String insertSql = "INSERT INTO wishlist (user_id, variant_id) VALUES (?, ?)";
            
            try (Connection conn = DBConnection.getConnection()) {
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setInt(1, userId);
                    checkStmt.setInt(2, variantId);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (!rs.next()) {
                            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                                insertStmt.setInt(1, userId);
                                insertStmt.setInt(2, variantId);
                                insertStmt.executeUpdate();
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void removeItem(HttpServletRequest request, int userId) {
        try {
            int wishlistId = Integer.parseInt(request.getParameter("wishlistId"));
            String sql = "DELETE FROM wishlist WHERE wishlist_id = ? AND user_id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, wishlistId);
                pstmt.setInt(2, userId);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static class WishlistItem {
        private int wishlistId;
        private int variantId;
        private String productName;
        private String imageUrl;
        private String size;
        private java.math.BigDecimal price;

        public int getWishlistId() { return wishlistId; }
        public void setWishlistId(int wishlistId) { this.wishlistId = wishlistId; }
        public int getVariantId() { return variantId; }
        public void setVariantId(int variantId) { this.variantId = variantId; }
        public String getProductName() { return productName; }
        public void setProductName(String productName) { this.productName = productName; }
        public String getImageUrl() { return imageUrl; }
        public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
        public String getSize() { return size; }
        public void setSize(String size) { this.size = size; }
        public java.math.BigDecimal getPrice() { return price; }
        public void setPrice(java.math.BigDecimal price) { this.price = price; }
    }
}