package com.equip.point.model;

import java.lang.String;
import java.math.BigDecimal;
import java.time.LocalDate;

public class Booking {

    private Long bookingId;
    private Long equipmentId;
    private BigDecimal totalCost = BigDecimal.ZERO;
    private Long duration;
    private String status = "Pending";
    private String purposeOfBooking;
    private boolean approved;
    private String bookingDate;
    private String startDate;
    private String endDate;
    private Long userId;
    private String comments;
    private BigDecimal rentalRate = BigDecimal.ZERO;
    

    public Booking() {
    }

    public Long getBookingId() {
        return bookingId;
    }

    public void setBookingId(Long bookingId) {
        this.bookingId = bookingId;
    }

    public Long getEquipmentId() {
        return equipmentId;
    }

    public void setEquipmentId(Long equipmentId) {
        this.equipmentId = equipmentId;
    }

    public BigDecimal getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(BigDecimal totalCost) {
        this.totalCost = totalCost;
    }

    public Long getDuration() {
        return duration;
    }

    public void setDuration(Long duration) {
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

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public BigDecimal getRentalRate() {
        return rentalRate;
    }

    public void setRentalRate(BigDecimal rentalRate) {
        this.rentalRate = rentalRate;
    }

    public Booking(Long equipmentId, Long duration, String bookingDate, BigDecimal rentalRate, String purposeOfBooking, BigDecimal totalCost,Long userId) {
        this.equipmentId = equipmentId;
        this.duration = duration;
        this.bookingDate = bookingDate;
        this.rentalRate = rentalRate;
        this.purposeOfBooking = purposeOfBooking;
        this.totalCost = totalCost;
        this.startDate = bookingDate;
        this.endDate = String.valueOf(java.sql.Date.valueOf(LocalDate.parse(bookingDate).plusDays(duration)));
        this.userId = userId;
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

