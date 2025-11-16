package com.equip.point.Service;

import com.equip.point.model.Permission;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for permission management
 */
public class PermissionService {

    private Connection conn;

    public PermissionService(Connection conn) {
        this.conn = conn;
    }

    /**
     * Get all permissions for a specific role
     * @param roleId The role ID
     * @return List of permissions
     */
    public List<Permission> getPermissionsByRole(Long roleId) {
        List<Permission> permissions = new ArrayList<>();
        try {
            String query = "SELECT p.* FROM permission p " +
                    "INNER JOIN role_permission rp ON p.id = rp.permission_id " +
                    "WHERE rp.role_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setLong(1, roleId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Permission permission = new Permission();
                    permission.setId(rs.getLong("id"));
                    permission.setName(rs.getString("name"));
                    permission.setDescription(rs.getString("description"));
                    permission.setResource(rs.getString("resource"));
                    permission.setAction(rs.getString("action"));
                    permission.setCreatedDate(rs.getTimestamp("created_date"));
                    permission.setUpdatedDate(rs.getTimestamp("updated_date"));
                    permissions.add(permission);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in getPermissionsByRole: " + e.getMessage());
        }
        return permissions;
    }

    /**
     * Check if a role has a specific permission
     * @param roleId The role ID
     * @param resource The resource name
     * @param action The action name
     * @return true if permission exists, false otherwise
     */
    public boolean hasPermission(Long roleId, String resource, String action) {
        try {
            String query = "SELECT COUNT(*) as count FROM permission p " +
                    "INNER JOIN role_permission rp ON p.id = rp.permission_id " +
                    "WHERE rp.role_id = ? AND p.resource = ? AND p.action = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setLong(1, roleId);
                ps.setString(2, resource);
                ps.setString(3, action);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getInt("count") > 0;
                }
            }
        } catch (Exception e) {
            System.err.println("Error in hasPermission: " + e.getMessage());
        }
        return false;
    }

    /**
     * Get all permissions
     * @return List of all permissions
     */
    public List<Permission> getAllPermissions() {
        List<Permission> permissions = new ArrayList<>();
        try {
            String query = "SELECT * FROM permission ORDER BY resource, action";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Permission permission = new Permission();
                    permission.setId(rs.getLong("id"));
                    permission.setName(rs.getString("name"));
                    permission.setDescription(rs.getString("description"));
                    permission.setResource(rs.getString("resource"));
                    permission.setAction(rs.getString("action"));
                    permission.setCreatedDate(rs.getTimestamp("created_date"));
                    permission.setUpdatedDate(rs.getTimestamp("updated_date"));
                    permissions.add(permission);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in getAllPermissions: " + e.getMessage());
        }
        return permissions;
    }

    /**
     * Assign a permission to a role
     * @param roleId The role ID
     * @param permissionId The permission ID
     * @return true if successful, false otherwise
     */
    public boolean assignPermissionToRole(Long roleId, Long permissionId) {
        try {
            String query = "INSERT INTO role_permission (role_id, permission_id, created_date) VALUES (?, ?, NOW())";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setLong(1, roleId);
                ps.setLong(2, permissionId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.err.println("Error in assignPermissionToRole: " + e.getMessage());
        }
        return false;
    }

    /**
     * Remove a permission from a role
     * @param roleId The role ID
     * @param permissionId The permission ID
     * @return true if successful, false otherwise
     */
    public boolean removePermissionFromRole(Long roleId, Long permissionId) {
        try {
            String query = "DELETE FROM role_permission WHERE role_id = ? AND permission_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setLong(1, roleId);
                ps.setLong(2, permissionId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.err.println("Error in removePermissionFromRole: " + e.getMessage());
        }
        return false;
    }
}
