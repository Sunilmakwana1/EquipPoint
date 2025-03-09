package com.equip.point.Service;

import com.equip.point.model.Booking;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookingService {
    private Connection conn;

    public BookingService(Connection conn) {
        super();
        this.conn = conn;
    }

    public Boolean bookEquipment(Booking booking) {
        boolean isBookingSuccessful = false;
        try {
            String query = "INSERT INTO booking(equipment_id, total_cost, duration, status, purpose_of_booking, approved, booking_date, start_date, end_date, user_id, comments) VALUES(?, ?, ?, ?, ?, ?, now(), ?, ?, ?, ?)";
            int i;
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, booking.getEquipmentId());
                pstmt.setBigDecimal(2, booking.getTotalCost());
                pstmt.setLong(3, booking.getDuration());
                pstmt.setString(4, booking.getStatus());
                pstmt.setString(5, booking.getPurposeOfBooking());
                pstmt.setBoolean(6, booking.isApproved());
                pstmt.setString(7, booking.getStartDate());
                pstmt.setString(8, booking.getEndDate());
                pstmt.setLong(9, booking.getUserId());
                pstmt.setString(10, booking.getComments());
                i = pstmt.executeUpdate();
                System.out.println("Booking created successfully");
            }
            if (i == 1) {
                isBookingSuccessful = true;
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService bookEquipment: " + e.getMessage());
        }
        return isBookingSuccessful;
    }


    public Long getBookingIdByUserId(Long userId) {
        Long bookingId = null;
        try {
            String query = "SELECT booking_id FROM booking WHERE user_id = ? ORDER BY created_date DESC LIMIT 1";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, userId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    bookingId = rs.getLong("booking_id");
                }
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService getBookingIdByUserId: " + e.getMessage());
        }
        return bookingId;
    }
}
