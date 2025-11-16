package com.equip.point.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Security filter for adding security headers and rate limiting
 */
@WebFilter(urlPatterns = {"/*"})
public class SecurityFilter implements Filter {

    // Rate limiting: track login attempts per IP
    private static final ConcurrentHashMap<String, RateLimitInfo> loginAttempts = new ConcurrentHashMap<>();
    private static final int MAX_LOGIN_ATTEMPTS = 5;
    private static final long RATE_LIMIT_DURATION_MS = 15 * 60 * 1000; // 15 minutes
    private static final long SESSION_TIMEOUT_MS = 30 * 60 * 1000; // 30 minutes

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Start cleanup thread for expired rate limit entries
        Thread cleanupThread = new Thread(() -> {
            while (true) {
                try {
                    Thread.sleep(60000); // Run every minute
                    cleanupExpiredEntries();
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    break;
                }
            }
        });
        cleanupThread.setDaemon(true);
        cleanupThread.start();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Add security headers
        addSecurityHeaders(httpResponse);

        // Check rate limiting for login endpoint
        if (httpRequest.getRequestURI().endsWith("/api/auth") && "POST".equals(httpRequest.getMethod())) {
            String clientIP = getClientIP(httpRequest);
            if (isRateLimited(clientIP)) {
                httpResponse.sendError(429, // HTTP 429 Too Many Requests
                    "Too many login attempts. Please try again later.");
                return;
            }
        }

        // Check session timeout
        HttpSession session = httpRequest.getSession(false);
        if (session != null) {
            checkSessionTimeout(session, httpRequest, httpResponse);
        }

        chain.doFilter(request, response);

        // Track failed login attempts
        if (httpRequest.getRequestURI().endsWith("/api/auth") && 
            "POST".equals(httpRequest.getMethod()) &&
            httpResponse.getStatus() >= 400) {
            String clientIP = getClientIP(httpRequest);
            recordFailedLoginAttempt(clientIP);
        }
    }

    @Override
    public void destroy() {
        loginAttempts.clear();
    }

    /**
     * Add security headers to the response
     */
    private void addSecurityHeaders(HttpServletResponse response) {
        // Prevent clickjacking
        response.setHeader("X-Frame-Options", "DENY");
        
        // Enable XSS protection
        response.setHeader("X-XSS-Protection", "1; mode=block");
        
        // Prevent MIME sniffing
        response.setHeader("X-Content-Type-Options", "nosniff");
        
        // Referrer policy
        response.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
        
        // Content Security Policy
        response.setHeader("Content-Security-Policy", 
            "default-src 'self'; " +
            "script-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com; " +
            "style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com; " +
            "font-src 'self' https://cdnjs.cloudflare.com; " +
            "img-src 'self' data: https:;");
        
        // Strict Transport Security (HSTS) - Only enable if using HTTPS
        // response.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
        
        // Permissions Policy
        response.setHeader("Permissions-Policy", 
            "geolocation=(), microphone=(), camera=()");
    }

    /**
     * Get client IP address
     */
    private String getClientIP(HttpServletRequest request) {
        String clientIP = request.getHeader("X-Forwarded-For");
        if (clientIP == null || clientIP.isEmpty()) {
            clientIP = request.getHeader("X-Real-IP");
        }
        if (clientIP == null || clientIP.isEmpty()) {
            clientIP = request.getRemoteAddr();
        }
        return clientIP;
    }

    /**
     * Check if IP is rate limited
     */
    private boolean isRateLimited(String clientIP) {
        RateLimitInfo info = loginAttempts.get(clientIP);
        if (info == null) {
            return false;
        }

        long now = System.currentTimeMillis();
        if (now - info.firstAttemptTime > RATE_LIMIT_DURATION_MS) {
            // Reset if duration has passed
            loginAttempts.remove(clientIP);
            return false;
        }

        return info.attemptCount.get() >= MAX_LOGIN_ATTEMPTS;
    }

    /**
     * Record a failed login attempt
     */
    private void recordFailedLoginAttempt(String clientIP) {
        long now = System.currentTimeMillis();
        loginAttempts.compute(clientIP, (key, info) -> {
            if (info == null) {
                return new RateLimitInfo(now);
            }
            if (now - info.firstAttemptTime > RATE_LIMIT_DURATION_MS) {
                // Reset if duration has passed
                return new RateLimitInfo(now);
            }
            info.attemptCount.incrementAndGet();
            return info;
        });
    }

    /**
     * Check session timeout
     */
    private void checkSessionTimeout(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long lastAccessTime = (Long) session.getAttribute("lastAccessTime");
        long now = System.currentTimeMillis();
        
        if (lastAccessTime != null && (now - lastAccessTime) > SESSION_TIMEOUT_MS) {
            // Session has timed out
            session.invalidate();
            if (!isPublicEndpoint(request.getRequestURI())) {
                response.sendRedirect(request.getContextPath() + "/login/login.jsp?timeout=true");
            }
        } else {
            // Update last access time
            session.setAttribute("lastAccessTime", now);
        }
    }

    /**
     * Check if endpoint is public
     */
    private boolean isPublicEndpoint(String path) {
        return path.contains("/login/") || 
               path.contains("/users/signUp") || 
               path.contains("/api/register") ||
               path.endsWith("/index.jsp") ||
               path.contains("/images/") ||
               path.contains("/src/");
    }

    /**
     * Cleanup expired rate limit entries
     */
    private void cleanupExpiredEntries() {
        long now = System.currentTimeMillis();
        java.util.List<String> keysToRemove = new java.util.ArrayList<>();
        for (var entry : loginAttempts.entrySet()) {
            if (now - entry.getValue().firstAttemptTime > RATE_LIMIT_DURATION_MS) {
                keysToRemove.add(entry.getKey());
            }
        }
        for (String key : keysToRemove) {
            loginAttempts.remove(key);
        }
    }

    /**
     * Inner class to track rate limit information
     */
    private static class RateLimitInfo {
        final long firstAttemptTime;
        final AtomicInteger attemptCount;

        RateLimitInfo(long firstAttemptTime) {
            this.firstAttemptTime = firstAttemptTime;
            this.attemptCount = new AtomicInteger(1);
        }
    }
}
