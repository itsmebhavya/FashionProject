package com.fashionproject.util;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class PasswordUtil {

    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 256;
    private static final int SALT_LENGTH = 16;

    private PasswordUtil() {
    }

    // Hash password before storing it in the database
    public static String hashPassword(String password) {
        byte[] salt = new byte[SALT_LENGTH];
        new SecureRandom().nextBytes(salt);

        PBEKeySpec spec = new PBEKeySpec(
                password.toCharArray(),
                salt,
                ITERATIONS,
                KEY_LENGTH
        );

        try {
            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

            byte[] hash = factory.generateSecret(spec).getEncoded();

            return Base64.getEncoder().encodeToString(salt)
                    + "$"
                    + Base64.getEncoder().encodeToString(hash);

        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new RuntimeException(
                    "Password hashing failed",
                    e
            );
        } finally {
            spec.clearPassword();
        }
    }

    // Verify login password against stored hashed password
    public static boolean verifyPassword(
            String password,
            String storedPassword) {

        try {
            String[] parts = storedPassword.split("\\$");

            if (parts.length != 2) {
                return false;
            }

            byte[] salt =
                    Base64.getDecoder().decode(parts[0]);

            byte[] storedHash =
                    Base64.getDecoder().decode(parts[1]);

            PBEKeySpec spec = new PBEKeySpec(
                    password.toCharArray(),
                    salt,
                    ITERATIONS,
                    KEY_LENGTH
            );

            try {
                SecretKeyFactory factory =
                        SecretKeyFactory.getInstance(
                                "PBKDF2WithHmacSHA256"
                        );

                byte[] enteredHash =
                        factory.generateSecret(spec).getEncoded();

                if (enteredHash.length != storedHash.length) {
                    return false;
                }

                // Constant-time comparison
                int result = 0;

                for (int i = 0; i < enteredHash.length; i++) {
                    result |= enteredHash[i] ^ storedHash[i];
                }

                return result == 0;

            } finally {
                spec.clearPassword();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Alias for compatibility with checkPassword method calls
    public static boolean checkPassword(String password, String storedPassword) {
        if (storedPassword == null) {
            return false;
        }
        // Fallback for old plain-text database entries if any exist
        if (!storedPassword.contains("$")) {
            return storedPassword.equals(password);
        }
        return verifyPassword(password, storedPassword);
    }
}