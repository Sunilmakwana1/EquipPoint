package com.equip.point.Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserService {

    private Connection conn;

    //constructor
    public UserService(Connection conn) {
        super();
        this.conn = conn;
    }

    public boolean checkIsEmailAvailable(String email) {
        boolean available = true;
        try {
            String sql = "SELECT COUNT(*) FROM user WHERE LOWER(email) = LOWER(?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    available = false; // Email is already in use
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService checkIsEmailAvailable : " + e.getMessage());
        }
        return available;
    }
}
