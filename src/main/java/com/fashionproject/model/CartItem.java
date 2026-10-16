package com.fashionproject.model;

import java.math.BigDecimal;

public class CartItem {
    private int cartItemId;
    private int cartId;
    private int userId;
    private int productId;
    private int variantId;
    private int quantity;
    private double price;
    
    // Product details fields matching DAO requirements
    private String productName;
    private String imageUrl;
    private String size;

    // Default Constructor
    public CartItem() {}

    // Getters and Setters
    public int getCartItemId() { return cartItemId; }
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }

    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    // Overloaded setter to accept BigDecimal from database if needed
    public void setPrice(BigDecimal price) {
        if (price != null) {
            this.price = price.doubleValue();
        } else {
            this.price = 0.0;
        }
    }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    // Added size methods
    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }

    // Subtotal Calculation Method
    public double getSubtotal() {
        return this.price * this.quantity;
    }
}