package com.fashionproject.model;

import java.sql.Timestamp;
import java.util.List;

public class Cart {

    private int cartId;
    private int userId;
    private Timestamp createdAt;
    private List<CartItem> items; // Holds the items in the cart

    public Cart() {
    }

    public Cart(int cartId, int userId, Timestamp createdAt, List<CartItem> items) {
        this.cartId = cartId;
        this.userId = userId;
        this.createdAt = createdAt;
        this.items = items;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    @Override
    public String toString() {
        return "Cart [cartId=" + cartId + ", userId=" + userId + ", createdAt=" + createdAt + ", items=" + items + "]";
    }
}