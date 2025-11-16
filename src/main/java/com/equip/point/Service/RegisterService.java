package com.equip.point.Service;

import com.equip.point.model.User;
import com.equip.point.util.SecurityUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class RegisterService {

    private Connection conn;

    public RegisterService(Connection conn) {
        super();
        this.conn = conn;
    }

    public Boolean registerUser(User user) {
        boolean isUserRegistered = false;
        try {
            // Hash the password before storing
            String hashedPassword = SecurityUtil.hashPassword(user.getPassword());
            
            String query = "INSERT INTO user(full_name , email, password, role_id, status, phone, is_deleted , created_date ) VALUES(?, ?, ?, (select id from role where name = 'User' ) , true, ? , false , now())";
            int i;
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, user.getFullName());
                pstmt.setString(2, user.getEmail());
                pstmt.setString(3, hashedPassword);
                pstmt.setString(4, user.getPhone());
                i = pstmt.executeUpdate();
                System.out.println("User registered successfully");
            }
            if (i == 1) {
                isUserRegistered = true;
            }
        } catch (Exception e) {
            System.err.println("Error in RegisterService registerUser: " + e.getMessage());
        }
        return isUserRegistered;
    }
}