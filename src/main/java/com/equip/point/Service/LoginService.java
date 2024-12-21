package com.equip.point.Service;

import com.equip.point.model.User;
import com.equip.point.util.DbConnection;

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
            String query = "SELECT * FROM user WHERE email=? AND password=?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, email);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getLong("id"));
                    user.setAddress(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                }
            }
        } catch (Exception e) {
            System.out.println("Error in LoginService loginUser: " + e.getMessage());
        }
        return user;
    }
}
