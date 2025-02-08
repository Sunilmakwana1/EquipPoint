package com.equip.point.controller;

import com.equip.point.Service.ContactUsService;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/api/contact-us-approved-status")
public class ContactUsApprovedStatus extends HttpServlet {

    private static final String CONTACT_US_APPROVED_STATUS_UPDATED = "contactUsApprovedStatusUpdated";
    private static final Object CONTACT_US_APPROVED_STATUS_UPDATED_MESSAGE = "Contact us approved status updated successfully";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            Long id = Long.parseLong(req.getParameter("id"));
            Long userId = Long.parseLong(req.getParameter("userId"));
            ContactUsService contactUsService = new ContactUsService(conn);
            Boolean updateContactUsApprovedStatus = contactUsService.approveContactUs(id, Boolean.TRUE , userId);
            if (Boolean.TRUE.equals(updateContactUsApprovedStatus)) {
                conn.commit();
                req.setAttribute(CONTACT_US_APPROVED_STATUS_UPDATED, CONTACT_US_APPROVED_STATUS_UPDATED_MESSAGE);
                req.getRequestDispatcher("/dashboard/messageInbox.jsp").forward(req, resp);
            } else {
                conn.rollback();
                System.out.println("Unable to update contact us approved status");
            }
        } catch (Exception e) {
            System.out.println("Error in ContactUsApprovedStatus doPut: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.out.println("Error in ContactUsApprovedStatus doPut: " + e.getMessage());
                }
            }
        }

    }
}
