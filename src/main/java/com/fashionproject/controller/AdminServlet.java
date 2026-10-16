package com.fashionproject.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionproject.dao.ProductDAO;
import com.fashionproject.dao.UserDAO;
import com.fashionproject.dao.impl.ProductDAOImpl;
import com.fashionproject.dao.impl.UserDAOImpl;
import com.fashionproject.model.Order;
import com.fashionproject.model.Product;
import com.fashionproject.model.User;
import com.fashionproject.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/dashboard")
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAOImpl();
    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        // Verify if the user is logged in and has an ADMIN role
        if (loggedInUser == null || !"ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            updateOrderStatus(request);
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // Fetch all users to display in the admin panel
        List<User> userList = userDAO.getAllUsers();
        request.setAttribute("userList", userList);

        // Fetch all products to populate the dynamic product catalog preview section
        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("productList", productList);
        
        // Calculate metrics using database count instead of max product ID
        int prodSize = productDAO.getTotalProductsCount();
        int extraProd = Math.max(0, prodSize - 3);
        
        request.setAttribute("prodSize", prodSize);
        request.setAttribute("extraProd", extraProd);
        
        // Pre-format dynamic display strings
        request.setAttribute("extraProdDisplay", "+" + extraProd);
        request.setAttribute("defaultPlusDisplay", "+" + extraProd);

        // Fetch Order Statistics & Orders list for management
        BigDecimal totalRevenue = BigDecimal.ZERO;
        int totalOrders = 0;
        List<Order> allOrders = new ArrayList<>();

        String statsSql = "SELECT COUNT(*), SUM(total_amount) FROM orders";
        String ordersSql = "SELECT * FROM orders ORDER BY order_date DESC";

        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement pstmt = conn.prepareStatement(statsSql);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    totalOrders = rs.getInt(1);
                    BigDecimal rev = rs.getBigDecimal(2);
                    if (rev != null) totalRevenue = rev;
                }
            }

            try (PreparedStatement pstmt = conn.prepareStatement(ordersSql);
                 ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    allOrders.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("allOrders", allOrders);

        // Forward to the admin dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/admin-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void updateOrderStatus(HttpServletRequest request) {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, status);
                pstmt.setInt(2, orderId);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}