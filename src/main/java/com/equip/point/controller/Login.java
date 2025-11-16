package com.equip.point.controller;

import com.equip.point.Service.AuditLogService;
import com.equip.point.Service.LoginService;
import com.equip.point.model.User;
import com.equip.point.util.DbConnection;
import com.equip.point.util.EquipPointUtil;
import com.equip.point.util.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.Objects;

import static com.equip.point.util.AppConstant.*;

@WebServlet("/api/auth")
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get the email and password from the request
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        
        // Get client information for audit logging
        String ipAddress = getClientIP(req);
        String userAgent = req.getHeader("User-Agent");

        // Validate input
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute(LOGIN_ERROR, "Email and password are required");
            req.getRequestDispatcher("/login/login.jsp").forward(req, resp);
            return;
        }

        // Sanitize email input
        email = SecurityUtil.sanitizeHtml(email.trim());

        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            HttpSession session = req.getSession();
            LoginService loginService = new LoginService(conn);
            AuditLogService auditLogService = new AuditLogService(conn);
            
            User user = loginService.loginUser(email, password);
            
            if (Objects.nonNull(user)) {
                // Successful login
                System.out.printf("Login successful for user with ID: %d%n", user.getId());
                
                // Create session
                session.setAttribute(LOGGED_IN_USER, user);
                session.setAttribute("lastAccessTime", System.currentTimeMillis());
                session.setMaxInactiveInterval(30 * 60); // 30 minutes
                
                EquipPointUtil.getCurrentLoginUser(user);
                
                // Log successful login
                auditLogService.logSuccessfulLogin(user.getId(), ipAddress, userAgent);
                
                resp.sendRedirect("/dashboard/dasboard.jsp");
            } else {
                // Failed login
                System.out.printf("Login failed for email: %s%n", email);
                
                // Log failed login attempt
                auditLogService.logFailedLogin(email, ipAddress, userAgent, "Invalid credentials");
                
                req.setAttribute(LOGIN_ERROR, LOGIN_ERROR_MESSAGE);
                req.getRequestDispatcher("/login/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            System.err.println("Error in Login doPost: " + e.getMessage());
            req.setAttribute(LOGIN_ERROR, "An error occurred during login. Please try again.");
            req.getRequestDispatcher("/login/login.jsp").forward(req, resp);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
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
}
