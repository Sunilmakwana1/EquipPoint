package com.equip.point.Service;

import com.equip.point.model.EmailLog;
import com.equip.point.util.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class EmailLogService {

    private Connection conn = DbConnection.getConnection();

    public EmailLogService(Connection conn) {
        super();
        this.conn = conn;
    }

    public void saveEmailLog(String recipientEmail, String subject, String message, String status, String errorMessage) {
        try {
            String query = "INSERT INTO email_log (recipient_email, subject, message, status, error_message) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, recipientEmail);
                ps.setString(2, subject);
                ps.setString(3, message);
                ps.setString(4, status);
                ps.setString(5, errorMessage);
                ps.executeUpdate();
                conn.commit(); // Ensure the changes are saved
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService saveEmailLog: " + e.getMessage());
        }
    }



    public void updateEmailLogStatus(int id, String status, String errorMessage) {
        try {
            String query = "UPDATE email_log SET status=?, error_message=? WHERE id=?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, status);
                ps.setString(2, errorMessage);
                ps.setInt(3, id);
                ps.executeUpdate();
                conn.commit(); // Ensure the changes are saved
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService updateEmailLogStatus: " + e.getMessage());
        }
    }

    public void deleteEmailLog(int id) {
        try {
            String query = "DELETE FROM email_log WHERE id=?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setInt(1, id);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService deleteEmailLog: " + e.getMessage());
        }
    }

    public void deleteAllEmailLogs() {
        try {
            String query = "DELETE FROM email_log";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService deleteAllEmailLogs: " + e.getMessage());
        }
    }

    public void deleteAllEmailLogsByStatus(String status) {
        try {
            String query = "DELETE FROM email_log WHERE status=?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, status);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService deleteAllEmailLogsByStatus: " + e.getMessage());
        }
    }

    public void deleteAllEmailLogsByStatusAndErrorMessage(String status, String errorMessage) {
        try {
            String query = "DELETE FROM email_log WHERE status=? AND error_message=?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, status);
                ps.setString(2, errorMessage);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService deleteAllEmailLogsByStatusAndErrorMessage: " + e.getMessage());
        }
    }

    public void deleteAllEmailLogsByStatusOrErrorMessage(String status, String errorMessage) {
        try {
            String query = "DELETE FROM email_log WHERE status=? OR error_message=?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, status);
                ps.setString(2, errorMessage);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService deleteAllEmailLogsByStatusOrErrorMessage: " + e.getMessage());
        }
    }

    public void deleteAllEmailLogsByStatusAndErrorMessageOrRecipientEmail(String status, String errorMessage, String recipientEmail) {
        try {
            String query = "DELETE FROM email_log WHERE status=? AND error_message=? OR recipient_email=?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, status);
                ps.setString(2, errorMessage);
                ps.setString(3, recipientEmail);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService deleteAllEmailLogsByStatusAndErrorMessageOrRecipientEmail: " + e.getMessage());
        }
    }

    public void deleteAllEmailLogsByStatusOrErrorMessageAndRecipientEmail(String status, String errorMessage, String recipientEmail) {
        try {
            String query = "DELETE FROM email_log WHERE status=? OR error_message=? AND recipient_email=?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, status);
                ps.setString(2, errorMessage);
                ps.setString(3, recipientEmail);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService deleteAllEmailLogsByStatusOrErrorMessageAndRecipientEmail: " + e.getMessage());
        }
    }

    public List<EmailLog> getAllEmailLogs() {
        List<EmailLog> emailLogs = null;
        EmailLog emailLog = null;
        try {
            String query = "SELECT * FROM email_log";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    emailLog = new EmailLog();
                    emailLog.setId(rs.getInt("id"));
                    emailLog.setRecipientEmail(rs.getString("recipient_email"));
                    emailLog.setSubject(rs.getString("subject"));
                    emailLog.setMessage(rs.getString("message"));
                    emailLog.setStatus(rs.getString("status"));
                    emailLog.setErrorMessage(rs.getString("error_message"));
                    emailLog.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    emailLogs.add(emailLog);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService getAllEmailLogs: " + e.getMessage());
        }
        return emailLogs;
    }

    public EmailLog getEmailLogByRecipientEmail(String recipientEmail) {
        EmailLog emailLog = null;
        try {
            String query = "SELECT * FROM email_log WHERE recipient_email=?";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, recipientEmail);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    emailLog = new EmailLog();
                    emailLog.setId(rs.getInt("id"));
                    emailLog.setRecipientEmail(rs.getString("recipient_email"));
                    emailLog.setSubject(rs.getString("subject"));
                    emailLog.setMessage(rs.getString("message"));
                    emailLog.setStatus(rs.getString("status"));
                    emailLog.setErrorMessage(rs.getString("error_message"));
                    emailLog.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                }
            }
        } catch (Exception e) {
            System.out.println("Error in EmailLogService getEmailLogByRecipientEmail: " + e.getMessage());
        }
        return emailLog;
    }


}
