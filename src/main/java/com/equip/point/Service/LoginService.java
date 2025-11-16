package com.equip.point.Service;

import com.equip.point.model.User;
import com.equip.point.util.DbConnection;
import com.equip.point.util.SecurityUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginService {

    private Connection conn = DbConnection.getConnection();

    public LoginService(Connection conn) {
        super();
        this.conn = conn;
    }


    public User loginUser(String email, String password) {
        User user = null;
        try {
            // First, get the user by email only
            String query = "SELECT * FROM user WHERE email=? AND is_deleted = false AND status = true";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String storedPassword = rs.getString("password");
                    
                    // Verify password using BCrypt
                    if (SecurityUtil.verifyPassword(password, storedPassword)) {
                        user = new User();
                        user.setId(rs.getLong("id"));
                        user.setFullName(rs.getString("full_name"));
                        user.setEmail(rs.getString("email"));
                        user.setPassword(storedPassword);
                        user.setRole(rs.getString("role_id"));
                        user.setStatus(rs.getBoolean("status"));
                        user.setPhone(rs.getString("phone"));
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error in LoginService loginUser: " + e.getMessage());
        }
        return user;
    }
}
