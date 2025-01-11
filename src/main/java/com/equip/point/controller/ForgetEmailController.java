package com.equip.point.controller;

import com.equip.point.Service.UserService;
import com.equip.point.util.DbConnection;
import com.equip.point.util.EquipPointUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

import static com.equip.point.util.AppConstant.*;

@WebServlet("/api/forget-email")
public class ForgetEmailController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            String phone = req.getParameter("phoneNumber");
            UserService userService = new UserService(conn);
            String email = userService.getEmailByPhone(phone);
            if (!EquipPointUtil.isNullOrEmpty(email)) {
                req.setAttribute(FORGET_EMAIL, email);
                req.getRequestDispatcher("/login/forgetEmail.jsp").forward(req, resp);
            } else {
                System.out.println("Forget email failed for phone: " + phone);
                req.setAttribute(PHONE_NUMBER_NOT_FOUND, PHONE_NUMBER_NOT_FOUND_MESSAGE);
                req.getRequestDispatcher("/login/forgetEmail.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            System.out.println("Error in ForgetEmailController doPost: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }
}
