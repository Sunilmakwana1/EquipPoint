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
import static com.equip.point.util.URLConstant.API_CONTACT_US_APPROVED_STATUS;
import static com.equip.point.util.URLConstant.DASHBOARD_MESSAGE_INBOX_JSP;

@WebServlet(API_CONTACT_US_APPROVED_STATUS)
public class ContactUsApprovedStatus extends HttpServlet {

    /**
     * Handles the HTTP GET request to approve a contact us message.
     *
     * @param req  The HttpServletRequest object that contains the request the client made to the servlet.
     * @param resp The HttpServletResponse object that contains the response the servlet returns to the client.
     * @throws ServletException If the request could not be handled.
     * @throws IOException      If an input or output error is detected when the servlet handles the request.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        EmailLogService emailLogService = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            Long id = Long.parseLong(req.getParameter(ID));
            Long userId = Long.parseLong(req.getParameter(USER_ID));
            ContactUsService contactUsService = new ContactUsService(conn);
            emailLogService = new EmailLogService(conn);
            Boolean updateContactUsApprovedStatus = contactUsService.approveContactUs(id, Boolean.TRUE , userId);
            if (Boolean.TRUE.equals(updateContactUsApprovedStatus)) {
                conn.commit();
                req.setAttribute(CONTACT_US_APPROVED_STATUS_UPDATED, CONTACT_US_APPROVED_STATUS_UPDATED_MESSAGE);
                // Save the email log
                emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), CONTACT_US_APPROVED, CONTACT_US_APPROVED_MESSAGE, SENT, null);
                req.getRequestDispatcher(DASHBOARD_MESSAGE_INBOX_JSP).forward(req, resp);
            } else {
                conn.rollback();
                System.out.println(UNABLE_TO_UPDATE_CONTACT_US_APPROVED_STATUS);
                //Save the email log
                emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), CONTACT_US_APPROVED, CONTACT_US_APPROVED_MESSAGE, SENT, UNABLE_TO_UPDATE_CONTACT_US_APPROVED_STATUS);
            }
        } catch (Exception e) {
            System.out.println(ERROR_IN_CONTACT_US_APPROVED_STATUS + e.getMessage());
            if (emailLogService != null) {
                // Save the email log
                emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), CONTACT_US_APPROVED, CONTACT_US_APPROVED_MESSAGE, SENT, e.getMessage());
            }
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.out.println(ERROR_IN_CONTACT_US_APPROVED_STATUS + e.getMessage());
                    if (EquipPointUtil.isNotNull(emailLogService)) {
                        // Save the email log
                        emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), CONTACT_US_APPROVED, CONTACT_US_APPROVED_MESSAGE, SENT, e.getMessage());
                    }
                }
            }
        }

    }
}
