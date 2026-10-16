package com.fashionproject.dao;

import java.util.List;
import com.fashionproject.model.Order;
import com.fashionproject.model.CartItem;

public interface OrderDAO {

    int saveOrder(Order order) throws Exception;

    boolean createOrder(Order order, List<CartItem> cartItems);

    boolean placeOrder(Order order);

    Order getOrderById(int orderId);

    List<Order> getOrdersByUserId(int userId);

    List<Order> getAllOrders();

    boolean updateOrderStatus(int orderId, String orderStatus);

    boolean deleteOrder(int orderId);
}