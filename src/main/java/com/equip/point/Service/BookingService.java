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
                pstmt.setString(4, "Booked");
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


    public List<Booking> getAllBookings(int pageNumber, int pageSize, String searchTerm) {
        List<Booking> bookings = new ArrayList<>();
        EquipmentService equipmentService = new EquipmentService(conn);
        try {
            int offset = (pageNumber - 1) * pageSize;

            // Constructing the search query
            StringBuilder queryBuilder = new StringBuilder("SELECT * FROM booking b left join equipments e on b.equipment_id = e.id WHERE ");

            // Add search conditions if a search term is provided
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                queryBuilder.append(" (")
                        .append("b.booking_id LIKE ? OR ")
                        .append("b.equipment_id LIKE ? OR ")
                        .append("b.status LIKE ? OR ")
                        .append("b.purpose_of_booking LIKE ? OR ")
                        .append("b.total_cost LIKE ? OR ")
                        .append("b.start_date LIKE ? OR ")
                        .append("b.end_date LIKE ? OR ")
                        .append("e.model LIKE ?")
                        .append(") ");
            } else {
                queryBuilder.append("1=1 "); // No filter, return all
            }

            queryBuilder.append("ORDER BY b.created_date DESC LIMIT ? OFFSET ?");

            // Prepare the statement
            try (PreparedStatement pstmt = conn.prepareStatement(queryBuilder.toString())) {
                int index = 1;

                // Set the search term parameters if provided
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    String searchPattern = "%" + searchTerm + "%";
                    pstmt.setString(index++, searchPattern); // booking_id
                    pstmt.setString(index++, searchPattern); // equipment_id
                    pstmt.setString(index++, searchPattern); // status
                    pstmt.setString(index++, searchPattern); // purpose_of_booking
                    pstmt.setString(index++, searchPattern); // total_cost
                    pstmt.setString(index++, searchPattern); // start_date
                    pstmt.setString(index++, searchPattern); // end_date
                    pstmt.setString(index++, searchPattern); // model
                }

                pstmt.setInt(index++, pageSize); // Number of records per page
                pstmt.setInt(index++, offset);   // The offset to skip for pagination

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
                    booking.setBillingStatus(rs.getBoolean("is_bill_paid"));
                    bookings.add(booking);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService getAllBookings: " + e.getMessage());
        }
        return bookings;
    }

    public List<Booking> getBookingsByUserId(Long userId, int pageNumber, int pageSize, String searchTerm) {
        List<Booking> bookings = new ArrayList<>();
        EquipmentService equipmentService = new EquipmentService(conn);
        try {
            int offset = (pageNumber - 1) * pageSize;

            // Constructing the search query
            StringBuilder queryBuilder = new StringBuilder("SELECT * FROM booking b left join equipments e on b.equipment_id = e.id WHERE b.user_id = ? ");

            // Add search conditions if a search term is provided
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                queryBuilder.append("AND (")
                        .append("b.booking_id LIKE ? OR ")
                        .append("b.equipment_id LIKE ? OR ")
                        .append("b.status LIKE ? OR ")
                        .append("b.purpose_of_booking LIKE ? OR ")
                        .append("b.total_cost LIKE ? OR ")
                        .append("b.start_date LIKE ? OR ")
                        .append("b.end_date LIKE ? OR ")
                        .append("e.model LIKE ?")
                        .append(") ");
            }

            queryBuilder.append("ORDER BY b.created_date DESC LIMIT ? OFFSET ?");

            // Prepare the statement
            try (PreparedStatement pstmt = conn.prepareStatement(queryBuilder.toString())) {
                int index = 1;
                pstmt.setLong(index++, userId);

                // Set the search term parameters if provided
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    String searchPattern = "%" + searchTerm + "%";
                    pstmt.setString(index++, searchPattern); // booking_id
                    pstmt.setString(index++, searchPattern); // equipment_id
                    pstmt.setString(index++, searchPattern); // status
                    pstmt.setString(index++, searchPattern); // purpose_of_booking
                    pstmt.setString(index++, searchPattern); // total_cost
                    pstmt.setString(index++, searchPattern); // start_date
                    pstmt.setString(index++, searchPattern); // end_date
                    pstmt.setString(index++, searchPattern); // model
                }

                pstmt.setInt(index++, pageSize); // Number of records per page
                pstmt.setInt(index++, offset);   // The offset to skip for pagination

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
                    booking.setBillingStatus(rs.getBoolean("is_bill_paid"));

                    bookings.add(booking);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService getBookingsByUserId: " + e.getMessage());
        }
        return bookings;
    }

    public int getTotalBookingsCount(String searchTerm) {
        int count = 0;
        try {
            StringBuilder queryBuilder = new StringBuilder("SELECT COUNT(*) FROM booking b left join equipments e on b.equipment_id = e.id WHERE ");

            // Add search conditions if a search term is provided
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                queryBuilder.append(" (")
                        .append("b.booking_id LIKE ? OR ")
                        .append("b.equipment_id LIKE ? OR ")
                        .append("b.status LIKE ? OR ")
                        .append("b.purpose_of_booking LIKE ? OR ")
                        .append("b.total_cost LIKE ? OR ")
                        .append("b.start_date LIKE ? OR ")
                        .append("b.end_date LIKE ? OR ")
                        .append("e.model LIKE ?")
                        .append(") ");
            } else {
                queryBuilder.append("1=1 "); // No filter, return all
            }

            try (PreparedStatement pstmt = conn.prepareStatement(queryBuilder.toString())) {
                int index = 1;

                // Set the search term parameters if provided
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    String searchPattern = "%" + searchTerm + "%";
                    pstmt.setString(index++, searchPattern); // booking_id
                    pstmt.setString(index++, searchPattern); // equipment_id
                    pstmt.setString(index++, searchPattern); // status
                    pstmt.setString(index++, searchPattern); // purpose_of_booking
                    pstmt.setString(index++, searchPattern); // total_cost
                    pstmt.setString(index++, searchPattern); // start_date
                    pstmt.setString(index++, searchPattern); // end_date
                    pstmt.setString(index++, searchPattern); // model
                }

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

    public int getTotalBookingsByUserIdCount(Long userId, String searchTerm) {
        int count = 0;
        try {
            StringBuilder queryBuilder = new StringBuilder("SELECT COUNT(*) FROM booking b left join equipments e on b.equipment_id = e.id WHERE b.user_id = ? ");

            // Add search conditions if a search term is provided
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                queryBuilder.append("AND (")
                        .append("b.booking_id LIKE ? OR ")
                        .append("b.equipment_id LIKE ? OR ")
                        .append("b.status LIKE ? OR ")
                        .append("b.purpose_of_booking LIKE ? OR ")
                        .append("b.total_cost LIKE ? OR ")
                        .append("b.start_date LIKE ? OR ")
                        .append("b.end_date LIKE ? OR ")
                        .append("e.model LIKE ?")
                        .append(") ");
            }

            try (PreparedStatement pstmt = conn.prepareStatement(queryBuilder.toString())) {
                int index = 1;
                pstmt.setLong(index++, userId);

                // Set the search term parameters if provided
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    String searchPattern = "%" + searchTerm + "%";
                    pstmt.setString(index++, searchPattern); // booking_id
                    pstmt.setString(index++, searchPattern); // equipment_id
                    pstmt.setString(index++, searchPattern); // status
                    pstmt.setString(index++, searchPattern); // purpose_of_booking
                    pstmt.setString(index++, searchPattern); // total_cost
                    pstmt.setString(index++, searchPattern); // start_date
                    pstmt.setString(index++, searchPattern); // end_date
                    pstmt.setString(index++, searchPattern); // model
                }

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


    public Boolean updateBookingStatus(Long bookingId) {
        boolean isBookingStatusUpdated = false;
        try {
            String query = "UPDATE booking SET approved = true WHERE booking_id = ?";
            int i;
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, bookingId);
                i = pstmt.executeUpdate();
                System.out.println("Booking status updated successfully");
            }
            if (i == 1) {
                isBookingStatusUpdated = true;
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService updateBookingStatus: " + e.getMessage());
        }
        return isBookingStatusUpdated;
    }

    public Booking getBookingById(Long bookingId) {
        Booking booking = null;
        EquipmentService equipmentService = new EquipmentService(conn);
        try {
            String query = "SELECT * FROM booking WHERE booking_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, bookingId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    booking = new Booking();
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
                    booking.setBillingStatus(rs.getBoolean("is_bill_paid"));
                }
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService getBookingById: " + e.getMessage());
        }
        return booking;
    }


    public boolean updateBookingStatusByBookingId(Long bookingId) {
        boolean isBookingStatusUpdated = false;
        try {
            String query = "UPDATE booking SET is_bill_paid = true WHERE booking_id = ?";
            int i;
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setLong(1, bookingId);
                    i = pstmt.executeUpdate();
                System.out.println("Booking status updated successfully");
            }
            if (i == 1) {
                isBookingStatusUpdated = true;
            }
        } catch (Exception e) {
            System.out.println("Error in BookingService updateBookingStatusByequipmentId: " + e.getMessage());
        }
        return isBookingStatusUpdated;
    }
}
