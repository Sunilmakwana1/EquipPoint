package com.equip.point.Service;

import com.equip.point.model.Booking;

import java.math.BigDecimal;
import java.sql.Connection;

public class BillPaymetService {

    private Connection conn;

    public BillPaymetService(Connection conn) {
        super();
        this.conn = conn;
    }

    public boolean billPayment(Long equipmentId, BigDecimal paymentAmount , Long bookingId) {
        boolean isPaid = false;
        try {
            String sql = "INSERT INTO bill_payment (equipment_id, bill_date ,booking_id) VALUES (?,now(),?)";
            var preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setLong(1, equipmentId);
            preparedStatement.setLong(2, bookingId);
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected == 1) {
                BookingService bookingService = new BookingService(conn);
                Long billPaymentId = getBillPaymentId(equipmentId);
                PaymentService paymentService = new PaymentService(conn);
                boolean processPayment = paymentService.processPayment(billPaymentId, paymentAmount);
                if (processPayment) {
                    bookingService.updateBookingStatusByBookingId(bookingId);
                }
                isPaid = true;
            }
            preparedStatement.close();
        } catch (Exception e) {
                e.printStackTrace();
        }
        return isPaid;
    }


    public Long getBillPaymentId(Long equipmentId) {
        Long billPaymentId = null;
        try {
            String sql = "SELECT bill_id FROM bill_payment WHERE equipment_id = ? order by bill_date desc limit 1";
            var preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setLong(1, equipmentId);
            var resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                billPaymentId = resultSet.getLong("bill_id");
            }
            resultSet.close();
            preparedStatement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return billPaymentId;
    }



}
