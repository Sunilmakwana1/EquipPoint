package com.equip.point.Service;

import com.equip.point.model.User;

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
            String query = "INSERT INTO user(full_name , email, password, role, status, phone, is_deleted , created_date ) VALUES(?, ?, ?, (select id from role where name = 'User' ) , true, ? , false , now())";
            int i;
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, user.getFullName());
                pstmt.setString(2, user.getEmail());
                pstmt.setString(3, user.getPassword());
                pstmt.setString(4, user.getPhone());
                i = pstmt.executeUpdate();
                System.out.println("User registered successfully");
            }
            if (i == 1) {
                isUserRegistered = true;
            }
        } catch (Exception e) {
            System.out.println("Error in RegisterService registerUser: " + e.getMessage());
        }
        return isUserRegistered;
    }
}