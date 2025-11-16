package com.equip.point.Service;

import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * Service class for audit logging
 * Tracks security events and user actions
 */
public class AuditLogService {

    private Connection conn;

    public AuditLogService(Connection conn) {
        this.conn = conn;
    }

    /**
     * Log a security event
     * @param userId The user ID (can be null for anonymous actions)
     * @param action The action performed
     * @param resource The resource affected
     * @param resourceId The resource ID
     * @param ipAddress The IP address
     * @param userAgent The user agent
     * @param status The status (success, failure, warning)
     * @param details Additional details
     * @return true if logged successfully
     */
    public boolean logEvent(Long userId, String action, String resource, String resourceId,
                           String ipAddress, String userAgent, String status, String details) {
        try {
            String query = "INSERT INTO audit_log (user_id, action, resource, resource_id, " +
                          "ip_address, user_agent, status, details, created_date) " +
                          "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
            
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                if (userId != null) {
                    ps.setLong(1, userId);
                } else {
                    ps.setNull(1, java.sql.Types.BIGINT);
                }
                ps.setString(2, action);
                ps.setString(3, resource);
                ps.setString(4, resourceId);
                ps.setString(5, ipAddress);
                ps.setString(6, userAgent);
                ps.setString(7, status);
                ps.setString(8, details);
                
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.err.println("CRITICAL: Audit logging failed for action '" + action + 
                             "' on resource '" + resource + "': " + e.getMessage());
            e.printStackTrace();
            // TODO: Implement fallback logging mechanism (e.g., file-based logging)
            return false;
        }
    }

    /**
     * Log a successful login
     */
    public boolean logSuccessfulLogin(Long userId, String ipAddress, String userAgent) {
        return logEvent(userId, "LOGIN", "authentication", userId.toString(), 
                       ipAddress, userAgent, "success", "User logged in successfully");
    }

    /**
     * Log a failed login
     */
    public boolean logFailedLogin(String email, String ipAddress, String userAgent, String reason) {
        return logEvent(null, "LOGIN_FAILED", "authentication", email, 
                       ipAddress, userAgent, "failure", "Login failed: " + reason);
    }

    /**
     * Log a logout
     */
    public boolean logLogout(Long userId, String ipAddress, String userAgent) {
        return logEvent(userId, "LOGOUT", "authentication", userId.toString(), 
                       ipAddress, userAgent, "success", "User logged out");
    }

    /**
     * Log password change
     */
    public boolean logPasswordChange(Long userId, String ipAddress, String userAgent) {
        return logEvent(userId, "PASSWORD_CHANGE", "user", userId.toString(), 
                       ipAddress, userAgent, "success", "Password changed successfully");
    }

    /**
     * Log account lockout
     */
    public boolean logAccountLockout(String email, String ipAddress, String reason) {
        return logEvent(null, "ACCOUNT_LOCKED", "user", email, 
                       ipAddress, null, "warning", "Account locked: " + reason);
    }

    /**
     * Log permission denied
     */
    public boolean logPermissionDenied(Long userId, String action, String resource, 
                                      String ipAddress, String userAgent) {
        return logEvent(userId, "PERMISSION_DENIED", resource, null, 
                       ipAddress, userAgent, "failure", 
                       "Access denied to " + action + " on " + resource);
    }

    /**
     * Log data access
     */
    public boolean logDataAccess(Long userId, String action, String resource, String resourceId,
                                String ipAddress, String userAgent) {
        return logEvent(userId, action, resource, resourceId, 
                       ipAddress, userAgent, "success", 
                       action + " performed on " + resource + " " + resourceId);
    }

    /**
     * Log data modification
     */
    public boolean logDataModification(Long userId, String action, String resource, String resourceId,
                                      String ipAddress, String userAgent, String details) {
        return logEvent(userId, action, resource, resourceId, 
                       ipAddress, userAgent, "success", details);
    }

    /**
     * Log security warning
     */
    public boolean logSecurityWarning(Long userId, String action, String details,
                                     String ipAddress, String userAgent) {
        return logEvent(userId, action, "security", null, 
                       ipAddress, userAgent, "warning", details);
    }
}
