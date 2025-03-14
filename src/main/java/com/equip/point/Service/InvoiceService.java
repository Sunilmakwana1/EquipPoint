package com.equip.point.Service;

import com.equip.point.model.Invoice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class InvoiceService {

    Connection connection;

    public InvoiceService(Connection connection) {
        this.connection = connection;
    }

    public Long getInVoiceIdByBookingId(Long bookingId) {
        Long invoiceId = null;
        String sql = "SELECT payment_id FROM payment WHERE bill_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setLong(1, bookingId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                invoiceId = resultSet.getLong("payment_id");
            }
        } catch (SQLException e) {
            System.out.println("Error in InvoiceService getInVoiceIdByBookingId: " + e.getMessage());
        }
        return invoiceId;
    }

    public Invoice getInvoiceByBookingId(Long bookingId) {
        Invoice invoice = null;
        String sql = "SELECT * FROM payment WHERE bill_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setLong(1, bookingId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                Long paymentId = resultSet.getLong("payment_id");
                Long billId = resultSet.getLong("bill_id");
                String paymentDate = String.valueOf(resultSet.getDate("payment_date"));
                String paymentAmount = resultSet.getString("payment_amount");
                invoice = new Invoice(paymentId, billId, paymentDate, paymentAmount);
            }
        } catch (Exception e) {
            System.out.println("Error in InvoiceService getInvoiceByBookingId: " + e.getMessage());
        }
        return invoice;
    }
}
