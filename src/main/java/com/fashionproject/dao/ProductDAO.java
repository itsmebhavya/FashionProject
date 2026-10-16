package com.fashionproject.dao;

import java.math.BigDecimal;
import java.util.List;
import com.fashionproject.model.Product;
import com.fashionproject.model.ProductVariant;

public interface ProductDAO {
    boolean addProduct(Product product);
    boolean updateProduct(Product product);
    boolean deleteProduct(int productId);
    Product getProductById(int productId);
    List<Product> getAllProducts();
    List<Product> getAllActiveProducts();
    List<Product> getProductsByCategory(int categoryId);
    List<Product> getProductsByCategoryId(int categoryId);
    List<Product> searchProducts(String keyword);
    List<Product> getProductsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice);
    List<Product> getProductsSortedByPriceAsc();
    List<ProductVariant> getVariantsByProductId(int productId);
    List<Product> getFilteredProducts(String keyword, Integer categoryId, 
                                       BigDecimal minPrice, BigDecimal maxPrice, String sortBy);
    
    // Added for accurate COUNT(*) database queries
    int getTotalProductsCount();
}