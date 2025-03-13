package com.equip.point.controller;

import com.equip.point.Service.BillPaymetService;
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
            BillPaymetService billPaymentService = new BillPaymetService(connection);
            boolean isPaid = billPaymentService.billPayment(equipmentId, paymentAmount);
            if (isPaid) {
                resp.setStatus(HttpServletResponse.SC_OK);
                req.getRequestDispatcher("/booking/viewBooking.jsp").forward(req, resp);
                resp.getWriter().write("Bill payment successful.");
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("Bill payment failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("An error occurred: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

    }
}
