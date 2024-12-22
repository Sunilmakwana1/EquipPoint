package com.equip.point.Service;

import com.equip.point.model.EquipmentCategories;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EquipmentCategoriesService {

    private Connection conn ;

    public EquipmentCategoriesService(Connection conn) {
        super();
        this.conn = conn;
    }

    public Boolean addEquipmentCategories(EquipmentCategories equipmentCategories) {
        boolean isEquipmentCategoriesAdded = false;
        try {
            String query = "INSERT INTO equipment_categories(name, description, image, is_deleted, created_date) VALUES(? , ? , ? ,false, now())";
            int i;
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, equipmentCategories.getName());
                pstmt.setString(2, equipmentCategories.getDescription());
                pstmt.setString(3, equipmentCategories.getImage());
                i = pstmt.executeUpdate();
                System.out.println("Equipment Categories added successfully");
            }
            if (i == 1) {
                isEquipmentCategoriesAdded = true;
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentCategoriesService addEquipmentCategories: " + e.getMessage());
        }
        return isEquipmentCategoriesAdded;
    }

    public Boolean checkEquipmentExist(String categoryName){
        boolean isEquipmentExist = true;
        try {
            String query = "SELECT COUNT(*) FROM equipment_categories WHERE name = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, categoryName);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    int count = rs.getInt(1);
                    if (count > 0) {
                        isEquipmentExist = false;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentCategoriesService checkEquipmentExist: " + e.getMessage());
        }
        return isEquipmentExist;
    }
}
