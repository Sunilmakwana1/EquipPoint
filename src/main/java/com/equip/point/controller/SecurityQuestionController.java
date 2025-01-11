package com.equip.point.controller;

import com.equip.point.Service.SecurityQuestionsService;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/api/security-questions")
public class SecurityQuestionController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            SecurityQuestionsService securityQuestionsService = new SecurityQuestionsService(conn);
            List<String> securityQuestions = securityQuestionsService.getSecurityQuestions();
            String json = new Gson().toJson(securityQuestions);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch security questions");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}