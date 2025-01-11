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
import java.sql.SQLException;

import static com.equip.point.util.AppConstant.USER_DELETED_SUCCESSFULLY;
import static com.equip.point.util.AppConstant.USER_DELETED_SUCCESSFULLY_MESSAGE;

@WebServlet("/api/user-deleted")
public class UserDeletedController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            Long id = Long.parseLong(req.getParameter("id"));
            UserService userService = new UserService(conn);
            Boolean deleteUser = userService.deleteUser(id);
            if (Boolean.TRUE.equals(deleteUser)) {
                conn.commit();
                req.setAttribute(USER_DELETED_SUCCESSFULLY, USER_DELETED_SUCCESSFULLY_MESSAGE);
                req.getRequestDispatcher("/users/viewUsers.jsp").forward(req, resp);
            } else {
                conn.rollback();
                System.out.println("Unable to delete user");
            }
        } catch (Exception e) {
            System.out.println("Error in UserDeletedController doPut: " + e.getMessage());
        } finally {
            if (EquipPointUtil.isNotNull(conn)) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.out.println("Error in UserDeletedController doPut: " + e.getMessage());
                }
            }
        }
    }
}
