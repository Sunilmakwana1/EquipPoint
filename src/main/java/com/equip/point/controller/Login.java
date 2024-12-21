package com.equip.point.controller;

import com.equip.point.Service.LoginService;
import com.equip.point.model.User;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Objects;

@WebServlet("/api/auth")
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get the email and password from the request
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        //manage session after login
        try {
            HttpSession session = req.getSession();
            LoginService loginService = new LoginService(DbConnection.getConnection());
            User user = loginService.loginUser(email, password);
            if (Objects.nonNull(user)) {
                System.out.printf("Login successful for user with ID: %d%n", user.getId()); // NOSONAR
                System.out.printf("User name : %s%n", user.getFullName()); // NOSONAR
                session.setAttribute("loggedInUser", user); // NOSONAR
                resp.sendRedirect("/users/navbar.jsp");
            } else {
                System.out.printf("Login failed for email: %s%n", email);
                // Set the message as an attribute in the request
                String loginError = "Username and Password Incorrect";
                req.setAttribute("loginError", loginError);
                // Forward the request to the JSP
                req.getRequestDispatcher("/login/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            System.out.println("Error in Login doPost: " + e.getMessage());
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }
}
