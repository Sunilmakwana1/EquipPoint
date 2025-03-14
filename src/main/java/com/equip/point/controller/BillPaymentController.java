package com.equip.point.controller;

import com.equip.point.Service.BillPaymetService;
import com.equip.point.Service.EmailLogService;
import com.equip.point.util.CurrentLoginUser;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;

@WebServlet("/api/bill-payment")
public class BillPaymentController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = DbConnection.getConnection();
            Long equipmentId = Long.parseLong(req.getParameter("equipmentId"));
            BigDecimal paymentAmount = new BigDecimal(req.getParameter("paymentAmount"));
            Long bookingId = Long.parseLong(req.getParameter("bookingId"));
            BillPaymetService billPaymentService = new BillPaymetService(connection);
            boolean isPaid = billPaymentService.billPayment(equipmentId, paymentAmount, bookingId);
            if (isPaid) {
                    req.setAttribute("message", "Bill payment successful Booking ID: " + "#" + bookingId);
                req.getRequestDispatcher("/dashboard/dasboard.jsp").forward(req, resp);
                EmailLogService emailLogService = new EmailLogService(connection);
                String subject = "Bill Payment Confirmation";
                String body = "Dear " + CurrentLoginUser.getCurrentLoginUser() + ",\n\nYour bill payment for Booking ID: " + bookingId + " has been successfully processed.\n\nThank you for using our service.\n\nBest regards,\nThe Team";
                String recipientEmail = CurrentLoginUser.getCurrentLoginUser();
                String status = "Success";
                emailLogService.saveEmailLog(recipientEmail, subject, body, status , null );
                resp.getWriter().write("Bill payment successful.");
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("Bill payment failed.");
            }
        } catch (Exception e) {
            System.out.println("Error in BillPaymentController: " + e.getMessage());

        }

    }
}
