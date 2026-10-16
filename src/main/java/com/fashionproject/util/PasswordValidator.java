package com.fashionproject.util;

import java.util.regex.Pattern;

public class PasswordValidator {

    // Regex to ensure:
    // - At least 8 characters
    // - At least one lowercase letter
    // - At least one uppercase letter
    // - At least one digit
    // - At least one special character
    private static final String PASSWORD_PATTERN = 
        "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";

    private static final Pattern pattern = Pattern.compile(PASSWORD_PATTERN);

    public static boolean isValid(String password) {
        if (password == null) {
            return false;
        }
        return pattern.matcher(password).matches();
    }
}