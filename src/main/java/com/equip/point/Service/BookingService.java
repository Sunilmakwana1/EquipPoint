package com.equip.point.Service;

import com.equip.point.model.Booking;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

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
                pstmt.setInt(1, booking.getEquipmentId());
                pstmt.setDouble(2, booking.getTotalCost());
                pstmt.setInt(3, booking.getDuration());
                pstmt.setString(4, booking.getStatus());
                pstmt.setString(5, booking.getPurposeOfBooking());
                pstmt.setBoolean(6, booking.isApproved());
                pstmt.setDate(7, new Date(booking.getStartDate().getTime()));
                pstmt.setDate(8, new Date(booking.getEndDate().getTime()));
                pstmt.setInt(9, booking.getUserId());
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
}
