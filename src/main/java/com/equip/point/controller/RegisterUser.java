package com.equip.point.controller;

import com.equip.point.Service.RegisterService;
import com.equip.point.Service.SecurityQuestionsService;
import com.equip.point.Service.UserService;
import com.equip.point.model.SecurityQuestions;
import com.equip.point.model.User;
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
import java.util.Objects;

import static com.equip.point.util.AppConstant.*;

@WebServlet(value = "/api/register")
public class RegisterUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false); // Start a transaction

            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String phone = req.getParameter("phone");
            String securityQuestion = req.getParameter("securityQuestion");
            String securityAnswer = req.getParameter("securityAnswer");
            UserService userService = new UserService(conn);
            if (EquipPointUtil.isTrueNotNull(userService.checkIsEmailAvailable(email)) && EquipPointUtil.isTrueNotNull(userService.checkIsPhoneNumberAvailable(phone))) {
                User user = new User(fullName, email, password,  phone);
                RegisterService registerService = new RegisterService(conn);
                Boolean registerUser = registerService.registerUser(user);
                SecurityQuestionsService securityQuestionsService = new SecurityQuestionsService(conn);
                SecurityQuestions securityQuestions = new SecurityQuestions(securityQuestion);
                Boolean saveSecutityQuestionsAnswer = securityQuestionsService.saveSecutityQuestionsAnswer(securityAnswer, email, securityQuestions);
                if (Boolean.TRUE.equals(registerUser) && Boolean.TRUE.equals(saveSecutityQuestionsAnswer)) {
                    conn.commit();
                    req.setAttribute(REGISTER_SUCCESS, REGISTER_SUCCESS_MESSAGE);
                    req.getRequestDispatcher("/login/login.jsp").forward(req, resp);
                } else {
                    conn.rollback();
                    // Handle the registration failure
                }
            } else {
                conn.rollback();
                if (!EquipPointUtil.isTrueNotNull(userService.checkIsPhoneNumberAvailable(phone)) && !EquipPointUtil.isTrueNotNull(userService.checkIsEmailAvailable(email))) {
                    req.setAttribute(DUPLICATE_PHONE, DUPLICATE_PHONE_MESSAGE);
                    req.setAttribute(DUPLICATE_EMAIL, DUPLICATE_EMAIL_MESSAGE);
                }
                else if (!EquipPointUtil.isTrueNotNull(userService.checkIsPhoneNumberAvailable(phone))) {
                    req.setAttribute(DUPLICATE_PHONE, DUPLICATE_PHONE_MESSAGE);
                } else if (!EquipPointUtil.isTrueNotNull(userService.checkIsEmailAvailable(email))) {
                    req.setAttribute(DUPLICATE_EMAIL, DUPLICATE_EMAIL_MESSAGE);
                }
                req.getRequestDispatcher("/users/signUp.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            if (Objects.nonNull(conn)) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (Objects.nonNull(conn)) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }
}