package com.fashionproject.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {

    private int productId;
    private int categoryId;
    private String productName;
    private String brand;
    private String description;
    private BigDecimal price;
    private String color;
    private String imageUrl;
    private boolean isActive;
    private Timestamp createdAt;
    private String sizes;

    public Product() {
    }

    public Product(int productId, int categoryId, String productName,
                   String brand, String description, BigDecimal price,
                   String color, String imageUrl, boolean isActive,
                   Timestamp createdAt, String sizes) {

        this.productId = productId;
        this.categoryId = categoryId;
        this.productName = productName;
        this.brand = brand;
        this.description = description;
        this.price = price;
        this.color = color;
        this.imageUrl = imageUrl;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.sizes = sizes;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    // --- Alias Getter/Setter for JSP compatibility (${prod.id}) ---
    public int getId() {
        return productId;
    }

    public void setId(int id) {
        this.productId = id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    // --- Alias Getter/Setter for JSP compatibility (${prod.name}) ---
    public String getName() {
        return productName;
    }

    public void setName(String name) {
        this.productName = name;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    // --- Alias Getter/Setter for JSP compatibility (${prod.image}) ---
    public String getImage() {
        return imageUrl;
    }

    public void setImage(String image) {
        this.imageUrl = image;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getSizes() {
        return sizes;
    }

    public void setSizes(String sizes) {
        this.sizes = sizes;
    }

    @Override
    public String toString() {
        return productId + " | " + productName + " | " + brand + " | " + price + " | " + categoryId + " | Sizes: " + sizes;
    }
}