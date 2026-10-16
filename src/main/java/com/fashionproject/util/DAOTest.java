package com.fashionproject.util;

import java.util.List;

import com.fashionproject.dao.CategoryDAO;
import com.fashionproject.dao.ProductDAO;
import com.fashionproject.dao.ProductVariantDAO;
import com.fashionproject.dao.impl.CategoryDAOImpl;
import com.fashionproject.dao.impl.ProductDAOImpl;
import com.fashionproject.dao.impl.ProductVariantDAOImpl;
import com.fashionproject.model.Category;
import com.fashionproject.model.Product;
import com.fashionproject.model.ProductVariant;

public class DAOTest {

    public static void main(String[] args) {
        System.out.println("--- Testing CategoryDAOImpl ---");
        CategoryDAO categoryDAO = new CategoryDAOImpl();
        List<Category> categories = categoryDAO.getAllCategories();
        for (Category category : categories) {
            System.out.println(category);
        }

        System.out.println("\n--- Testing ProductDAOImpl ---");
        ProductDAO productDAO = new ProductDAOImpl();
        List<Product> products = productDAO.getAllProducts();
        for (Product product : products) {
            System.out.println(product);
        }

        System.out.println("\n--- Testing ProductVariantDAOImpl ---");
        ProductVariantDAO variantDAO = new ProductVariantDAOImpl();
        List<ProductVariant> variants = variantDAO.getAllVariants();
        for (ProductVariant variant : variants) {
            System.out.println(variant);
        }
    }
}