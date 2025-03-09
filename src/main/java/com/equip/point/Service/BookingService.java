package com.equip.point.Service;

import com.equip.point.model.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        EquipmentService equipmentService = new EquipmentService(conn);
        try {
            String query = "SELECT * FROM booking ORDER BY created_date DESC";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getLong("booking_id"));
                    booking.setEquipmentId(rs.getLong("equipment_id"));
                    booking.setTotalCost(rs.getBigDecimal("total_cost"));
                    booking.setDuration(rs.getLong("duration"));
                    booking.setStatus(rs.getString("status"));
                    booking.setPurposeOfBooking(rs.getString("purpose_of_booking"));
                    booking.setApproved(rs.getBoolean("approved"));
                    booking.setBookingDate(rs.getString("booking_date"));
                    booking.setStartDate(rs.getString("start_date"));
                    booking.setEndDate(rs.getString("end_date"));
                    booking.setUserId(rs.getLong("user_id"));
                    booking.setComments(rs.getString("comments"));
                    booking.setModelName(equipmentService.getEquipmentById(booking.getEquipmentId()).getModel());
                    bookings.add(booking);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService getAllBookings: " + e.getMessage());
        }
        return bookings;
    }


    public List<Booking> getBookingsByUserId(Long userId) {
        List<Booking> bookings = new ArrayList<>();
        try {
            String query = "SELECT * FROM booking WHERE user_id = ? ORDER BY created_date DESC";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, userId);
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getLong("booking_id"));
                    booking.setEquipmentId(rs.getLong("equipment_id"));
                    booking.setTotalCost(rs.getBigDecimal("total_cost"));
                    booking.setDuration(rs.getLong("duration"));
                    booking.setStatus(rs.getString("status"));
                    booking.setPurposeOfBooking(rs.getString("purpose_of_booking"));
                    booking.setApproved(rs.getBoolean("approved"));
                    booking.setBookingDate(rs.getString("booking_date"));
                    booking.setStartDate(rs.getString("start_date"));
                    booking.setEndDate(rs.getString("end_date"));
                    booking.setUserId(rs.getLong("user_id"));
                    booking.setComments(rs.getString("comments"));
                    bookings.add(booking);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService getBookingsByUserId: " + e.getMessage());
        }
        return bookings;
    }


    public List<Booking> getAllBookings(int pageNumber, int pageSize) {
        List<Booking> bookings = new ArrayList<>();
        EquipmentService equipmentService = new EquipmentService(conn);
        try {
            int offset = (pageNumber - 1) * pageSize;
            String query = "SELECT * FROM booking ORDER BY created_date DESC LIMIT ? OFFSET ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, pageSize);  // Number of records per page
                pstmt.setInt(2, offset);    // The offset to skip for pagination
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getLong("booking_id"));
                    booking.setEquipmentId(rs.getLong("equipment_id"));
                    booking.setTotalCost(rs.getBigDecimal("total_cost"));
                    booking.setDuration(rs.getLong("duration"));
                    booking.setStatus(rs.getString("status"));
                    booking.setPurposeOfBooking(rs.getString("purpose_of_booking"));
                    booking.setApproved(rs.getBoolean("approved"));
                    booking.setBookingDate(rs.getString("booking_date"));
                    booking.setStartDate(rs.getString("start_date"));
                    booking.setEndDate(rs.getString("end_date"));
                    booking.setUserId(rs.getLong("user_id"));
                    booking.setComments(rs.getString("comments"));
                    booking.setModelName(equipmentService.getEquipmentById(booking.getEquipmentId()).getModel());
                    bookings.add(booking);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService getAllBookings: " + e.getMessage());
        }
        return bookings;
    }

    public List<Booking> getBookingsByUserId(Long userId, int pageNumber, int pageSize) {
        List<Booking> bookings = new ArrayList<>();
        EquipmentService equipmentService = new EquipmentService(conn);
        try {
            int offset = (pageNumber - 1) * pageSize;
            String query = "SELECT * FROM booking WHERE user_id = ? ORDER BY created_date DESC LIMIT ? OFFSET ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, userId);
                pstmt.setInt(2, pageSize);  // Number of records per page
                pstmt.setInt(3, offset);    // The offset to skip for pagination
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getLong("booking_id"));
                    booking.setEquipmentId(rs.getLong("equipment_id"));
                    booking.setTotalCost(rs.getBigDecimal("total_cost"));
                    booking.setDuration(rs.getLong("duration"));
                    booking.setStatus(rs.getString("status"));
                    booking.setPurposeOfBooking(rs.getString("purpose_of_booking"));
                    booking.setApproved(rs.getBoolean("approved"));
                    booking.setBookingDate(rs.getString("booking_date"));
                    booking.setStartDate(rs.getString("start_date"));
                    booking.setEndDate(rs.getString("end_date"));
                    booking.setUserId(rs.getLong("user_id"));
                    booking.setComments(rs.getString("comments"));
                    booking.setModelName(equipmentService.getEquipmentById(booking.getEquipmentId()).getModel());
                    bookings.add(booking);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService getBookingsByUserId: " + e.getMessage());
        }
        return bookings;
    }

    public int getTotalBookingsCount() {
        int count = 0;
        try {
            String query = "SELECT COUNT(*) FROM booking";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService getTotalBookingsCount: " + e.getMessage());
        }
        return count;
    }

    public int getTotalBookingsByUserIdCount(Long userId) {
        int count = 0;
        try {
            String query = "SELECT COUNT(*) FROM booking WHERE user_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, userId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService getTotalBookingsByUserIdCount: " + e.getMessage());
        }
        return count;
    }

}
