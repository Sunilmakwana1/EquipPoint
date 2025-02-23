package com.equip.point.controller;

import com.equip.point.Service.ContactUsService;
import com.equip.point.Service.EmailLogService;
import com.equip.point.util.CurrentLoginUser;
import com.equip.point.util.DbConnection;
import com.equip.point.util.EquipPointUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import static com.equip.point.util.AppConstant.*;

@WebServlet("/api/contact-us-approved-status")
public class ContactUsApprovedStatus extends HttpServlet {

    private static final String CONTACT_US_APPROVED_STATUS_UPDATED = "contactUsApprovedStatusUpdated";
    private static final Object CONTACT_US_APPROVED_STATUS_UPDATED_MESSAGE = "Contact us approved status updated successfully";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        EmailLogService emailLogService = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            Long id = Long.parseLong(req.getParameter("id"));
            Long userId = Long.parseLong(req.getParameter("userId"));
            ContactUsService contactUsService = new ContactUsService(conn);
            emailLogService = new EmailLogService(conn);
            Boolean updateContactUsApprovedStatus = contactUsService.approveContactUs(id, Boolean.TRUE , userId);
            if (Boolean.TRUE.equals(updateContactUsApprovedStatus)) {
                conn.commit();
                req.setAttribute(CONTACT_US_APPROVED_STATUS_UPDATED, CONTACT_US_APPROVED_STATUS_UPDATED_MESSAGE);
                emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), CONTACT_US_APPROVED, CONTACT_US_APPROVED_MESSAGE, SENT, null);
                req.getRequestDispatcher("/dashboard/messageInbox.jsp").forward(req, resp);
            } else {
                conn.rollback();
                System.out.println("Unable to update contact us approved status");
                emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), CONTACT_US_APPROVED, CONTACT_US_APPROVED_MESSAGE, SENT, "Unable to update contact us approved status");
            }
        } catch (Exception e) {
            System.out.println("Error in ContactUsApprovedStatus doPut: " + e.getMessage());
            if (emailLogService != null) {
                emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), CONTACT_US_APPROVED, CONTACT_US_APPROVED_MESSAGE, SENT, e.getMessage());
            }
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.out.println("Error in ContactUsApprovedStatus doPut: " + e.getMessage());
                    if (EquipPointUtil.isNotNull(emailLogService)) {
                        emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), CONTACT_US_APPROVED, CONTACT_US_APPROVED_MESSAGE, SENT, e.getMessage());
                    }
                }
            }
        }

    }
}
