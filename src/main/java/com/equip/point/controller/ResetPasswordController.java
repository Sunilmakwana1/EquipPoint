package com.equip.point.controller;

import com.equip.point.Service.UserService;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/api/reset-password-user")
public class ResetPasswordController extends HttpServlet {



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = DbConnection.getConnection();
            String email = req.getParameter("email");
            String newPassword = req.getParameter("password");
            String confirmPassword = req.getParameter("confirmPassword");

            if (newPassword.equals(confirmPassword)) {
                // Assuming UserService has a method to reset password
                UserService userService = new UserService(connection);
                boolean isResetSuccessful = userService.resetPassword(email, newPassword);

                if (isResetSuccessful) {
                    req.setAttribute("resetSuccess", "Password reset successfully. Please login with your new password.");
                    req.getRequestDispatcher("/login/login.jsp").forward(req, resp);
                } else {
                    req.setAttribute("forgetPasswordError", "Failed to reset password. Please try again.");
                    req.getRequestDispatcher("/login/resetPassword.jsp").forward(req, resp);
                }
            } else {
                req.setAttribute("forgetPasswordError", "Passwords do not match.");
                req.getRequestDispatcher("/login/resetPassword.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }
}
