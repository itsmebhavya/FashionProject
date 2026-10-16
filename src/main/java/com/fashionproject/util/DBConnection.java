package com.fashionproject.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/fashion_store?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";       // Change if your MySQL username is different
    private static final String PASSWORD = ""; // Your MySQL password

    public static Connection getConnection() {
        try {
            // Explicitly load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found in classpath!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Database connection failed.");
            e.printStackTrace();
        }
        return null;
    }
}