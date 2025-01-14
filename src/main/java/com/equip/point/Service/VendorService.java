package com.equip.point.Service;

import com.equip.point.model.Categories;
import com.equip.point.util.EquipPointUtil;
import com.equip.point.util.Type;

import java.sql.Connection;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

import static com.equip.point.util.AppConstant.FILE_PATH;

public class VendorService {

    private Connection conn;

    public VendorService(Connection conn) {
        super();
        this.conn = conn;
    }

    /**
     * This method is used to add the vendor
     *
     * @param vendor
     * @return boolean
     */
    public Boolean addVendor(Categories vendor) {
        boolean isVendorAdded = false;
        try {
            String query = "INSERT INTO categories(name, description, image, is_deleted, created_date,type) VALUES(? , ? , ? ,false, now(), ?)";
            int i;
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, vendor.getName());
                pstmt.setString(2, vendor.getDescription());
                pstmt.setString(3, vendor.getImage());
                pstmt.setString(4, vendor.getType().toString());
                i = pstmt.executeUpdate();
                System.out.println("Vendor added successfully");
            }
            if (i == 1) {
                isVendorAdded = true;
            }
        } catch (Exception e) {
            System.out.println("Error in VendorService addVendor: " + e.getMessage());
        }
        return isVendorAdded;
    }

    /**
     * This method is used to check if the vendor already exists
     *
     * @param vendorName The name of the vendor
     * @return boolean
     */
    public Boolean checkVendorExist(String vendorName) {
        boolean isVendorExist = true;
        try {
            String query = "SELECT COUNT(*) FROM categories WHERE name = ? AND is_deleted = false AND type = 'VENDOR'";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, vendorName);
                try (java.sql.ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        if (count == 0) {
                            isVendorExist = true;
                        } else {
                            isVendorExist = false;
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error in VendorService checkVendorExist: " + e.getMessage());
        }
        return isVendorExist;
    }

    /**
     * get all the vendors
     *
     * @return List<Categories>
     */
    public List<Categories> getAllVendors() {
        List<Categories> vendors = new ArrayList<>();
        try {
            String query = "SELECT * FROM categories WHERE type = 'VENDOR' AND is_deleted = false";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                try (java.sql.ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Long id = rs.getLong("id");
                        String name = rs.getString("name");
                        String description = rs.getString("description");
                        String image = rs.getString("image");
                        ZonedDateTime createdAt = rs.getObject("created_date", ZonedDateTime.class);
                        ZonedDateTime updatedAt = rs.getObject("updated_date", ZonedDateTime.class);
                        Boolean isDeleted = rs.getBoolean("is_deleted");
                        Categories categories = new Categories(id, name, description, image, createdAt, updatedAt, isDeleted, EquipPointUtil.getFullUrl(FILE_PATH + image));
                        vendors.add(categories);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error in VendorService getAllVendors: " + e.getMessage());
        }
        return vendors;
    }

    /**
     * This method is used to delete the vendor
     *
     * @param id The id of the vendor
     * @return boolean
     */
    public Boolean deleteVendor(Long id) {
        boolean isVendorDeleted = false;
        try {
            String query = "UPDATE categories SET is_deleted = true WHERE id = ? AND type = 'VENDOR'";
            int i;
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, id);
                i = pstmt.executeUpdate();
            }
            if (i == 1) {
                isVendorDeleted = true;
            }
        } catch (Exception e) {
            System.out.println("Error in VendorService deleteVendor: " + e.getMessage());
        }
        return isVendorDeleted;
    }

    /**
     * This method is used to get the vendor by id
     *
     * @param id The id of the vendor
     * @return Categories
     */
    public Categories getVendorById(Long id) {
        Categories vendor = null;
        try {
            String query = "SELECT * FROM categories WHERE id = ? AND type = 'VENDOR' AND is_deleted = false";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, id);
                try (java.sql.ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        String name = rs.getString("name");
                        String description = rs.getString("description");
                        String image = rs.getString("image");
                        ZonedDateTime createdAt = rs.getObject("created_date", ZonedDateTime.class);
                        ZonedDateTime updatedAt = rs.getObject("updated_date", ZonedDateTime.class);
                        Boolean isDeleted = rs.getBoolean("is_deleted");
                        vendor = new Categories(id, name, description, image, createdAt, updatedAt, isDeleted, EquipPointUtil.getFullUrl(FILE_PATH + image));
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error in VendorService getVendorById: " + e.getMessage());
        }
        return vendor;
    }

    /**
     * This method is used to update the vendor
     *
     * @param vendor The vendor object
     * @return boolean
     */
    public Boolean updateVendor(Categories vendor) {
        boolean isVendorUpdated = false;
        try {
            String query = "UPDATE categories SET name = ? , description = ? , image = ? , updated_date = now() , is_deleted = false WHERE id = ? AND type = 'VENDOR'";
            int i;
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, vendor.getName());
                pstmt.setString(2, vendor.getDescription());
                pstmt.setString(3, vendor.getImage());
                pstmt.setLong(4, vendor.getId());
                i = pstmt.executeUpdate();
            }
            if (i == 1) {
                isVendorUpdated = true;
            }
        } catch (Exception e) {
            System.out.println("Error in VendorService updateVendor: " + e.getMessage());
        }
        return isVendorUpdated;
    }

    /**
     * This method is used to get the vendor by name
     *
     * @param vendorName The name of the vendor
     * @return Categories
     */
    public Categories getVendorByName(String vendorName) {
        Categories vendor = null;
        try {
            String query = "SELECT * FROM categories WHERE name = ? AND type = 'VENDOR' AND is_deleted = false";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, vendorName);
                try (java.sql.ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        Long id = rs.getLong("id");
                        String name = rs.getString("name");
                        String description = rs.getString("description");
                        String image = rs.getString("image");
                        ZonedDateTime createdAt = rs.getObject("created_date", ZonedDateTime.class);
                        ZonedDateTime updatedAt = rs.getObject("updated_date", ZonedDateTime.class);
                        Boolean isDeleted = rs.getBoolean("is_deleted");
                        vendor = new Categories(id, name, description, image, createdAt, updatedAt, isDeleted, EquipPointUtil.getFullUrl(FILE_PATH + image));
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error in VendorService getVendorByName: " + e.getMessage());
        }
        return vendor;
    }

    /**
     * This method is to check while updating the vendor if the vendor already exists except the current vendor id
     * @param vendorName The name of the vendor
     */
    public Boolean checkVendorExistExceptCurrentVendorId(String vendorName, Long vendorId) {
        boolean isVendorExist = true;
        try {
            String query = "SELECT COUNT(*) FROM categories WHERE name = ? AND is_deleted = false AND type = 'VENDOR' AND id != ?";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, vendorName);
                pstmt.setLong(2, vendorId);
                try (java.sql.ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        if (count == 0) {
                            isVendorExist = true;
                        } else {
                            isVendorExist = false;
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error in VendorService checkVendorExistExceptCurrentVendorId: " + e.getMessage());
        }
        return isVendorExist;
    }

}
