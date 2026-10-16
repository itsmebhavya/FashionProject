package com.fashionproject.dao;

import java.util.List;

import com.fashionproject.model.User;

public interface UserDAO {

    boolean registerUser(User user);

    User loginUser(String email, String password);

    User getUserById(int userId);

    User getUserByEmail(String email);

    User getUserByPhone(String phone);

    boolean updateUser(User user);
    
    // Added delete user method
    boolean deleteUser(int userId);

    boolean updatePassword(int userId, String newPassword);

    // Added method for Forgot Password feature
    boolean updatePasswordByEmail(String email, String hashedPassword);

    boolean emailExists(String email);

    boolean phoneExists(String phone);

    List<User> getAllUsers();
}