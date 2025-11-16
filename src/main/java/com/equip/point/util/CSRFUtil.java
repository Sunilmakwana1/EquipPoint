package com.equip.point.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.security.SecureRandom;
import java.util.Base64;

/**
 * Utility class for CSRF (Cross-Site Request Forgery) protection
 */
public class CSRFUtil {

    private static final String CSRF_TOKEN_SESSION_KEY = "CSRF_TOKEN";
    private static final int TOKEN_LENGTH = 32;
    private static final SecureRandom secureRandom = new SecureRandom();

    private CSRFUtil() {
        // Private constructor to prevent instantiation
    }

    /**
     * Generate a new CSRF token and store it in the session
     * @param session The HTTP session
     * @return The generated CSRF token
     */
    public static String generateToken(HttpSession session) {
        byte[] tokenBytes = new byte[TOKEN_LENGTH];
        secureRandom.nextBytes(tokenBytes);
        String token = Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes);
        session.setAttribute(CSRF_TOKEN_SESSION_KEY, token);
        return token;
    }

    /**
     * Get the CSRF token from the session, or generate a new one if it doesn't exist
     * @param session The HTTP session
     * @return The CSRF token
     */
    public static String getToken(HttpSession session) {
        String token = (String) session.getAttribute(CSRF_TOKEN_SESSION_KEY);
        if (token == null) {
            token = generateToken(session);
        }
        return token;
    }

    /**
     * Validate a CSRF token from the request against the session token
     * @param request The HTTP request
     * @return true if the token is valid, false otherwise
     */
    public static boolean validateToken(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }

        String sessionToken = (String) session.getAttribute(CSRF_TOKEN_SESSION_KEY);
        String requestToken = request.getParameter("csrf_token");
        
        // Also check header for AJAX requests
        if (requestToken == null) {
            requestToken = request.getHeader("X-CSRF-Token");
        }

        if (sessionToken == null || requestToken == null) {
            return false;
        }

        return sessionToken.equals(requestToken);
    }

    /**
     * Invalidate the CSRF token in the session
     * @param session The HTTP session
     */
    public static void invalidateToken(HttpSession session) {
        session.removeAttribute(CSRF_TOKEN_SESSION_KEY);
    }
}
