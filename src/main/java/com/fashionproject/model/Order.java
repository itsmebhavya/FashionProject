package com.fashionproject.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order {
    private int orderId;
    private int userId;
    private String customerName;
    private Date orderDate;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private String orderStatus;

    private String deliveryName;
    private String deliveryPhone;
    private String deliveryAddressLine1;
    private String deliveryAddressLine2;
    private String deliveryCity;
    private String deliveryState;
    private String deliveryPincode;
    private String deliveryCountry;

    // List of items in this order
    private List<OrderItem> orderItems = new ArrayList<>();

    public Order() {
    }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public Date getCreatedAt() { return orderDate; }
    public void setCreatedAt(Date createdAt) { this.orderDate = createdAt; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }

    public String getStatus() { return orderStatus; }
    public void setStatus(String status) { this.orderStatus = status; }

    public String getDeliveryName() { return deliveryName; }
    public void setDeliveryName(String deliveryName) { this.deliveryName = deliveryName; }

    public String getDeliveryPhone() { return deliveryPhone; }
    public void setDeliveryPhone(String deliveryPhone) { this.deliveryPhone = deliveryPhone; }

    public String getDeliveryAddressLine1() { return deliveryAddressLine1; }
    public void setDeliveryAddressLine1(String deliveryAddressLine1) { this.deliveryAddressLine1 = deliveryAddressLine1; }

    public String getDeliveryAddressLine2() { return deliveryAddressLine2; }
    public void setDeliveryAddressLine2(String deliveryAddressLine2) { this.deliveryAddressLine2 = deliveryAddressLine2; }

    public String getDeliveryCity() { return deliveryCity; }
    public void setDeliveryCity(String deliveryCity) { this.deliveryCity = deliveryCity; }

    public String getDeliveryState() { return deliveryState; }
    public void setDeliveryState(String deliveryState) { this.deliveryState = deliveryState; }

    public String getDeliveryPincode() { return deliveryPincode; }
    public void setDeliveryPincode(String deliveryPincode) { this.deliveryPincode = deliveryPincode; }

    public String getDeliveryCountry() { return deliveryCountry; }
    public void setDeliveryCountry(String deliveryCountry) { this.deliveryCountry = deliveryCountry; }

    public List<OrderItem> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItem> orderItems) { this.orderItems = orderItems; }
}