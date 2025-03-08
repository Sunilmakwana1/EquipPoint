package com.equip.point.Service;

import com.equip.point.model.Categories;
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
     * @param categories
     * @return boolean
     */
    public Boolean addEquipmentCategories(Categories categories) {
        boolean isEquipmentCategoriesAdded = false;
        try {
            String query = "INSERT INTO categories(name, description, image, is_deleted, created_date, type) VALUES(? , ? , ? ,false, now(), ?)";
            int i;
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, categories.getName());
                pstmt.setString(2, categories.getDescription());
                pstmt.setString(3, categories.getImage());
                pstmt.setString(4, categories.getType().toString());
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
            String query = "SELECT COUNT(*) FROM categories WHERE name = ? AND is_deleted = false AND type = 'EQUIPMENT'";
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
     * @return List of Categories
     */
    public List<Categories> getEquipmentCategories() {
        List<Categories> categoriesList = new ArrayList<>();
        try {
            String query = "SELECT * FROM categories WHERE is_deleted = false AND type = 'EQUIPMENT'";
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
                    Categories categories = new Categories(id, name, description, image, createdAt, updatedAt, isDeleted, EquipPointUtil.getFullUrl(FILE_PATH + image));
                    categoriesList.add(categories);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentCategoriesService getEquipmentCategories: " + e.getMessage());
        }
        return categoriesList;
    }

    /**
     * This method is used to delete the equipment category
     * @param id The id of the equipment category
     * @return Categories
     */
    public Boolean deleteEquipmentCategory(Long id) {
        boolean isEquipmentCategoryDeleted = false;
        try {
            String query = "UPDATE categories SET is_deleted = true WHERE id = ? AND type = 'EQUIPMENT'";
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
