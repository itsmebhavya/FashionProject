package com.fashionproject.model;

import java.math.BigDecimal;

public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int variantId;
    private int quantity;
    private BigDecimal price;
    
    // Display & link fields
    private int productId;
    private String productName;
    private String imageUrl;

    public OrderItem() {}

    public OrderItem(int orderItemId, int orderId, int variantId, int quantity, BigDecimal price, int productId, String productName, String imageUrl) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.variantId = variantId;
        this.quantity = quantity;
        this.price = price;
        this.productId = productId;
        this.productName = productName;
        this.imageUrl = imageUrl;
    }

    public int getOrderItemId() { return orderItemId; }
    public void setOrderItemId(int orderItemId) { this.orderItemId = orderItemId; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}