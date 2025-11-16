package com.equip.point.filter;

import com.equip.point.Service.PermissionService;
import com.equip.point.model.User;
import com.equip.point.util.DbConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;

import static com.equip.point.util.AppConstant.LOGGED_IN_USER;

/**
 * Authorization filter for role-based access control
 * This filter checks if the user has the necessary permissions to access protected resources
 */
@WebFilter(urlPatterns = {"/api/*", "/dashboard/*", "/catagory/*", "/users/*", "/booking/*"})
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Allow access to login and registration endpoints
        if (isPublicEndpoint(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in
        if (session == null || session.getAttribute(LOGGED_IN_USER) == null) {
            httpResponse.sendRedirect(contextPath + "/login/login.jsp");
            return;
        }

        User user = (User) session.getAttribute(LOGGED_IN_USER);
        
        // Check permissions for protected resources
        if (requiresPermissionCheck(path)) {
            if (!hasPermission(user, path, httpRequest.getMethod())) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Insufficient permissions");
                return;
            }
        }

        // User is authorized, continue with the request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }

    /**
     * Check if the endpoint is public (doesn't require authentication)
     */
    private boolean isPublicEndpoint(String path) {
        return path.equals("/api/auth") ||
               path.equals("/api/register") ||
               path.startsWith("/login/") ||
               path.startsWith("/users/signUp") ||
               path.startsWith("/images/") ||
               path.startsWith("/src/") ||
               path.equals("/") ||
               path.equals("/index.jsp");
    }

    /**
     * Check if the path requires permission checking
     */
    private boolean requiresPermissionCheck(String path) {
        // Admin-only resources
        return path.startsWith("/users/viewUsers") ||
               path.startsWith("/users/addedUser") ||
               path.startsWith("/api/user/delete") ||
               path.startsWith("/catagory/addEquipment") ||
               path.startsWith("/catagory/editEquipment") ||
               path.startsWith("/catagory/addVendor") ||
               path.startsWith("/catagory/editVendor") ||
               path.startsWith("/catagory/addEquipmentCategories") ||
               path.startsWith("/dashboard/detailViewOfSupprotTicket");
    }

    /**
     * Check if user has permission to access the resource
     */
    private boolean hasPermission(User user, String path, String method) {
        try {
            Connection conn = DbConnection.getConnection();
            PermissionService permissionService = new PermissionService(conn);
            
            // Get user role
            String role = user.getRole();
            Long roleId;
            try {
                roleId = Long.parseLong(role);
            } catch (NumberFormatException nfe) {
                System.err.println("Invalid role format for user: " + role);
                return false;
            }

            // Map path to resource and action
            String resource = getResourceFromPath(path);
            String action = getActionFromMethod(method);

            // Check permission
            return permissionService.hasPermission(roleId, resource, action);
        } catch (Exception e) {
            System.err.println("Error checking permissions: " + e.getMessage());
            return false;
        }
    }

    /**
     * Extract resource name from path
     */
    private String getResourceFromPath(String path) {
        if (path.contains("/users/")) return "user";
        if (path.contains("/catagory/") || path.contains("/equipment")) return "equipment";
        if (path.contains("/booking/")) return "booking";
        if (path.contains("/vendor")) return "vendor";
        if (path.contains("/contact")) return "contact";
        return "unknown";
    }

    /**
     * Map HTTP method to action
     */
    private String getActionFromMethod(String method) {
        switch (method.toUpperCase()) {
            case "GET": return "view";
            case "POST": return "create";
            case "PUT": return "edit";
            case "DELETE": return "delete";
            default: return "view";
        }
    }
}
