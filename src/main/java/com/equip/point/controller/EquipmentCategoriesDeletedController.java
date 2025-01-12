package com.equip.point.controller;

import com.equip.point.Service.EquipmentCategoriesService;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import static com.equip.point.util.AppConstant.CATEGORY_DELETED_SUCCESSFULLY;
import static com.equip.point.util.AppConstant.CATEGORY_DELETED_SUCCESSFULLY_MESSAGE;

@WebServlet("/api/equipment-categories-deleted")
public class EquipmentCategoriesDeletedController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //delete equipment category
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            Long id = Long.parseLong(req.getParameter("id"));
            EquipmentCategoriesService equipmentCategoriesService = new EquipmentCategoriesService(conn);
            Boolean deleteEquipmentCategory = equipmentCategoriesService.deleteEquipmentCategory(id);
            if (Boolean.TRUE.equals(deleteEquipmentCategory)) {
                conn.commit();
                req.setAttribute(CATEGORY_DELETED_SUCCESSFULLY, CATEGORY_DELETED_SUCCESSFULLY_MESSAGE);
                req.getRequestDispatcher("/catagory/viewCategories.jsp").forward(req, resp);
            } else {
                conn.rollback();
                System.out.println("Unable to delete equipment category");
            }
        } catch (Exception e) {
            System.out.println("Error in EquipmentCategoriesDeletedController doPut: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.out.println("Error in EquipmentCategoriesDeletedController doPut: " + e.getMessage());
                }
            }
        }
    }
}
