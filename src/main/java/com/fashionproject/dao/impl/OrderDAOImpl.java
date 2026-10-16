package com.fashionproject.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.fashionproject.dao.OrderDAO;
import com.fashionproject.model.CartItem;
import com.fashionproject.model.Order;
import com.fashionproject.util.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    private static final String INSERT_ORDER_SQL = 
            "INSERT INTO orders " +
            "(user_id, total_amount, payment_method, order_status, " +
            " delivery_name, delivery_phone, address_line1, " +
            " address_line2, city, state, " +
            " pincode, country) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String GET_ORDER_BY_ID_SQL = 
            "SELECT * FROM orders " +
            "WHERE order_id = ?";

    private static final String GET_ORDERS_BY_USER_ID_SQL = 
            "SELECT * FROM orders " +
            "WHERE user_id = ? " +
            "ORDER BY order_date DESC";

    private static final String GET_ALL_ORDERS_SQL = 
            "SELECT * FROM orders " +
            "ORDER BY order_date DESC";

    private static final String UPDATE_ORDER_STATUS_SQL = 
            "UPDATE orders " +
            "SET order_status = ? " +
            "WHERE order_id = ?";

    private static final String DELETE_ORDER_SQL = 
            "DELETE FROM orders " +
            "WHERE order_id = ?";

    @Override
    public int saveOrder(Order order) throws Exception {
        int generatedId = -1;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(
                             INSERT_ORDER_SQL,
                             Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setBigDecimal(2, order.getTotalAmount());
            preparedStatement.setString(3, order.getPaymentMethod());
            preparedStatement.setString(4, order.getOrderStatus());
            preparedStatement.setString(5, order.getDeliveryName());
            preparedStatement.setString(6, order.getDeliveryPhone());
            preparedStatement.setString(7, order.getDeliveryAddressLine1());
            preparedStatement.setString(8, order.getDeliveryAddressLine2());
            preparedStatement.setString(9, order.getDeliveryCity());
            preparedStatement.setString(10, order.getDeliveryState());
            preparedStatement.setString(11, order.getDeliveryPincode());
            preparedStatement.setString(12, order.getDeliveryCountry());

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet resultSet = preparedStatement.getGeneratedKeys()) {
                    if (resultSet.next()) {
                        generatedId = resultSet.getInt(1);
                        order.setOrderId(generatedId);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

        return generatedId;
    }

    @Override
    public boolean createOrder(Order order, List<CartItem> cartItems) {
        Connection connection = null;
        try {
            connection = DBConnection.getConnection();
            connection.setAutoCommit(false);

            int orderId = -1;
            try (PreparedStatement orderStmt = connection.prepareStatement(INSERT_ORDER_SQL, Statement.RETURN_GENERATED_KEYS)) {
                orderStmt.setInt(1, order.getUserId());
                orderStmt.setBigDecimal(2, order.getTotalAmount());
                orderStmt.setString(3, order.getPaymentMethod());
                orderStmt.setString(4, order.getOrderStatus());
                orderStmt.setString(5, order.getDeliveryName());
                orderStmt.setString(6, order.getDeliveryPhone());
                orderStmt.setString(7, order.getDeliveryAddressLine1());
                orderStmt.setString(8, order.getDeliveryAddressLine2());
                orderStmt.setString(9, order.getDeliveryCity());
                orderStmt.setString(10, order.getDeliveryState());
                orderStmt.setString(11, order.getDeliveryPincode());
                orderStmt.setString(12, order.getDeliveryCountry());

                int affectedRows = orderStmt.executeUpdate();
                if (affectedRows > 0) {
                    try (ResultSet rs = orderStmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            orderId = rs.getInt(1);
                            order.setOrderId(orderId);
                        }
                    }
                }
            }

            if (orderId == -1) {
                connection.rollback();
                return false;
            }

            String itemSql = "INSERT INTO order_items (order_id, variant_id, quantity, price) VALUES (?, ?, ?, ?)";
            try (PreparedStatement itemStmt = connection.prepareStatement(itemSql)) {
                for (CartItem item : cartItems) {
                    itemStmt.setInt(1, orderId);
                    itemStmt.setInt(2, item.getVariantId());
                    itemStmt.setInt(3, item.getQuantity());
                    itemStmt.setBigDecimal(4, BigDecimal.valueOf(item.getPrice()));
                    itemStmt.addBatch();
                }
                itemStmt.executeBatch();
            }

            connection.commit();
            return true;

        } catch (Exception e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public boolean placeOrder(Order order) {
        try {
            return saveOrder(order) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Order getOrderById(int orderId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(GET_ORDER_BY_ID_SQL)) {

            preparedStatement.setInt(1, orderId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToOrder(resultSet);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(GET_ORDERS_BY_USER_ID_SQL)) {

            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    orders.add(mapResultSetToOrder(resultSet));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(GET_ALL_ORDERS_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                orders.add(mapResultSetToOrder(resultSet));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public boolean updateOrderStatus(int orderId, String orderStatus) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(UPDATE_ORDER_STATUS_SQL)) {

            preparedStatement.setString(1, orderStatus);
            preparedStatement.setInt(2, orderId);

            return preparedStatement.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteOrder(int orderId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(DELETE_ORDER_SQL)) {

            preparedStatement.setInt(1, orderId);

            return preparedStatement.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private Order mapResultSetToOrder(ResultSet resultSet) throws Exception {
        Order order = new Order();

        int orderId = resultSet.getInt("order_id");
        order.setOrderId(orderId);
        order.setUserId(resultSet.getInt("user_id"));
        order.setOrderDate(resultSet.getTimestamp("order_date"));
        order.setTotalAmount(resultSet.getBigDecimal("total_amount"));
        order.setPaymentMethod(resultSet.getString("payment_method"));
        order.setOrderStatus(resultSet.getString("order_status"));

        order.setDeliveryName(resultSet.getString("delivery_name"));
        order.setDeliveryPhone(resultSet.getString("delivery_phone"));
        order.setDeliveryAddressLine1(resultSet.getString("address_line1"));
        order.setDeliveryAddressLine2(resultSet.getString("address_line2"));
        order.setDeliveryCity(resultSet.getString("city"));
        order.setDeliveryState(resultSet.getString("state"));
        order.setDeliveryPincode(resultSet.getString("pincode"));
        order.setDeliveryCountry(resultSet.getString("country"));

        // Fetch items associated with this order
        order.setOrderItems(getOrderItemsForOrder(orderId));

        return order;
    }

    private List<com.fashionproject.model.OrderItem> getOrderItemsForOrder(int orderId) {
        List<com.fashionproject.model.OrderItem> items = new ArrayList<>();
        
        // Explicitly fetching product_id so that individual product links work correctly
        String sql = "SELECT oi.*, p.product_id AS product_id, p.product_name AS product_name, p.image_url AS image_url " +
                     "FROM order_items oi " +
                     "LEFT JOIN product_variants v ON oi.variant_id = v.variant_id " +
                     "LEFT JOIN products p ON v.product_id = p.product_id " +
                     "WHERE oi.order_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    com.fashionproject.model.OrderItem item = new com.fashionproject.model.OrderItem();
                    item.setOrderItemId(rs.getInt("order_item_id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setVariantId(rs.getInt("variant_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setProductName(rs.getString("product_name"));
                    item.setImageUrl(rs.getString("image_url"));
                    items.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }
}