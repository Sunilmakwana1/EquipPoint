package com.equip.point.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static com.equip.point.util.AppConstant.*;

@WebServlet("/api/logout")
public class Logout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        session.removeAttribute(LOGGED_IN_USER);
        req.setAttribute(LOGOUT_ERROR, LOGOUT_MESSAGE);
        req.getRequestDispatcher("/login/login.jsp").forward(req, resp);



    }
}
