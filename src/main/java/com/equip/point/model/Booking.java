package com.equip.point.model;

import java.util.Date;

public class Booking {

    private int bookingId;
    private int equipmentId;
    private double totalCost;
    private int duration;
    private String status;
    private String purposeOfBooking;
    private boolean approved;
    private Date bookingDate;
    private Date startDate;
    private Date endDate;
    private int userId;
    private String comments;

    // Constructor
    public Booking(int equipmentId, double totalCost, int duration, String status, String purposeOfBooking,
                   boolean approved, Date startDate, Date endDate, int userId, String comments) {
        this.equipmentId = equipmentId;
        this.totalCost = totalCost;
        this.duration = duration;
        this.status = status;
        this.purposeOfBooking = purposeOfBooking;
        this.approved = approved;
        this.bookingDate = new Date(); // current date and time
        this.startDate = startDate;
        this.endDate = endDate;
        this.userId = userId;
        this.comments = comments;
    }

    // Getter and Setter methods

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getEquipmentId() {
        return equipmentId;
    }

    public void setEquipmentId(int equipmentId) {
        this.equipmentId = equipmentId;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPurposeOfBooking() {
        return purposeOfBooking;
    }

    public void setPurposeOfBooking(String purposeOfBooking) {
        this.purposeOfBooking = purposeOfBooking;
    }

    public boolean isApproved() {
        return approved;
    }

    public void setApproved(boolean approved) {
        this.approved = approved;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    // A method to convert the object to a string representation (useful for debugging or logging)
    @Override
    public String toString() {
        return "Booking{" +
                "bookingId=" + bookingId +
                ", equipmentId=" + equipmentId +
                ", totalCost=" + totalCost +
                ", duration=" + duration +
                ", status='" + status + '\'' +
                ", purposeOfBooking='" + purposeOfBooking + '\'' +
                ", approved=" + approved +
                ", bookingDate=" + bookingDate +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", userId=" + userId +
                ", comments='" + comments + '\'' +
                '}';
    }
}

