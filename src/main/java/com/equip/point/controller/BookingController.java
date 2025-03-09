package com.equip.point.controller;

import com.equip.point.Service.BookingService;
import com.equip.point.Service.EquipmentService;
import com.equip.point.Service.UserService;
import com.equip.point.model.Booking;
import com.equip.point.util.CurrentLoginUser;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.xml.crypto.Data;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;

@WebServlet("/api/booking")
public class BookingController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            BookingService bookingService = new BookingService(conn);
            String equipmentName = req.getParameter("equipmentName");
            String startDate = req.getParameter("date");
            Long duration = Long.valueOf(req.getParameter("duration"));
            BigDecimal rentalRate = new BigDecimal(req.getParameter("rentalRate"));
            String purpose = req.getParameter("purpose");
            BigDecimal totalCost = new BigDecimal(req.getParameter("totalCost"));
            EquipmentService equipmentService = new EquipmentService(conn);
            Long equipmentId = equipmentService.getEquipmentIdByName(equipmentName);
            Long userId = CurrentLoginUser.getCurrentLoginUserId();
            Booking booking = new Booking(equipmentId,  duration, startDate, rentalRate, purpose, totalCost,userId);
            Boolean booked = bookingService.bookEquipment(booking);
            if (Boolean.FALSE.equals(booked)) {
                conn.rollback();
                req.setAttribute("bookingError", "Unable to book equipment. Please try again.");
                req.getRequestDispatcher("../404.jsp").forward(req, resp);
            }else {
                Long bookingIdByUserId = bookingService.getBookingIdByUserId(userId);
                conn.commit();
                req.setAttribute("bookingSuccess", "#" + bookingIdByUserId);
                req.getRequestDispatcher("/booking/bookingSuccess.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (Exception rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            req.setAttribute("bookingError", "An error occurred while processing your booking.");
            req.getRequestDispatcher("/booking/error.jsp").forward(req, resp);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception closeEx) {
                    closeEx.printStackTrace();
                }
            }
        }
    }
}
