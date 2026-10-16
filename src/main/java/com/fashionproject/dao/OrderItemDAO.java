package com.fashionproject.dao;

import java.util.List;
import com.fashionproject.model.OrderItem;

public interface OrderItemDAO {

    void saveOrderItem(OrderItem orderItem) throws Exception;

    boolean addOrderItem(OrderItem orderItem);

    boolean addOrderItems(List<OrderItem> orderItems);

    OrderItem getOrderItemById(int orderItemId);

    List<OrderItem> getOrderItemsByOrderId(int orderId);

    boolean deleteOrderItem(int orderItemId);

    boolean deleteOrderItemsByOrderId(int orderId);
}