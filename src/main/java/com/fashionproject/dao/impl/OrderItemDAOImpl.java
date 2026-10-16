package com.fashionproject.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.fashionproject.dao.OrderItemDAO;
import com.fashionproject.model.OrderItem;
import com.fashionproject.util.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    private static final String INSERT_SQL = 
        "INSERT INTO order_items (order_id, variant_id, quantity, price) VALUES (?, ?, ?, ?)";
    private static final String SELECT_BY_ID_SQL = 
        "SELECT * FROM order_items WHERE order_item_id = ?";
    private static final String SELECT_BY_ORDER_ID_SQL = 
        "SELECT * FROM order_items WHERE order_id = ?";
    private static final String DELETE_BY_ID_SQL = 
        "DELETE FROM order_items WHERE order_item_id = ?";
    private static final String DELETE_BY_ORDER_ID_SQL = 
        "DELETE FROM order_items WHERE order_id = ?";

    @Override
    public void saveOrderItem(OrderItem orderItem) throws Exception {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_SQL)) {
            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getVariantId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setBigDecimal(4, orderItem.getPrice());
            ps.executeUpdate();
        }
    }

    @Override
    public boolean addOrderItem(OrderItem orderItem) {
        try {
            saveOrderItem(orderItem);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean addOrderItems(List<OrderItem> orderItems) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_SQL)) {
            connection.setAutoCommit(false);
            for (OrderItem item : orderItems) {
                ps.setInt(1, item.getOrderId());
                ps.setInt(2, item.getVariantId());
                ps.setInt(3, item.getQuantity());
                ps.setBigDecimal(4, item.getPrice());
                ps.addBatch();
            }
            ps.executeBatch();
            connection.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public OrderItem getOrderItemById(int orderItemId) {
        OrderItem orderItem = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_BY_ID_SQL)) {
            ps.setInt(1, orderItemId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    orderItem = mapResultSetToOrderItem(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderItem;
    }

    @Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_BY_ORDER_ID_SQL)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapResultSetToOrderItem(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    @Override
    public boolean deleteOrderItem(int orderItemId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_BY_ID_SQL)) {
            ps.setInt(1, orderItemId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteOrderItemsByOrderId(int orderId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_BY_ORDER_ID_SQL)) {
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private OrderItem mapResultSetToOrderItem(ResultSet resultSet) throws Exception {
        OrderItem orderItem = new OrderItem();
        orderItem.setOrderItemId(resultSet.getInt("order_item_id"));
        orderItem.setOrderId(resultSet.getInt("order_id"));
        orderItem.setVariantId(resultSet.getInt("variant_id"));
        orderItem.setQuantity(resultSet.getInt("quantity"));
        
        BigDecimal price = resultSet.getBigDecimal("price");
        orderItem.setPrice(price != null ? price : BigDecimal.ZERO);
        
        return orderItem;
    }
}