package com.equip.point.controller;

import java.io.IOException;
import java.util.Objects;

import com.equip.point.Service.UserService;
import com.equip.point.model.User;
import com.equip.point.util.DbConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/forget-password")
public class ForgetPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        try {
            HttpSession session = req.getSession();
            UserService userService = new UserService(DbConnection.getConnection());
            User userEmail = userService.forgetPassword(email);
            if (Objects.nonNull(userEmail)) {
               System.out.println("Forget password successful for user with ID: " + userEmail.getId());
               System.out.println("User name : " + userEmail.getFullName());
               String forgetPassword = "Forget Password Successful. Please Contact Admin For Password Reset";
               req.setAttribute("forgetPasswordSuccess", forgetPassword);
                req.getRequestDispatcher("/login/forgetPassword.jsp").forward(req, resp);
            } else {
                System.out.println("Forget password failed for email: " + email);
                String forgetPasswordError = "Forget Password Failed. Please try again";
                req.setAttribute("forgetPasswordError", forgetPasswordError);
                req.getRequestDispatcher("/login/forgetPassword.jsp").forward(req, resp);
                               
            }
        } catch (Exception e) {
            System.out.println("Error in ForgetPassword doPost: " + e.getMessage());
        }
    }

     @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }
}