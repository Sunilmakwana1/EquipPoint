package com.equip.point.controller;


import java.io.*;
import java.util.List;

import com.equip.point.Service.BookingService;
import com.equip.point.model.Booking;
import com.equip.point.util.DbConnection;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@jakarta.servlet.annotation.WebServlet("/api/booking-chart")
public class BookingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get all bookings (assumes a BookingService is available)
        BookingService bookingService = new BookingService(DbConnection.getConnection());
        List<Booking> bookings = bookingService.getAllBookings();

        // Extract data for the chart (e.g., number of bookings per month)
        int[] monthlyBookings = new int[12];
        for (Booking booking : bookings) {
            String bookingMonth = booking.getBookingDate().substring(5, 7); // Extract month (MM) from booking date
            int month = Integer.parseInt(bookingMonth) - 1; // Adjust to 0-indexed month
            monthlyBookings[month]++;
        }

        // Convert the data into JSON
        Gson gson = new Gson();
        String jsonData = gson.toJson(monthlyBookings);

        // Set the response type and send the JSON data
        response.setContentType("application/json");
        response.getWriter().write(jsonData);
    }
}
