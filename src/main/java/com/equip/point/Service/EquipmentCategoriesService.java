package com.equip.point.Service;

import com.equip.point.model.EquipmentCategories;
import com.equip.point.util.EquipPointUtil;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

import static com.equip.point.util.AppConstant.FILE_PATH;

public class EquipmentCategoriesService {

    private Connection conn ;

    public EquipmentCategoriesService(Connection conn) {
        super();
        this.conn = conn;
    }

    /**
     * This method is used to add the equipment categories
     * @param equipmentCategories
     * @return boolean
     */
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

    /**
     * This method is used to check if the equipment category already exists
     * @param categoryName  The name of the category
     * @return boolean
     */
    public Boolean checkEquipmentExist(String categoryName){
        boolean isEquipmentExist = true;
        try {
            String query = "SELECT COUNT(*) FROM equipment_categories WHERE name = ? AND is_deleted = false";
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

    /**
     * This method is used to get all the equipment categories
     * @return List of EquipmentCategories
     */
    public List<EquipmentCategories> getEquipmentCategories() {
        List<EquipmentCategories> equipmentCategoriesList = new ArrayList<>();
        try {
            String query = "SELECT * FROM equipment_categories WHERE is_deleted = false";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    Long id = rs.getLong("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    String image = rs.getString("image");
                    ZonedDateTime createdAt = rs.getObject("created_date", ZonedDateTime.class);
                    ZonedDateTime updatedAt = rs.getObject("updated_date", ZonedDateTime.class);
                    Boolean isDeleted = rs.getBoolean("is_deleted");
                    EquipmentCategories equipmentCategories = new EquipmentCategories(id, name, description, image, createdAt, updatedAt, isDeleted, EquipPointUtil.getFullUrl(FILE_PATH + image));
                    equipmentCategoriesList.add(equipmentCategories);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentCategoriesService getEquipmentCategories: " + e.getMessage());
        }
        return equipmentCategoriesList;
    }

    /**
     * This method is used to delete the equipment category
     * @param id The id of the equipment category
     * @return EquipmentCategories
     */
    public Boolean deleteEquipmentCategory(Long id) {
        boolean isEquipmentCategoryDeleted = false;
        try {
            String query = "UPDATE equipment_categories SET is_deleted = true WHERE id = ?";
            int i;
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, id);
                i = pstmt.executeUpdate();
            }
            if (i == 1) {
                isEquipmentCategoryDeleted = true;
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentCategoriesService deleteEquipmentCategory: " + e.getMessage());
        }
        return isEquipmentCategoryDeleted;
    }
}
