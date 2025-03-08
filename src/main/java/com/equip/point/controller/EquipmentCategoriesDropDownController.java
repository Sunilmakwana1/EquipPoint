package com.equip.point.controller;

import com.equip.point.Service.EquipmentCategoriesService;
import com.equip.point.model.Categories;
import com.equip.point.util.DbConnection;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/api/equipment-categories-dropdown")
public class EquipmentCategoriesDropDownController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        String vendor = req.getParameter("vendor");
        try {
            conn = DbConnection.getConnection();
            EquipmentCategoriesService equipmentCategoriesService = new EquipmentCategoriesService(conn);
            if (vendor != null && vendor.equals("true")) {
                List<String> categoriesList = equipmentCategoriesService.getListOfEquipmentCategoriesByCategoriesType("VENDOR");
                String json = new Gson().toJson(categoriesList);
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write(json);
            }else {
                List<String> categoriesList = equipmentCategoriesService.getListOfEquipmentCategoriesByCategoriesType("EQUIPMENT");
                String json = new Gson().toJson(categoriesList);
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write(json);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch equipment categories");
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
