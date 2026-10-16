package com.fashionproject.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fashionproject.dao.CartItemDAO;
import com.fashionproject.model.CartItem;
import com.fashionproject.util.DBConnection;

public class CartItemDAOImpl implements CartItemDAO {

    private static final String INSERT_CART_ITEM_SQL = 
        "INSERT INTO cart_items (cart_id, variant_id, quantity) VALUES (?, ?, ?)";

    private static final String UPDATE_CART_ITEM_QUANTITY_SQL = 
        "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";

    private static final String UPDATE_CART_ITEM_QUANTITY_BY_CART_AND_VARIANT_SQL = 
        "UPDATE cart_items SET quantity = ? WHERE cart_id = ? AND variant_id = ?";

    private static final String DELETE_CART_ITEM_SQL = 
        "DELETE FROM cart_items WHERE cart_item_id = ?";

    private static final String DELETE_CART_ITEM_BY_CART_AND_VARIANT_SQL = 
        "DELETE FROM cart_items WHERE cart_id = ? AND variant_id = ?";

    // 💡 Added pv.product_id to the SELECT statements
    private static final String GET_CART_ITEM_BY_ID_SQL = 
        "SELECT ci.*, pv.product_id, p.product_name, p.image_url, pv.size, p.price " +
        "FROM cart_items ci " +
        "JOIN product_variants pv ON ci.variant_id = pv.variant_id " +
        "JOIN products p ON pv.product_id = p.product_id " +
        "WHERE ci.cart_item_id = ?";

    private static final String GET_CART_ITEM_BY_CART_AND_VARIANT_SQL = 
        "SELECT ci.*, pv.product_id, p.product_name, p.image_url, pv.size, p.price " +
        "FROM cart_items ci " +
        "JOIN product_variants pv ON ci.variant_id = pv.variant_id " +
        "JOIN products p ON pv.product_id = p.product_id " +
        "WHERE ci.cart_id = ? AND ci.variant_id = ?";

    private static final String GET_CART_ITEMS_BY_CART_ID_SQL = 
        "SELECT ci.*, pv.product_id, p.product_name, p.image_url, pv.size, p.price " +
        "FROM cart_items ci " +
        "JOIN product_variants pv ON ci.variant_id = pv.variant_id " +
        "JOIN products p ON pv.product_id = p.product_id " +
        "WHERE ci.cart_id = ?";

    private static final String CLEAR_CART_SQL = 
        "DELETE FROM cart_items WHERE cart_id = ?";

    private static final String GET_CART_ITEM_COUNT_SQL = 
        "SELECT SUM(quantity) FROM cart_items WHERE cart_id = ?";

    @Override
    public boolean addCartItem(CartItem cartItem) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CART_ITEM_SQL)) {

            preparedStatement.setInt(1, cartItem.getCartId());
            preparedStatement.setInt(2, cartItem.getVariantId());
            preparedStatement.setInt(3, cartItem.getQuantity());

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateCartItemQuantity(int cartItemId, int quantity) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CART_ITEM_QUANTITY_SQL)) {

            preparedStatement.setInt(1, quantity);
            preparedStatement.setInt(2, cartItemId);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateCartItemQuantityByCartAndVariant(int cartId, int variantId, int quantity) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CART_ITEM_QUANTITY_BY_CART_AND_VARIANT_SQL)) {

            preparedStatement.setInt(1, quantity);
            preparedStatement.setInt(2, cartId);
            preparedStatement.setInt(3, variantId);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean removeCartItem(int cartItemId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_CART_ITEM_SQL)) {

            preparedStatement.setInt(1, cartItemId);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean removeCartItemByCartAndVariant(int cartId, int variantId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_CART_ITEM_BY_CART_AND_VARIANT_SQL)) {

            preparedStatement.setInt(1, cartId);
            preparedStatement.setInt(2, variantId);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public CartItem getCartItemById(int cartItemId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_CART_ITEM_BY_ID_SQL)) {

            preparedStatement.setInt(1, cartItemId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToCartItem(resultSet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public CartItem getCartItemByCartIdAndVariantId(int cartId, int variantId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_CART_ITEM_BY_CART_AND_VARIANT_SQL)) {

            preparedStatement.setInt(1, cartId);
            preparedStatement.setInt(2, variantId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToCartItem(resultSet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<CartItem> getCartItemsByCartId(int cartId) {
        List<CartItem> cartItems = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_CART_ITEMS_BY_CART_ID_SQL)) {

            preparedStatement.setInt(1, cartId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    cartItems.add(mapResultSetToCartItem(resultSet));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    @Override
    public boolean clearCart(int cartId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CLEAR_CART_SQL)) {

            preparedStatement.setInt(1, cartId);

            return preparedStatement.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public int getCartItemCount(int cartId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_CART_ITEM_COUNT_SQL)) {

            preparedStatement.setInt(1, cartId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private CartItem mapResultSetToCartItem(ResultSet resultSet) throws SQLException {
        CartItem cartItem = new CartItem();
        cartItem.setCartItemId(resultSet.getInt("cart_item_id"));
        cartItem.setCartId(resultSet.getInt("cart_id"));
        cartItem.setVariantId(resultSet.getInt("variant_id"));
        
        // 💡 Map the product_id coming from pv.product_id in the SQL query
        cartItem.setProductId(resultSet.getInt("product_id"));
        
        cartItem.setQuantity(resultSet.getInt("quantity"));
        
        // Populate joined product details
        cartItem.setProductName(resultSet.getString("product_name"));
        cartItem.setImageUrl(resultSet.getString("image_url"));
        cartItem.setSize(resultSet.getString("size"));
        cartItem.setPrice(resultSet.getBigDecimal("price"));
        
        return cartItem;
    }
}