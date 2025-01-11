package com.equip.point.controller;

import com.equip.point.Service.EquipmentCategoriesService;
import com.equip.point.model.EquipmentCategories;
import com.equip.point.util.DbConnection;
import com.equip.point.util.EquipPointUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import static com.equip.point.util.AppConstant.*;

@WebServlet("/api/equipment-categories")
@MultipartConfig
public class EquipmentCategoriesController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Part filePart = req.getPart("categoryImage");
        String fileName = filePart.getSubmittedFileName();
        System.out.println("File name: " + fileName);
        String uploadPath = UPLOAD_PATH + fileName;
        System.out.println("Upload path: " + uploadPath);

        EquipPointUtil.uploadFile(uploadPath,filePart);

        Connection conn = null;
        try{
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            String categoryName = req.getParameter("categoryName");
            String description = req.getParameter("description");
            String categoryImage = fileName;

            EquipmentCategoriesService equipmentCategoriesService = new EquipmentCategoriesService(conn);
            if (Boolean.TRUE.equals(equipmentCategoriesService.checkEquipmentExist(categoryName))){
                EquipmentCategories equipmentCategories = new EquipmentCategories(categoryName, description, categoryImage);
                Boolean addEquipmentCategories = equipmentCategoriesService.addEquipmentCategories(equipmentCategories);
                if (Boolean.TRUE.equals(addEquipmentCategories)){
                    conn.commit();
                    req.setAttribute(CATEGORY_ADDED_SUCCESSFULLY, CATEGORY_ADDED_SUCCESSFULLY_MESSAGE);
                    req.getRequestDispatcher("/catagory/addEquipmentCategories.jsp").forward(req, resp);
                } else {
                    conn.rollback();
                    // Handle the registration failure
                }
            } else {
                conn.rollback();
                req.setAttribute(DUPLICATE_CATEGORY, DUPLICATE_CATEGORY_MESSAGE);
                req.getRequestDispatcher("/catagory/addEquipmentCategories.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                System.out.println("Error in EquipmentCategoriesController doPost: " + ex.getMessage());
            }
            System.out.println("Error in EquipmentCategoriesController doPost: " + e.getMessage());
        }
}

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }
}
