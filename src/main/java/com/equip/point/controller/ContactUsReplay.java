package com.equip.point.controller;

import com.equip.point.Service.ContactUsService;
import com.equip.point.Service.EmailLogService;
import com.equip.point.util.CurrentLoginUser;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/api/contact-us-reply")
public class ContactUsReplay extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = DbConnection.getConnection();
        Long contactUsId = Long.parseLong(req.getParameter("id"));
        String replyMessage = req.getParameter("replyMessage");
        ContactUsService contactUsService = new ContactUsService(connection);

        try {
            Boolean replyContactUs = contactUsService.replyContactUs(contactUsId, replyMessage, CurrentLoginUser.getCurrentLoginUserId(), true);
            if (replyContactUs) {
                // Send email to user
                String subject = "Reply from Equip Point";
                String email = contactUsService.getContactUsById(contactUsId).getEmail();
                EmailLogService emailLogService = new EmailLogService(connection);
                emailLogService.saveEmailLog(email, subject, replyMessage , "Success", null);
                req.getRequestDispatcher("/dashboard/dasboard.jsp" ).forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/contact-us.jsp?error=Failed to send reply");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/contact-us.jsp?error=Failed to send reply");
        }
    }
}
