package com.equip.point.controller;

import com.equip.point.Service.BookingService;
import com.equip.point.Service.EmailLogService;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/api/booking-status")
public class BookingStatusController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            BookingService bookingService = new BookingService(conn);
            Long bookingId = Long.parseLong(req.getParameter("id"));
            if (Boolean.TRUE.equals(bookingService.updateBookingStatus(bookingId))) {
                conn.commit();
                String subject = "Booking Approved";
                String body = "Dear " + bookingService.getUserEmailByBookingId(bookingId) + ",\n\nYour booking has been successfully approved.\n\nThank you for using our service.\n\nBest regards,\nThe Team";
                String recipientEmail = bookingService.getUserEmailByBookingId(bookingId);
                String status = "Success";
                EmailLogService emailLogService = new EmailLogService(conn);
                emailLogService.saveEmailLog(recipientEmail, subject, body, status, null);
                req.setAttribute("status", "Booking Approved");
                req.getRequestDispatcher("/booking/viewBooking.jsp").forward(req, resp);
            } else {
                conn.rollback();
                req.setAttribute("status", "Unable to update booking status");
                req.getRequestDispatcher("/booking/viewBooking.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            System.out.println("Error in BookingStatusController: " + e.getMessage());
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception rollbackException) {
                System.out.println("Error during rollback: " + rollbackException.getMessage());
            }
            req.setAttribute("status", "An error occurred while updating booking status");
            req.getRequestDispatcher("/booking/viewBooking.jsp").forward(req, resp);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception closeException) {
                    System.out.println("Error closing connection: " + closeException.getMessage());
                }
            }

        }

    }

}
