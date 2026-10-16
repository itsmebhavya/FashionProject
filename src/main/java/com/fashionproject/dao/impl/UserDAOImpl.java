package com.fashionproject.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionproject.dao.UserDAO;
import com.fashionproject.model.User;
import com.fashionproject.util.DBConnection;
import com.fashionproject.util.PasswordUtil;

public class UserDAOImpl implements UserDAO {

    private static final String INSERT_USER_SQL = "INSERT INTO users (name, email, password, phone, address_line1, address_line2, city, state, pincode, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_USER_BY_EMAIL_SQL = "SELECT * FROM users WHERE email = ?";
    private static final String GET_USER_BY_ID_SQL = "SELECT * FROM users WHERE user_id = ?";
    private static final String GET_USER_BY_PHONE_SQL = "SELECT * FROM users WHERE phone = ?";
    private static final String UPDATE_USER_SQL = "UPDATE users SET name = ?, email = ?, phone = ?, address_line1 = ?, address_line2 = ?, city = ?, state = ?, pincode = ?, role = ? WHERE user_id = ?";
    private static final String DELETE_USER_SQL = "DELETE FROM users WHERE user_id = ?"; // Added delete query
    private static final String UPDATE_PASSWORD_SQL = "UPDATE users SET password = ? WHERE user_id = ?";
    private static final String UPDATE_PASSWORD_BY_EMAIL_SQL = "UPDATE users SET password = ? WHERE email = ?";
    private static final String EMAIL_EXISTS_SQL = "SELECT user_id FROM users WHERE email = ?";
    private static final String PHONE_EXISTS_SQL = "SELECT user_id FROM users WHERE phone = ?";
    private static final String GET_ALL_USERS_SQL = "SELECT * FROM users";

    @Override
    public boolean registerUser(User user) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_USER_SQL)) {

            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail().trim());
            ps.setString(3, hashedPassword);
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddressLine1());
            ps.setString(6, user.getAddressLine2());
            ps.setString(7, user.getCity());
            ps.setString(8, user.getState());
            ps.setString(9, user.getPincode());
            ps.setString(10, "USER");

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public User loginUser(String email, String password) {
        return getUserByEmail(email);
    }

    @Override
    public User getUserById(int userId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_USER_BY_ID_SQL)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User getUserByEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return null;
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_USER_BY_EMAIL_SQL)) {

            ps.setString(1, email.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User getUserByPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return null;
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_USER_BY_PHONE_SQL)) {

            ps.setString(1, phone.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateUser(User user) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_USER_SQL)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail().trim());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddressLine1());
            ps.setString(5, user.getAddressLine2());
            ps.setString(6, user.getCity());
            ps.setString(7, user.getState());
            ps.setString(8, user.getPincode());
            ps.setString(9, user.getRole());
            ps.setInt(10, user.getUserId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteUser(int userId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_USER_SQL)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updatePassword(int userId, String newPassword) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_PASSWORD_SQL)) {

            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updatePasswordByEmail(String email, String newPassword) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_PASSWORD_BY_EMAIL_SQL)) {

            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            ps.setString(1, hashedPassword);
            ps.setString(2, email.trim());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean emailExists(String email) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(EMAIL_EXISTS_SQL)) {

            ps.setString(1, email.trim());
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean phoneExists(String phone) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(PHONE_EXISTS_SQL)) {

            ps.setString(1, phone.trim());
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_ALL_USERS_SQL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    private User mapResultSetToUser(ResultSet rs) throws Exception {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setPhone(rs.getString("phone"));
        user.setAddressLine1(rs.getString("address_line1"));
        user.setAddressLine2(rs.getString("address_line2"));
        user.setCity(rs.getString("city"));
        user.setState(rs.getString("state"));
        user.setPincode(rs.getString("pincode"));
        user.setRole(rs.getString("role"));
        return user;
    }
}