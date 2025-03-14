package com.equip.point.util;

import com.equip.point.model.User;
import jakarta.servlet.http.Part;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

import static com.equip.point.util.AppConstant.FILE_PATH;

public class EquipPointUtil {

    /**
     * Upload file to the specified path
     * @param uploadPath
     * @param filePart
     */
    public static void uploadFile(String uploadPath, Part filePart) {
        try {
            FileOutputStream fos = new FileOutputStream(uploadPath);
            InputStream is = filePart.getInputStream();
            byte[] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
            fos.close();
        } catch (Exception e) {
            System.out.println("Unable to Upload File: "+ e.getMessage());
        }
    }


    public static void equpmentUploadFile(String uploadPath, Part filePart1) {
        try {
            FileOutputStream fos1 = new FileOutputStream(uploadPath);
            InputStream is = filePart1.getInputStream();
            byte[] data = new byte[is.available()];
            is.read(data);
            fos1.write(data);
            fos1.close();
        } catch (Exception e) {
            System.out.println("Unable to Upload File: "+ e.getMessage());
        }
    }



    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }


    public static boolean isTrueNotNull(Boolean value) {
        return Boolean.TRUE.equals(value);
    }

    public static String getFullUrl(String imageUrl){
        return FILE_PATH + imageUrl;
    }


    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    public static boolean isNotNull(Object o) {
        return o != null;
    }

    public static boolean isEqualToAdmin(String role) {
        return "Admin".equalsIgnoreCase(role);
    }

    public static boolean isEqualToUser(String role) {
        return "User".equalsIgnoreCase(role);
    }

    public static boolean isNotNullOrEmptyString(String s) {
        return s != null && !s.trim().isEmpty();
    }

    public static void getCurrentLoginUser(User user) {
        CurrentLoginUser currentLoginUser = new CurrentLoginUser();
        currentLoginUser.setEmail(user.getEmail());
        currentLoginUser.setUserId(user.getId());
        currentLoginUser.setRole(user.getRole());
    }



    public static void  setCurrentUserInSession(Connection conn) throws Exception {
        String setCurrentUserQuery = "SET @current_user = ?";
        try (PreparedStatement setStmt = conn.prepareStatement(setCurrentUserQuery)) {
            setStmt.setString(1, CurrentLoginUser.getCurrentLoginUser());  // Set the current user (username or userId)
            setStmt.executeUpdate();  // Set the session variable
        }
    }
}
