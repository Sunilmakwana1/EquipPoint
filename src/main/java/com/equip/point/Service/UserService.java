package com.equip.point.Service;

import com.equip.point.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
            String sql = "SELECT COUNT(*) FROM user WHERE LOWER(email) = LOWER(?) AND is_deleted = false";
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

    private String getRoleNameById(Long roleId) {
        String roleName = null;
        String roleQuery = "SELECT name FROM role WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(roleQuery)) {
            ps.setLong(1, roleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                roleName = rs.getString("name");  // Get the role name
            }
        } catch (Exception e) {
            System.out.println("Error in getting Role Name by ID: " + e.getMessage());
        }
        return roleName;  // Return the role name as a String
    }


    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        User user = null;
        try {
            String query = "SELECT * FROM user WHERE is_deleted = false ORDER BY id DESC";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    user = new User();
                    user.setId(rs.getLong("id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));

                    // Get the role_id from the user table
                    Long roleId = rs.getLong("role_id");

                    // Fetch the corresponding Role object from the role table
                    String role = getRoleNameById(roleId);  // Fetch role by ID
                    user.setRole(role);  // Set the role object

                    user.setStatus(rs.getBoolean("status"));
                    user.setPhone(rs.getString("phone"));
                    user.setCountry(rs.getString("country"));
                    user.setCity(rs.getString("city"));
                    user.setPassword(rs.getString("password"));
                    user.setOtp(rs.getString("otp"));
                    userList.add(user);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService getAllUsers: " + e.getMessage());
        }
        return userList;

    }


    public User forgetPassword(String email) {
        User user = null;
        try {
            String query = "SELECT * FROM user WHERE email = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String otp = java.util.UUID.randomUUID().toString();
                    System.out.println("OTP: " + otp);
                    String passWordReset = "UPDATE user SET otp = ?, otp_created_date = now() WHERE email = ?";
                    try (PreparedStatement ps1 = conn.prepareStatement(passWordReset)) {
                        ps1.setString(1, otp);
                        ps1.setString(2, email);
                        ps1.executeUpdate();
                        user = new User();
                        user.setFullName(rs.getString("full_name"));
                        user.setEmail(rs.getString("email"));
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService forgetPassword: " + e.getMessage());
        }
        return user;
    }


    public Boolean resetPassword(String email, String password) {
        boolean isPasswordReset = false;
        try {
            String query = "UPDATE user SET password = ? WHERE email = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, password);
                ps.setString(2, email);
                int i = ps.executeUpdate();
                if (i == 1) {
                    isPasswordReset = true;
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService resetPassword: " + e.getMessage());
        }
        return isPasswordReset;
    }

    public boolean forgetPassword(String email, String question, String answer) {
        boolean isForgetPassword = false;
        try {
            String query = "SELECT * from user u left join security_questions_answer sqa on u.id = sqa.user_id left join security_questions sq on sqa.question_id = sq.id where u.email = ? and sq.question = ? and sqa.answer = ? and u.is_deleted = false";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, email);
                ps.setString(2, question);
                ps.setString(3, answer);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    isForgetPassword = true;
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService forgetPassword: " + e.getMessage());
        }
        return isForgetPassword;
    }

    public boolean checkIsPhoneNumberAvailable(String phone) {
        boolean available = true;
        try {
            String sql = "SELECT COUNT(*) FROM user WHERE phone = ? AND is_deleted = false";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    available = false; // Phone number is already in use
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService checkIsPhoneAvailable : " + e.getMessage());
        }
        return available;
    }

    /**
     * This method is used to get the email by phone
     * @param phone
     * @return String
     */
    public String getEmailByPhone(String phone) {
        String email = null;
        try {
            String query = "SELECT email FROM user WHERE phone = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, phone);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    email = rs.getString("email");
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService getEmailByPhone: " + e.getMessage());
        }
        return email;
    }

    /**
     * This method is used to delete a user
     * @param id
     * @return boolean
     */
    public boolean deleteUser(Long id) {
        boolean isDeleted = false;
        try {
            String query = "UPDATE user SET is_deleted = true WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setLong(1, id);
                int i = ps.executeUpdate();
                if (i == 1) {
                    isDeleted = true;
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService deleteUser: " + e.getMessage());
        }
        return isDeleted;
    }

    //get the login user role
    public String getRoleNameByEmail(String email) {
        String roleName = null;
        try {
            String query = "SELECT r.name FROM role r JOIN user u ON r.id = u.role_id WHERE u.email = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    roleName = rs.getString("name");
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService getRoleNameByEmail: " + e.getMessage());
        }
        return roleName;
    }

    /**
     * This method is to get the user by id
     */
    public User getUserById(Long id) {
        User user = null;
        try {
            String query = "SELECT * FROM user WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setLong(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getLong("id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));

                    // Get the role_id from the user table
                    Long roleId = rs.getLong("role_id");

                    // Fetch the corresponding Role object from the role table
                    String role = getRoleNameById(roleId);  // Fetch role by ID
                    user.setRole(role);  // Set the role object

                    user.setStatus(rs.getBoolean("status"));
                    user.setPhone(rs.getString("phone"));
                    user.setCountry(rs.getString("country"));
                    user.setCity(rs.getString("city"));
                    user.setPassword(rs.getString("password"));
                    user.setOtp(rs.getString("otp"));
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService getUserById: " + e.getMessage());
        }
        return user;
    }


}