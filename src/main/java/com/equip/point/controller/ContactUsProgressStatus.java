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

@WebServlet("/api/contact-us-progress-status")
public class ContactUsProgressStatus extends HttpServlet {

    private static final String CONTACT_US_PROGRESS_STATUS_UPDATED = "contactUsProgressStatusUpdated";
    private static final Object CONTACT_US_PROGRESS_STATUS_UPDATED_MESSAGE = "Contact us progress status updated successfully";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            Long id = Long.parseLong(req.getParameter("id"));
            ContactUsService contactUsService = new ContactUsService(conn);
            Boolean updateContactUsProgressStatus = contactUsService.progressContactUs(id, Boolean.TRUE);
            if (Boolean.TRUE.equals(updateContactUsProgressStatus)) {
                conn.commit();
                req.setAttribute(CONTACT_US_PROGRESS_STATUS_UPDATED, CONTACT_US_PROGRESS_STATUS_UPDATED_MESSAGE);
                req.getRequestDispatcher("/dashboard/messageInbox.jsp").forward(req, resp);
            } else {
                conn.rollback();
                System.out.println("Unable to update contact us progress status");
            }
        } catch (Exception e) {
            System.out.println("Error in ContactUsProgressStatus doPut: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.out.println("Error in ContactUsProgressStatus doPut: " + e.getMessage());
                }
            }
        }

    }
}
