package com.fashionproject.dao.impl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.fashionproject.dao.ProductDAO;
import com.fashionproject.model.Product;
import com.fashionproject.model.ProductVariant;
import com.fashionproject.util.DBConnection;

public class ProductDAOImpl implements ProductDAO {

    private static final String INSERT_PRODUCT_SQL = 
        "INSERT INTO products (category_id, product_name, brand, description, price, color, image_url, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String UPDATE_PRODUCT_SQL = 
        "UPDATE products SET category_id = ?, product_name = ?, brand = ?, description = ?, price = ?, color = ?, image_url = ?, is_active = ? WHERE product_id = ?";

    private static final String DELETE_PRODUCT_SQL = 
        "DELETE FROM products WHERE product_id = ?";

    private static final String GET_PRODUCT_BY_ID_SQL = 
        "SELECT * FROM products WHERE product_id = ?";

    private static final String GET_ALL_PRODUCTS_SQL = 
        "SELECT * FROM products ORDER BY product_id ASC";

    private static final String GET_ALL_ACTIVE_PRODUCTS_SQL = 
        "SELECT * FROM products WHERE is_active = TRUE ORDER BY product_id ASC";

    private static final String GET_PRODUCTS_BY_CATEGORY_SQL = 
        "SELECT * FROM products WHERE category_id = ? ORDER BY product_id ASC";

    private static final String SEARCH_PRODUCTS_SQL = 
        "SELECT * FROM products WHERE product_name LIKE ? OR brand LIKE ? OR description LIKE ? ORDER BY product_id ASC";

    private static final String GET_PRODUCTS_BY_PRICE_RANGE_SQL = 
        "SELECT * FROM products WHERE price BETWEEN ? AND ? ORDER BY product_id ASC";

    private static final String GET_PRODUCTS_SORTED_BY_PRICE_ASC_SQL = 
        "SELECT * FROM products ORDER BY price ASC, product_id ASC";
        
    private static final String COUNT_PRODUCTS_SQL = 
        "SELECT COUNT(*) FROM products";

    private List<Product> deduplicateProducts(List<Product> rawProducts) {
        if (rawProducts == null) {
            return new ArrayList<>();
        }
        Map<Integer, Product> uniqueMap = new LinkedHashMap<>();
        for (Product product : rawProducts) {
            if (product != null) {
                uniqueMap.putIfAbsent(product.getProductId(), product);
            }
        }
        return new ArrayList<>(uniqueMap.values());
    }

    @Override
    public boolean addProduct(Product product) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PRODUCT_SQL)) {

            preparedStatement.setInt(1, product.getCategoryId());
            preparedStatement.setString(2, product.getProductName());
            preparedStatement.setString(3, product.getBrand());
            preparedStatement.setString(4, product.getDescription());
            preparedStatement.setBigDecimal(5, product.getPrice());
            preparedStatement.setString(6, product.getColor());
            preparedStatement.setString(7, product.getImageUrl());
            preparedStatement.setBoolean(8, product.isActive());

            return preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateProduct(Product product) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCT_SQL)) {

            preparedStatement.setInt(1, product.getCategoryId());
            preparedStatement.setString(2, product.getProductName());
            preparedStatement.setString(3, product.getBrand());
            preparedStatement.setString(4, product.getDescription());
            preparedStatement.setBigDecimal(5, product.getPrice());
            preparedStatement.setString(6, product.getColor());
            preparedStatement.setString(7, product.getImageUrl());
            preparedStatement.setBoolean(8, product.isActive());
            preparedStatement.setInt(9, product.getProductId());

            return preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteProduct(int productId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCT_SQL)) {

            preparedStatement.setInt(1, productId);
            return preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Product getProductById(int productId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PRODUCT_BY_ID_SQL)) {

            preparedStatement.setInt(1, productId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToProduct(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_PRODUCTS_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return deduplicateProducts(products);
    }

    @Override
    public List<Product> getAllActiveProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_ACTIVE_PRODUCTS_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return deduplicateProducts(products);
    }

    @Override
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PRODUCTS_BY_CATEGORY_SQL)) {

            preparedStatement.setInt(1, categoryId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    products.add(mapResultSetToProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return deduplicateProducts(products);
    }

    @Override
    public List<Product> getProductsByCategoryId(int categoryId) {
        return getProductsByCategory(categoryId);
    }

    @Override
    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_PRODUCTS_SQL)) {

            String searchKeyword = "%" + keyword + "%";
            preparedStatement.setString(1, searchKeyword);
            preparedStatement.setString(2, searchKeyword);
            preparedStatement.setString(3, searchKeyword);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    products.add(mapResultSetToProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return deduplicateProducts(products);
    }

    @Override
    public List<Product> getProductsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
        List<Product> products = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PRODUCTS_BY_PRICE_RANGE_SQL)) {

            preparedStatement.setBigDecimal(1, minPrice);
            preparedStatement.setBigDecimal(2, maxPrice);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    products.add(mapResultSetToProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return deduplicateProducts(products);
    }

    @Override
    public List<Product> getProductsSortedByPriceAsc() {
        List<Product> products = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PRODUCTS_SORTED_BY_PRICE_ASC_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                products.add(mapResultSetToProduct(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return deduplicateProducts(products);
    }

    @Override
    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> variants = new ArrayList<>();
        Set<String> uniqueSizes = new LinkedHashSet<>();
        String sql = "SELECT * FROM product_variants WHERE product_id = ? ORDER BY variant_id ASC";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String size = rs.getString("size");
                    String normalizedSize = (size != null) ? size.trim() : "";
                    
                    if (!normalizedSize.isEmpty() && uniqueSizes.contains(normalizedSize)) {
                        continue; 
                    }
                    if (!normalizedSize.isEmpty()) {
                        uniqueSizes.add(normalizedSize);
                    }

                    ProductVariant variant = new ProductVariant();
                    variant.setVariantId(rs.getInt("variant_id"));
                    variant.setProductId(rs.getInt("product_id")); 
                    variant.setSize(normalizedSize); 
                    variant.setStockQuantity(rs.getInt("stock_quantity"));
                    variants.add(variant);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return variants;
    }

    @Override
    public List<Product> getFilteredProducts(String keyword, Integer categoryId, 
                                           BigDecimal minPrice, BigDecimal maxPrice, String sortBy) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE is_active = TRUE ");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (product_name LIKE ? OR brand LIKE ? OR description LIKE ?) ");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        if (categoryId != null) {
            sql.append("AND category_id = ? ");
            params.add(categoryId);
        }

        if (minPrice != null) {
            sql.append("AND price >= ? ");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append("AND price <= ? ");
            params.add(maxPrice);
        }

        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "price_asc":
                    sql.append("ORDER BY price ASC, product_id ASC ");
                    break;
                case "price_desc":
                    sql.append("ORDER BY price DESC, product_id ASC ");
                    break;
                case "name_asc":
                    sql.append("ORDER BY product_name ASC, product_id ASC ");
                    break;
                case "newest":
                    sql.append("ORDER BY product_id DESC ");
                    break;
                default:
                    sql.append("ORDER BY product_id ASC ");
                    break;
            }
        } else {
            sql.append("ORDER BY product_id ASC ");
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                preparedStatement.setObject(i + 1, params.get(i));
            }

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    products.add(mapResultSetToProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return deduplicateProducts(products);
    }

    @Override
    public int getTotalProductsCount() {
        int count = 0;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_PRODUCTS_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    private Product mapResultSetToProduct(ResultSet resultSet) throws Exception {
        Product product = new Product();
        product.setProductId(resultSet.getInt("product_id"));
        product.setCategoryId(resultSet.getInt("category_id"));
        product.setProductName(resultSet.getString("product_name"));
        product.setBrand(resultSet.getString("brand"));
        product.setDescription(resultSet.getString("description"));
        product.setPrice(resultSet.getBigDecimal("price"));
        product.setColor(resultSet.getString("color"));
        product.setImageUrl(resultSet.getString("image_url"));
        product.setActive(resultSet.getBoolean("is_active"));
        
        try {
            product.setCreatedAt(resultSet.getTimestamp("created_at"));
        } catch (Exception ignored) {
        }

        return product;
    }
}