package com.equip.point.util;

import org.mindrot.jbcrypt.BCrypt;
import org.owasp.encoder.Encode;

import java.util.regex.Pattern;

/**
 * Security utility class for password hashing and input sanitization
 */
public class SecurityUtil {

    // Pre-compiled regex patterns for performance
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[+]?[0-9\\s\\-()]{10,22}$");
    private static final Pattern UPPER_PATTERN = Pattern.compile(".*[A-Z].*");
    private static final Pattern LOWER_PATTERN = Pattern.compile(".*[a-z].*");
    private static final Pattern DIGIT_PATTERN = Pattern.compile(".*[0-9].*");
    private static final String SPECIAL_CHARS = "!@#$%^&*()_+-=[]{};\':\"\\|,.<>/?";

    private SecurityUtil() {
        // Private constructor to prevent instantiation
    }

    /**
     * Hash a password using BCrypt
     * @param plainPassword The plain text password
     * @return The hashed password
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    /**
     * Verify a password against a hashed password
     * @param plainPassword The plain text password
     * @param hashedPassword The hashed password from database
     * @return true if passwords match, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            System.err.println("Error verifying password: " + e.getMessage());
            return false;
        }
    }

    /**
     * Sanitize HTML input to prevent XSS attacks
     * @param input The input string
     * @return The sanitized string
     */
    public static String sanitizeHtml(String input) {
        if (input == null) {
            return null;
        }
        return Encode.forHtml(input);
    }

    /**
     * Sanitize JavaScript input to prevent XSS attacks
     * @param input The input string
     * @return The sanitized string
     */
    public static String sanitizeJavaScript(String input) {
        if (input == null) {
            return null;
        }
        return Encode.forJavaScript(input);
    }

    /**
     * Validate email format
     * @param email The email to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }

    /**
     * Validate phone number format
     * @param phone The phone number to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        // Allow digits, spaces, hyphens, parentheses, and plus sign
        return PHONE_PATTERN.matcher(phone).matches();
    }

    /**
     * Validate password strength
     * @param password The password to validate
     * @return true if password meets minimum requirements
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        // At least one uppercase, one lowercase, one digit, and one special character
        boolean hasUpper = UPPER_PATTERN.matcher(password).matches();
        boolean hasLower = LOWER_PATTERN.matcher(password).matches();
        boolean hasDigit = DIGIT_PATTERN.matcher(password).matches();
        boolean hasSpecial = containsAny(password, SPECIAL_CHARS);
        return hasUpper && hasLower && hasDigit && hasSpecial;
    }

    /**
     * Check if string contains any character from the given set
     * @param str String to check
     * @param chars Character set
     * @return true if any character is found
     */
    private static boolean containsAny(String str, String chars) {
        for (char c : str.toCharArray()) {
            if (chars.indexOf(c) >= 0) {
                return true;
            }
        }
        return false;
    }
}
