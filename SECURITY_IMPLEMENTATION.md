# EquipPoint - Security Implementation Guide

## Overview
This document outlines all security enhancements implemented in the EquipPoint equipment rental system to ensure enterprise-grade security, data protection, and compliance with modern security standards.

## Table of Contents
1. [Security Features](#security-features)
2. [Authentication & Authorization](#authentication--authorization)
3. [Password Security](#password-security)
4. [Input Validation & XSS Protection](#input-validation--xss-protection)
5. [CSRF Protection](#csrf-protection)
6. [Rate Limiting](#rate-limiting)
7. [Session Management](#session-management)
8. [Audit Logging](#audit-logging)
9. [Security Headers](#security-headers)
10. [Role-Based Access Control](#role-based-access-control)
11. [Database Security](#database-security)
12. [Deployment Guidelines](#deployment-guidelines)

---

## Security Features

### Implemented Security Measures

✅ **Authentication Security**
- BCrypt password hashing (salt rounds = 12)
- Strong password requirements
- Account lockout after failed attempts
- Session-based authentication

✅ **Authorization**
- Role-Based Access Control (RBAC)
- 30+ granular permissions
- Resource-level access control
- Dynamic permission checking

✅ **Input Security**
- SQL injection prevention
- XSS protection with OWASP Encoder
- Email, phone, and password validation
- HTML/JavaScript sanitization

✅ **Network Security**
- Rate limiting for login attempts
- CSRF token protection
- Comprehensive security headers
- Session timeout management

✅ **Monitoring & Compliance**
- Comprehensive audit logging
- Security event tracking
- Failed login monitoring
- User activity tracking

---

## Authentication & Authorization

### Password Hashing

All passwords are hashed using BCrypt with 12 salt rounds before storage.

```java
// Hashing a password
String hashedPassword = SecurityUtil.hashPassword(plainPassword);

// Verifying a password
boolean isValid = SecurityUtil.verifyPassword(plainPassword, hashedPassword);
```

### Password Requirements

Passwords must meet the following criteria:
- Minimum 8 characters
- At least one uppercase letter (A-Z)
- At least one lowercase letter (a-z)
- At least one digit (0-9)
- At least one special character (!@#$%^&*()_+-=[]{};\:'"|,.<>/?)

### Login Flow

1. User submits email and password
2. System validates input format
3. Rate limiting check (5 attempts per 15 minutes)
4. Password verification against BCrypt hash
5. Session creation with timeout
6. Audit log entry created
7. Redirect to dashboard

### Default Admin Account

- **Email**: admin@equippoint.com
- **Password**: Admin@123
- **Role**: Admin (full system access)

⚠️ **IMPORTANT**: Change the default admin password immediately after deployment!

---

## Password Security

### SecurityUtil Class

The `SecurityUtil` class provides comprehensive security utilities:

```java
// Password hashing
String hash = SecurityUtil.hashPassword("MySecurePass123!");

// Password verification
boolean valid = SecurityUtil.verifyPassword("MySecurePass123!", hash);

// Password strength validation
boolean isStrong = SecurityUtil.isValidPassword("MySecurePass123!");

// Email validation
boolean validEmail = SecurityUtil.isValidEmail("user@example.com");

// Phone validation
boolean validPhone = SecurityUtil.isValidPhone("+1234567890");

// HTML sanitization (XSS protection)
String safe = SecurityUtil.sanitizeHtml("<script>alert('xss')</script>");

// JavaScript sanitization
String safeJs = SecurityUtil.sanitizeJavaScript("'; alert('xss'); //");
```

---

## Input Validation & XSS Protection

### OWASP Encoder Integration

The system uses OWASP Java Encoder to prevent XSS attacks:

```java
// In JSP files
<%@ page import="com.equip.point.util.SecurityUtil" %>
<div><%= SecurityUtil.sanitizeHtml(userInput) %></div>

// In Servlets
String safeOutput = SecurityUtil.sanitizeHtml(request.getParameter("input"));
```

### SQL Injection Prevention

All database queries use PreparedStatements:

```java
String query = "SELECT * FROM user WHERE email = ?";
try (PreparedStatement ps = conn.prepareStatement(query)) {
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
}
```

---

## CSRF Protection

### CSRFUtil Class

Provides token generation and validation:

```java
// Generate token in session
String token = CSRFUtil.generateToken(session);

// Get existing token or create new one
String token = CSRFUtil.getToken(session);

// Validate token from request
boolean valid = CSRFUtil.validateToken(request);

// Invalidate token
CSRFUtil.invalidateToken(session);
```

### Usage in Forms

```jsp
<form method="post" action="/api/someAction">
    <input type="hidden" name="csrf_token" value="<%= CSRFUtil.getToken(session) %>">
    <!-- other form fields -->
</form>
```

### Usage in AJAX

```javascript
fetch('/api/someAction', {
    method: 'POST',
    headers: {
        'X-CSRF-Token': '<%= CSRFUtil.getToken(session) %>'
    },
    body: formData
});
```

---

## Rate Limiting

### Login Rate Limiting

The `SecurityFilter` implements rate limiting for login attempts:

- **Limit**: 5 failed attempts per IP address
- **Duration**: 15 minutes lockout period
- **Response**: HTTP 429 (Too Many Requests)

### Configuration

Rate limiting settings in `SecurityFilter.java`:

```java
private static final int MAX_LOGIN_ATTEMPTS = 5;
private static final long RATE_LIMIT_DURATION_MS = 15 * 60 * 1000; // 15 minutes
```

### Customization

To adjust rate limiting:
1. Modify `MAX_LOGIN_ATTEMPTS` for different threshold
2. Modify `RATE_LIMIT_DURATION_MS` for different lockout duration
3. Redeploy application

---

## Session Management

### Session Configuration

- **Timeout**: 30 minutes of inactivity
- **Tracking**: IP address and user agent
- **Storage**: Database-backed session tracking

### Session Security Features

```java
// Session creation with timeout
HttpSession session = request.getSession();
session.setAttribute(LOGGED_IN_USER, user);
session.setAttribute("lastAccessTime", System.currentTimeMillis());
session.setMaxInactiveInterval(30 * 60); // 30 minutes

// Session validation
Long lastAccessTime = (Long) session.getAttribute("lastAccessTime");
if (lastAccessTime != null && (now - lastAccessTime) > SESSION_TIMEOUT_MS) {
    session.invalidate();
    // Redirect to login
}
```

### Session Timeout

Automatic timeout after 30 minutes of inactivity. The `SecurityFilter` monitors session activity and invalidates expired sessions.

---

## Audit Logging

### AuditLogService

Comprehensive logging of security events:

```java
AuditLogService auditLog = new AuditLogService(connection);

// Log successful login
auditLog.logSuccessfulLogin(userId, ipAddress, userAgent);

// Log failed login
auditLog.logFailedLogin(email, ipAddress, userAgent, "Invalid credentials");

// Log logout
auditLog.logLogout(userId, ipAddress, userAgent);

// Log password change
auditLog.logPasswordChange(userId, ipAddress, userAgent);

// Log permission denied
auditLog.logPermissionDenied(userId, "DELETE", "user", ipAddress, userAgent);

// Log data access
auditLog.logDataAccess(userId, "VIEW", "equipment", equipmentId, ipAddress, userAgent);

// Log data modification
auditLog.logDataModification(userId, "UPDATE", "equipment", equipmentId, 
    ipAddress, userAgent, "Updated rental rate");
```

### Audit Log Table

The `audit_log` table tracks:
- User ID (if authenticated)
- Action performed
- Resource and resource ID
- IP address
- User agent
- Status (success/failure/warning)
- Details
- Timestamp

### Querying Audit Logs

```sql
-- Recent login attempts
SELECT * FROM audit_log 
WHERE action IN ('LOGIN', 'LOGIN_FAILED') 
ORDER BY created_date DESC 
LIMIT 100;

-- Failed login attempts for specific email
SELECT * FROM audit_log 
WHERE action = 'LOGIN_FAILED' 
AND resource_id = 'user@example.com'
ORDER BY created_date DESC;

-- Permission denied events
SELECT * FROM audit_log 
WHERE action = 'PERMISSION_DENIED' 
ORDER BY created_date DESC;

-- User activity
SELECT * FROM audit_log 
WHERE user_id = 123 
ORDER BY created_date DESC;
```

---

## Security Headers

### SecurityFilter Implementation

The `SecurityFilter` adds comprehensive security headers to all responses:

```java
// Prevent clickjacking
X-Frame-Options: DENY

// Enable XSS protection
X-XSS-Protection: 1; mode=block

// Prevent MIME sniffing
X-Content-Type-Options: nosniff

// Referrer policy
Referrer-Policy: strict-origin-when-cross-origin

// Content Security Policy
Content-Security-Policy: default-src 'self'; 
    script-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com; 
    style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com; 
    font-src 'self' https://cdnjs.cloudflare.com; 
    img-src 'self' data: https:;

// Permissions Policy
Permissions-Policy: geolocation=(), microphone=(), camera=()
```

### HTTPS Configuration (Recommended)

For production, enable HSTS header:

```java
// Add to SecurityFilter for HTTPS deployments
Strict-Transport-Security: max-age=31536000; includeSubDomains
```

---

## Role-Based Access Control

### Permission System

The system implements a granular permission model with 30+ permissions across 9 resource types.

### Resource Types

1. **User Management**: user.view, user.create, user.edit, user.delete
2. **Equipment**: equipment.view, equipment.create, equipment.edit, equipment.delete
3. **Categories**: category.view, category.create, category.edit, category.delete
4. **Bookings**: booking.view, booking.view.all, booking.create, booking.edit, booking.cancel, booking.approve
5. **Vendors**: vendor.view, vendor.create, vendor.edit, vendor.delete
6. **Contact**: contact.view, contact.reply, contact.approve
7. **Reports**: report.view, report.export
8. **System**: system.settings, system.audit
9. **Permissions**: permission.manage

### Default Role Permissions

**Admin Role**:
- All permissions (full system access)

**User Role**:
- View equipment, categories, bookings
- Create bookings
- View own bookings

### Authorization Filter

The `AuthorizationFilter` enforces permissions on protected endpoints:

```java
@WebFilter(urlPatterns = {"/api/*", "/dashboard/*", "/catagory/*", "/users/*", "/booking/*"})
public class AuthorizationFilter implements Filter {
    // Checks user permissions before allowing access
}
```

### Permission Checking

```java
PermissionService permissionService = new PermissionService(connection);

// Check if role has permission
boolean hasAccess = permissionService.hasPermission(
    roleId, 
    "equipment",  // resource
    "delete"      // action
);

// Get all permissions for a role
List<Permission> permissions = permissionService.getPermissionsByRole(roleId);
```

### Managing Permissions

```java
// Assign permission to role
permissionService.assignPermissionToRole(roleId, permissionId);

// Remove permission from role
permissionService.removePermissionFromRole(roleId, permissionId);

// Get all available permissions
List<Permission> allPermissions = permissionService.getAllPermissions();
```

---

## Database Security

### Enhanced Schema

The enhanced database schema includes:

1. **Permission Table**: Stores granular permissions
2. **Role_Permission Table**: Maps roles to permissions
3. **Audit_Log Table**: Tracks security events
4. **User_Session Table**: Manages active sessions

### Security Views

```sql
-- View user permissions
CREATE OR REPLACE VIEW v_user_permissions AS
SELECT 
    u.id as user_id,
    u.full_name,
    u.email,
    r.name as role_name,
    p.name as permission_name,
    p.resource,
    p.action
FROM user u
INNER JOIN role r ON u.role_id = r.id
INNER JOIN role_permission rp ON r.id = rp.role_id
INNER JOIN permission p ON rp.permission_id = p.id
WHERE u.is_deleted = 0;
```

### Database Migration

Run the enhanced schema file:

```bash
mysql -u root -p equip_point < src/main/java/com/equip/point/database_enhanced_schema.sql
```

### Existing Users

⚠️ **IMPORTANT**: Existing users with plain text passwords must be migrated:

```sql
-- Note: Passwords must be hashed programmatically using BCrypt
-- Do not store plain text passwords in the database
UPDATE user 
SET password = '[BCrypt_hashed_password]' 
WHERE id = [user_id];
```

Use a migration script to hash existing passwords:

```java
// Migration script example
for (User user : allUsers) {
    String plainPassword = user.getPassword(); // Get from secure source
    String hashedPassword = SecurityUtil.hashPassword(plainPassword);
    userService.updatePassword(user.getId(), hashedPassword);
}
```

---

## Deployment Guidelines

### Pre-Deployment Checklist

- [ ] Change default admin password
- [ ] Review and update database credentials in DbConstant.java
- [ ] Configure HTTPS/SSL certificates
- [ ] Enable HSTS header in SecurityFilter
- [ ] Review and adjust rate limiting settings
- [ ] Configure session timeout based on requirements
- [ ] Set up audit log monitoring
- [ ] Configure backup and recovery procedures
- [ ] Review CSP policy for production domains
- [ ] Migrate existing user passwords to BCrypt

### Environment Configuration

1. **Development**:
   - Use test database
   - Enable detailed error logging
   - Shorter session timeouts for testing

2. **Production**:
   - Use production database with restricted access
   - Disable stack traces in error responses
   - Enable HSTS header
   - Configure load balancer for session persistence
   - Set up audit log analysis and alerts

### Monitoring

Set up monitoring for:
- Failed login attempts (threshold alerts)
- Account lockouts
- Permission denied events
- Session timeout patterns
- Unusual access patterns
- Database connection issues

### Security Maintenance

Regular tasks:
- Review audit logs weekly
- Update dependencies monthly
- Rotate database credentials quarterly
- Review and update permissions annually
- Conduct security audits bi-annually

---

## Testing Security Features

### Password Hashing Test

```java
@Test
public void testPasswordHashing() {
    String password = "TestPass123!";
    String hash = SecurityUtil.hashPassword(password);
    
    assertTrue(SecurityUtil.verifyPassword(password, hash));
    assertFalse(SecurityUtil.verifyPassword("WrongPass", hash));
}
```

### CSRF Token Test

```java
@Test
public void testCSRFToken() {
    HttpSession session = request.getSession();
    String token = CSRFUtil.generateToken(session);
    
    assertNotNull(token);
    assertEquals(token, CSRFUtil.getToken(session));
}
```

### Rate Limiting Test

Test by making multiple failed login attempts from the same IP and verifying that the 6th attempt returns HTTP 429.

### Permission Test

```java
@Test
public void testPermissionCheck() {
    // Admin should have all permissions
    assertTrue(permissionService.hasPermission(adminRoleId, "user", "delete"));
    
    // Regular user should not have delete permission
    assertFalse(permissionService.hasPermission(userRoleId, "user", "delete"));
}
```

---

## Compliance & Standards

This implementation follows:

✅ **OWASP Top 10** - Protection against common vulnerabilities
✅ **NIST Guidelines** - Password and authentication standards
✅ **PCI DSS** - Data security standards (applicable sections)
✅ **GDPR** - Audit logging for data access tracking

---

## Support & Contact

For security concerns or questions:
- Review audit logs for suspicious activity
- Check application logs for error patterns
- Contact system administrator

**Remember**: Security is an ongoing process. Regularly review and update security measures as threats evolve.
