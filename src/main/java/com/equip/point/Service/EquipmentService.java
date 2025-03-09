package com.equip.point.Service;

import com.equip.point.model.Equipments;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class EquipmentService {

    private Connection conn;

    public EquipmentService(Connection conn) {
        super();
        this.conn = conn;
    }

    /**
     * This method is used to add the equipment
     *
     * @param equipment
     * @return boolean
     */
    public Boolean addEquipment(Equipments equipment) {
        boolean isEquipmentAdded = false;
        try {
            String query = "INSERT INTO equipments(model, manufacturing_year, operating_weight, engine_power, fuel_type, rental_rate, availability_status, location, rental_period, booked_status, last_serviced_date, notes, equipment_categories_id, user_id, created_date,is_active,is_deleted, image,description,vender_id) VALUES(? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ?, ?, now(),true,false, ?, ?, ?)";
            int i;
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, equipment.getModel());
                pstmt.setInt(2, equipment.getManufacturingYear());
                pstmt.setDouble(3, equipment.getOperatingWeight());
                pstmt.setDouble(4, equipment.getEnginePower());
                pstmt.setString(5, equipment.getFuelType());
                pstmt.setDouble(6, equipment.getRentalRate());
                pstmt.setString(7, equipment.getAvailabilityStatus());
                pstmt.setString(8, equipment.getLocation());
                pstmt.setLong(9, equipment.getRentalPeriod());
                pstmt.setString(10, equipment.getBookedStatus());
                pstmt.setString(11, equipment.getLastServicedDate());
                pstmt.setString(12, equipment.getNotes());
                pstmt.setLong(13, equipment.getEquipmentCategoriesId());
                pstmt.setLong(14, equipment.getUserId());
                pstmt.setString(15, equipment.getImage());
                pstmt.setString(16, equipment.getDescription());
                pstmt.setLong(17, equipment.getVendorId());
                i = pstmt.executeUpdate();
            }
            if (i == 1) {
                isEquipmentAdded = true;
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentService addEquipment: " + e.getMessage());
        }
        return isEquipmentAdded;
    }

    /**
     * This method is used to check if the equipment already exists
     *
     * @param model The model of the equipment
     * @return boolean
     */
    public Boolean checkEquipmentExist(String model) {
        boolean isEquipmentExist = false;
        try {
            String query = "SELECT COUNT(*) FROM equipments WHERE model = ? AND is_deleted = false";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, model);
                try (java.sql.ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);  // Get the count from the result set
                        if (count == 0) {
                            isEquipmentExist = false;
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentService checkEquipmentExist: " + e.getMessage());
        }
        return isEquipmentExist;
    }

    /**
     * This method is used to get the equipment by id
     *
     * @param id The id of the equipment
     * @return Equipments
     */
    public Equipments getEquipmentById(Long id) {
        Equipments equipment = null;
        try {
            String query = "SELECT * FROM equipments WHERE id = ? AND is_deleted = false";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, id);
                java.sql.ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    equipment = new Equipments();
                    equipment.setId(rs.getLong("id"));
                    equipment.setModel(rs.getString("model"));
                    equipment.setManufacturingYear(rs.getInt("manufacturing_year"));
                    equipment.setOperatingWeight(rs.getDouble("operating_weight"));
                    equipment.setEnginePower(rs.getDouble("engine_power"));
                    equipment.setFuelType(rs.getString("fuel_type"));
                    equipment.setRentalRate(rs.getDouble("rental_rate"));
                    equipment.setAvailabilityStatus(rs.getString("availability_status"));
                    equipment.setLocation(rs.getString("location"));
                    equipment.setRentalPeriod(rs.getLong("rental_period"));
                    equipment.setBookedStatus(rs.getString("booked_status"));
                    equipment.setLastServicedDate(rs.getString("last_serviced_date"));
                    equipment.setNotes(rs.getString("notes"));
                    equipment.setEquipmentCategoriesId(rs.getLong("equipment_categories_id"));
                    equipment.setUserId(rs.getLong("user_id"));
                    equipment.setEquipmentsCategories(rs.getString("equipments_category"));
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentService getEquipmentById: " + e.getMessage());
        }
        return equipment;
    }

    /**
     * This method is used to update the equipment
     *
     * @param equipment
     * @return boolean
     */
    public Boolean updateEquipment(Equipments equipment) {
        boolean isEquipmentUpdated = false;
        try {
            String query = "UPDATE equipments SET model = ?, manufacturing_year = ?, operating_weight = ?, engine_power = ?, fuel_type = ?, rental_rate = ?, availability_status = ?,description = ?,equipments_category = ? WHERE id = ?";
            int i;
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, equipment.getModel());
                pstmt.setInt(2, equipment.getManufacturingYear());
                pstmt.setDouble(3, equipment.getOperatingWeight());
                pstmt.setDouble(4, equipment.getEnginePower());
                pstmt.setString(5, equipment.getFuelType());
                pstmt.setDouble(6, equipment.getRentalRate());
                pstmt.setString(7, equipment.getAvailabilityStatus());
                pstmt.setString(8, equipment.getDescription());
                pstmt.setString(9, equipment.getEquipmentsCategories());
                pstmt.setLong(10, equipment.getId());
                i = pstmt.executeUpdate();
            }
            if (i == 1) {
                isEquipmentUpdated = true;
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentService updateEquipment: " + e.getMessage());
        }
        return isEquipmentUpdated;
    }
    /**
     * This method is used to delete the equipment
     *
     * @param id The id of the equipment
     * @return boolean
     */
    public Boolean deleteEquipment(long id) {
        boolean isEquipmentDeleted = false;
        try {
            String query = "UPDATE equipments SET is_deleted = true WHERE id = ?";
            int i;
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, id);
                i = pstmt.executeUpdate();
            }
            if (i == 1) {
                isEquipmentDeleted = true;
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentService deleteEquipment: " + e.getMessage());
        }
        return isEquipmentDeleted;
    }

    /**
     * This method is used to get the equipment by user id
     *
     * @param userId The id of the user
     * @return Equipments
     */
    public Equipments getEquipmentByUserId(long userId) {
        Equipments equipment = null;
        try {
            String query = "SELECT * FROM equipments WHERE user_id = ? AND is_deleted = false";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, userId);
                java.sql.ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    equipment = new Equipments();
                    equipment.setId(rs.getLong("id"));
                    equipment.setModel(rs.getString("model"));
                    equipment.setManufacturingYear(rs.getInt("manufacturing_year"));
                    equipment.setOperatingWeight(rs.getDouble("operating_weight"));
                    equipment.setEnginePower(rs.getDouble("engine_power"));
                    equipment.setFuelType(rs.getString("fuel_type"));
                    equipment.setRentalRate(rs.getDouble("rental_rate"));
                    equipment.setAvailabilityStatus(rs.getString("availability_status"));
                    equipment.setLocation(rs.getString("location"));
                    equipment.setRentalPeriod(rs.getLong("rental_period"));
                    equipment.setBookedStatus(rs.getString("booked_status"));
                    equipment.setLastServicedDate(rs.getString("last_serviced_date"));
                    equipment.setNotes(rs.getString("notes"));
                    equipment.setEquipmentCategoriesId(rs.getLong("equipment_categories_id"));
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentService getEquipmentByUserId: " + e.getMessage());
        }
        return equipment;
    }

    /**
     * This method is used to get all the equipment
     *
     * @return Equipments
     */
    public List<Equipments> getAllEquipment() {
        List<Equipments> equipmentList = new ArrayList<>();
        try {
            String query = "select * from equipments e left join categories c on c.id = e.vender_id left join categories  eq on eq.id = e.equipment_categories_id where c.is_deleted = false and eq.is_deleted = false and e.is_deleted = false;";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                java.sql.ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    Equipments equipment = new Equipments();
                    equipment.setId(rs.getLong("id"));
                    equipment.setModel(rs.getString("model"));
                    equipment.setManufacturingYear(rs.getInt("manufacturing_year"));
                    equipment.setOperatingWeight(rs.getDouble("operating_weight"));
                    equipment.setEnginePower(rs.getDouble("engine_power"));
                    equipment.setFuelType(rs.getString("fuel_type"));
                    equipment.setRentalRate(rs.getDouble("rental_rate"));
                    equipment.setAvailabilityStatus(rs.getString("availability_status"));
                    equipment.setLocation(rs.getString("location"));
                    equipment.setRentalPeriod(rs.getLong("rental_period"));
                    equipment.setBookedStatus(rs.getString("booked_status"));
                    equipment.setLastServicedDate(rs.getString("last_serviced_date"));
                    equipment.setNotes(rs.getString("notes"));
                    equipment.setEquipmentCategoriesId(rs.getLong("equipment_categories_id"));
                    equipment.setDescription(rs.getString("description"));
                    equipmentList.add(equipment);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentService getAllEquipment: " + e.getMessage());
        }
        return equipmentList;
    }

    public Long getEquipmentIdByName(String name) {
        Long id = null;
        try {
            String query = "SELECT id FROM equipments WHERE model = ? AND is_deleted = false";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, name);
                java.sql.ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    id = rs.getLong(1);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentService getEquipmentIdByName: " + e.getMessage());
        }
        return id;
    }

    public List<Equipments> getEquipmentByCategoryId(long categoryId) {
        List<Equipments> equipmentList = new ArrayList<>();
        try {
            String query = "SELECT * FROM equipments WHERE equipment_categories_id = ? AND is_deleted = false";
            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, categoryId);
                java.sql.ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    Equipments equipment = new Equipments();
                    equipment.setId(rs.getLong("id"));
                    equipment.setModel(rs.getString("model"));
                    equipment.setManufacturingYear(rs.getInt("manufacturing_year"));
                    equipment.setOperatingWeight(rs.getDouble("operating_weight"));
                    equipment.setEnginePower(rs.getDouble("engine_power"));
                    equipment.setFuelType(rs.getString("fuel_type"));
                    equipment.setRentalRate(rs.getDouble("rental_rate"));
                    equipment.setAvailabilityStatus(rs.getString("availability_status"));
                    equipment.setLocation(rs.getString("location"));
                    equipment.setRentalPeriod(rs.getLong("rental_period"));
                    equipment.setBookedStatus(rs.getString("booked_status"));
                    equipment.setLastServicedDate(rs.getString("last_serviced_date"));
                    equipment.setNotes(rs.getString("notes"));
                    equipmentList.add(equipment);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentService getEquipmentByCategoryId: " + e.getMessage());
        }
        return equipmentList;
    }
}
