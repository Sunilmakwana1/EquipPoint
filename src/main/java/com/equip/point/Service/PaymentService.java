package com.equip.point.Service;

import java.math.BigDecimal;
import java.sql.Connection;

public class PaymentService {

    Connection conn;

    public PaymentService(Connection conn) {
        super();
        this.conn = conn;
    }

     public boolean processPayment(Long bookingId, BigDecimal paymentAmount) {
         boolean isPaid = false;
         try {
             String sql = "INSERT INTO payment (bill_id, payment_date,payment_amount ) VALUES (?,now(),?)";
             var preparedStatement = conn.prepareStatement(sql);
             preparedStatement.setLong(1, bookingId);
             preparedStatement.setBigDecimal(2, paymentAmount);

             int rowsAffected = preparedStatement.executeUpdate();
             if (rowsAffected == 1) {
                 isPaid = true;
             }
             preparedStatement.close();
         } catch (Exception e) {
             e.printStackTrace();
         }
         return isPaid;
     }
}
