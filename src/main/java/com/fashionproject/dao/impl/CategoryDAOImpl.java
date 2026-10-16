package com.fashionproject.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.fashionproject.dao.CategoryDAO;
import com.fashionproject.model.Category;
import com.fashionproject.util.DBConnection;

public class CategoryDAOImpl implements CategoryDAO {

    private static final String INSERT_CATEGORY_SQL = """
            INSERT INTO categories
            (category_name, description)
            VALUES (?, ?)
            """;

    private static final String UPDATE_CATEGORY_SQL = """
            UPDATE categories
            SET category_name = ?, description = ?
            WHERE category_id = ?
            """;

    private static final String DELETE_CATEGORY_SQL = """
            DELETE FROM categories
            WHERE category_id = ?
            """;

    private static final String GET_CATEGORY_BY_ID_SQL = """
            SELECT * FROM categories
            WHERE category_id = ?
            """;

    private static final String GET_CATEGORY_BY_NAME_SQL = """
            SELECT * FROM categories
            WHERE category_name = ?
            """;

    private static final String GET_ALL_CATEGORIES_SQL = """
            SELECT DISTINCT category_id, category_name, description 
            FROM categories 
            ORDER BY category_id ASC
            """;

    @Override
    public boolean addCategory(Category category) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CATEGORY_SQL)) {

            preparedStatement.setString(1, category.getCategoryName());
            preparedStatement.setString(2, category.getDescription());

            return preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateCategory(Category category) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CATEGORY_SQL)) {

            preparedStatement.setString(1, category.getCategoryName());
            preparedStatement.setString(2, category.getDescription());
            preparedStatement.setInt(3, category.getCategoryId());

            return preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteCategory(int categoryId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_CATEGORY_SQL)) {

            preparedStatement.setInt(1, categoryId);

            return preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Category getCategoryById(int categoryId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_CATEGORY_BY_ID_SQL)) {

            preparedStatement.setInt(1, categoryId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToCategory(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Category getCategoryByName(String categoryName) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_CATEGORY_BY_NAME_SQL)) {

            preparedStatement.setString(1, categoryName);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToCategory(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_CATEGORIES_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            // Maps unique IDs while preserving order, and sets track unique category names
            Map<Integer, Category> uniqueCategoriesMap = new LinkedHashMap<>();
            Set<String> seenNames = new HashSet<>();

            while (resultSet.next()) {
                Category category = mapResultSetToCategory(resultSet);
                
                String normalizedName = category.getCategoryName() != null 
                        ? category.getCategoryName().trim().toLowerCase() 
                        : "";

                // Ensure neither ID nor normalized name has already been processed
                if (!uniqueCategoriesMap.containsKey(category.getCategoryId()) && !seenNames.contains(normalizedName)) {
                    uniqueCategoriesMap.put(category.getCategoryId(), category);
                    seenNames.add(normalizedName);
                }
            }

            categories = new ArrayList<>(uniqueCategoriesMap.values());

        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    private Category mapResultSetToCategory(ResultSet resultSet) throws Exception {
        Category category = new Category();
        category.setCategoryId(resultSet.getInt("category_id"));
        category.setCategoryName(resultSet.getString("category_name"));
        category.setDescription(resultSet.getString("description"));
        return category;
    }
}