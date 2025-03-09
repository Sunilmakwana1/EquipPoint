package com.equip.point.model;

import com.equip.point.util.CurrentLoginUser;

public class Equipments {

    private Long id;
    private String model;
    private int manufacturingYear;
    private double operatingWeight;
    private double enginePower;
    private String fuelType;
    private double rentalRate;
    private String availabilityStatus = "Available";
    private String location;
    private long rentalPeriod;
    private String bookedStatus;
    private String lastServicedDate;
    private String notes;
    private Long equipmentCategoriesId;
    private Long userId;
    private String createdDate;
    private String updatedDate;
    private String image;
    private String description;
    private Long vendorId;
    private String equipmentsCategories;

    public Equipments() {
        super();
    }

    public Equipments(String model, int manufacturingYear, double operatingWeight, double enginePower,
                      String fuelType, double rentalRate, String availabilityStatus, String location,
                      long rentalPeriod, String bookedStatus, String lastServicedDate, String notes,
                      Long equipmentCategoriesId, Long userId, String createdDate, String updatedDate , String image, String description) {
        this.model = model;
        this.manufacturingYear = manufacturingYear;
        this.operatingWeight = operatingWeight;
        this.enginePower = enginePower;
        this.fuelType = fuelType;
        this.rentalRate = rentalRate;
        this.availabilityStatus = availabilityStatus;
        this.location = location;
        this.rentalPeriod = rentalPeriod;
        this.bookedStatus = bookedStatus;
        this.lastServicedDate = lastServicedDate;
        this.notes = notes;
        this.equipmentCategoriesId = equipmentCategoriesId;
        this.userId = userId;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.image = image;
        this.description = description;
    }

    public Equipments(String model, String description, String image, Long equipmentCategoriesId , Long vendorId) {
        this.model = model;
        this.description = description;
        this.image = image;
        this.equipmentCategoriesId = equipmentCategoriesId;
        this.vendorId = vendorId;
    }

    // Getters and Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getManufacturingYear() {
        return manufacturingYear;
    }

    public void setManufacturingYear(int manufacturingYear) {
        this.manufacturingYear = manufacturingYear;
    }

    public double getOperatingWeight() {
        return operatingWeight;
    }

    public void setOperatingWeight(double operatingWeight) {
        this.operatingWeight = operatingWeight;
    }

    public double getEnginePower() {
        return enginePower;
    }

    public void setEnginePower(double enginePower) {
        this.enginePower = enginePower;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public double getRentalRate() {
        return rentalRate;
    }

    public void setRentalRate(double rentalRate) {
        this.rentalRate = rentalRate;
    }

    public String getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public long getRentalPeriod() {
        return rentalPeriod;
    }

    public void setRentalPeriod(long rentalPeriod) {
        this.rentalPeriod = rentalPeriod;
    }

    public String getBookedStatus() {
        return bookedStatus;
    }

    public void setBookedStatus(String bookedStatus) {
        this.bookedStatus = bookedStatus;
    }

    public String getLastServicedDate() {
        return lastServicedDate;
    }

    public void setLastServicedDate(String lastServicedDate) {
        this.lastServicedDate = lastServicedDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Long getEquipmentCategoriesId() {
        return equipmentCategoriesId;
    }

    public void setEquipmentCategoriesId(Long equipmentCategoriesId) {
        this.equipmentCategoriesId = equipmentCategoriesId;
    }

    public Long getUserId() {
        return userId = CurrentLoginUser.getCurrentLoginUserId();
    }

    public void setUserId(Long userId) {
        this.userId =    userId;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(String updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getVendorId() {
        return vendorId;
    }

    public void setVendorId(Long vendorId) {
        this.vendorId = vendorId;
    }

    public String getEquipmentsCategories() {
        return equipmentsCategories;
    }

    public void setEquipmentsCategories(String equipmentsCategories) {
        this.equipmentsCategories = equipmentsCategories;
    }

    @Override
    public String toString() {
        return "Equipments{" +
                "id=" + id +
                ", model='" + model + '\'' +
                ", manufacturingYear=" + manufacturingYear +
                ", operatingWeight=" + operatingWeight +
                ", enginePower=" + enginePower +
                ", fuelType='" + fuelType + '\'' +
                ", rentalRate=" + rentalRate +
                ", availabilityStatus='" + availabilityStatus + '\'' +
                ", location='" + location + '\'' +
                ", rentalPeriod=" + rentalPeriod +
                ", bookedStatus='" + bookedStatus + '\'' +
                ", lastServicedDate='" + lastServicedDate + '\'' +
                ", notes='" + notes + '\'' +
                ", equipmentCategoriesId=" + equipmentCategoriesId +
                ", userId=" + userId +
                ", createdDate='" + createdDate + '\'' +
                ", updatedDate='" + updatedDate + '\'' +
                '}';
    }
}
