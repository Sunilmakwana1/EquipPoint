package com.equip.point.controller;

import com.equip.point.Service.BookingService;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
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
            String bookingDate = req.getParameter("bookingDate");
            String userEmail = req.getParameter("userEmail");
            String userPhone = req.getParameter("userPhone");


            conn.commit();
            req.setAttribute("bookingSuccess", "Booking was successful!");
            req.getRequestDispatcher("/booking/success.jsp").forward(req, resp);
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
