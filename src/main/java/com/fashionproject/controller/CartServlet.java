package com.fashionproject.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionproject.dao.CartItemDAO;
import com.fashionproject.dao.impl.CartItemDAOImpl;
import com.fashionproject.model.CartItem;
import com.fashionproject.model.User;
import com.fashionproject.util.DBConnection;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CartItemDAO cartItemDAO = new CartItemDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedInUser = getLoggedInUser(request);
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "view";
        }

        switch (action) {
            case "add":
                addItemToCart(request, response, loggedInUser);
                break;
            case "update":
                updateCartItem(request, response);
                break;
            case "remove":
                removeCartItem(request, response);
                break;
            case "clear":
                clearCart(request, response, loggedInUser);
                break;
            case "view":
            default:
                viewCart(request, response, loggedInUser);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("loggedInUser");
            if (user == null) {
                user = (User) session.getAttribute("user");
            }
            return user;
        }
        return null;
    }

    private int getOrCreateCartId(User user) {
        int cartId = user.getUserId();
        String queryCartIdSQL = "SELECT cart_id FROM cart WHERE user_id = ?";
        String createCartSQL = "INSERT INTO cart (user_id) VALUES (?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(queryCartIdSQL)) {
            
            pstmt.setInt(1, user.getUserId());
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cartId = rs.getInt("cart_id");
                } else {
                    try (PreparedStatement insertPstmt = conn.prepareStatement(createCartSQL, Statement.RETURN_GENERATED_KEYS)) {
                        insertPstmt.setInt(1, user.getUserId());
                        insertPstmt.executeUpdate();
                        try (ResultSet generatedKeys = insertPstmt.getGeneratedKeys()) {
                            if (generatedKeys.next()) {
                                cartId = generatedKeys.getInt(1);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartId;
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        int cartId = getOrCreateCartId(user);
        List<CartItem> cartItems = cartItemDAO.getCartItemsByCartId(cartId);
        int itemCount = cartItemDAO.getCartItemCount(cartId);

        BigDecimal cartTotal = BigDecimal.ZERO;
        if (cartItems != null) {
            for (CartItem item : cartItems) {
                BigDecimal itemPrice = BigDecimal.valueOf(item.getPrice());
                BigDecimal itemSubtotal = itemPrice.multiply(BigDecimal.valueOf(item.getQuantity()));
                cartTotal = cartTotal.add(itemSubtotal);
            }
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("itemCount", itemCount);
        request.setAttribute("cartTotal", cartTotal);

        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }

    private void addItemToCart(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        int cartId = getOrCreateCartId(user);

        try {
            String variantIdParam = request.getParameter("variantId");
            String quantityParam = request.getParameter("quantity");

            if (variantIdParam != null && quantityParam != null) {
                int variantId = Integer.parseInt(variantIdParam);
                int quantity = Integer.parseInt(quantityParam);

                CartItem existingItem = cartItemDAO.getCartItemByCartIdAndVariantId(cartId, variantId);
                if (existingItem != null) {
                    int newQty = existingItem.getQuantity() + quantity;
                    cartItemDAO.updateCartItemQuantity(existingItem.getCartItemId(), newQty);
                } else {
                    CartItem newItem = new CartItem();
                    newItem.setCartId(cartId);
                    newItem.setVariantId(variantId);
                    newItem.setQuantity(quantity);
                    cartItemDAO.addCartItem(newItem);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }

    private void updateCartItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String cartItemIdParam = request.getParameter("cartItemId");
            if (cartItemIdParam == null) {
                cartItemIdParam = request.getParameter("id");
            }
            
            String quantityParam = request.getParameter("quantity");
            String ajaxParam = request.getParameter("ajax");

            if (cartItemIdParam != null && quantityParam != null) {
                int cartItemId = Integer.parseInt(cartItemIdParam);
                int quantity = Integer.parseInt(quantityParam);
                
                if (quantity > 0) {
                    cartItemDAO.updateCartItemQuantity(cartItemId, quantity);
                } else {
                    cartItemDAO.removeCartItem(cartItemId);
                }

                // If AJAX request, return calculated JSON response instead of redirecting
                if ("true".equals(ajaxParam)) {
                    User user = getLoggedInUser(request);
                    int cartId = getOrCreateCartId(user);
                    
                    List<CartItem> cartItems = cartItemDAO.getCartItemsByCartId(cartId);
                    BigDecimal cartTotal = BigDecimal.ZERO;
                    BigDecimal updatedItemSubtotal = BigDecimal.ZERO;

                    if (cartItems != null) {
                        for (CartItem item : cartItems) {
                            BigDecimal itemPrice = BigDecimal.valueOf(item.getPrice());
                            BigDecimal itemSubtotal = itemPrice.multiply(BigDecimal.valueOf(item.getQuantity()));
                            if (item.getCartItemId() == cartItemId) {
                                updatedItemSubtotal = itemSubtotal;
                            }
                            cartTotal = cartTotal.add(itemSubtotal);
                        }
                    }

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(String.format(
                        "{\"success\": true, \"itemSubtotal\": \"%.2f\", \"cartTotal\": \"%.2f\"}",
                        updatedItemSubtotal, cartTotal
                    ));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            if ("true".equals(request.getParameter("ajax"))) {
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false}");
                return;
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }

    private void removeCartItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String cartItemIdParam = request.getParameter("cartItemId");
            if (cartItemIdParam == null) {
                cartItemIdParam = request.getParameter("id");
            }
            
            if (cartItemIdParam != null) {
                int cartItemId = Integer.parseInt(cartItemIdParam);
                cartItemDAO.removeCartItem(cartItemId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }

    private void clearCart(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        int cartId = getOrCreateCartId(user);
        cartItemDAO.clearCart(cartId);
        
        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }
}