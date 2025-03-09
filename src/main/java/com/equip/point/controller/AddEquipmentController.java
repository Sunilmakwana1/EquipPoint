package com.equip.point.controller;

import com.equip.point.Service.EquipmentCategoriesService;
import com.equip.point.Service.EquipmentService;
import com.equip.point.Service.VendorService;
import com.equip.point.model.Categories;
import com.equip.point.model.Equipments;
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

import static com.equip.point.util.AppConstant.*;
import static com.equip.point.util.AppConstant.UPLOAD_PATH_MESSAGE;

@WebServlet("/api/add-equipment")
@MultipartConfig
public class AddEquipmentController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        Part filePart = req.getPart(VENDOR_IMAGE);
        String fileName = filePart.getSubmittedFileName();
        System.out.println(FILE_NAME + fileName);
        String uploadPath = UPLOAD_PATH + fileName;
        System.out.println(UPLOAD_PATH_MESSAGE + uploadPath);

        EquipPointUtil.uploadFile(uploadPath, filePart);
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            String modelName = req.getParameter("modelName");
            String description = req.getParameter(DESCRIPTION);
            String categoryName = req.getParameter("CategoriesSelect");
            String vendorName = req.getParameter("vendorSelect");
            EquipmentService equipmentService = new EquipmentService(conn);
            if (Boolean.TRUE.equals(equipmentService.checkEquipmentExist(modelName)) && !EquipPointUtil.isEmpty(modelName) && !EquipPointUtil.isEmpty(description)) {
                EquipPointUtil.setCurrentUserInSession(conn);
                EquipmentCategoriesService equipmentCategoriesService = new EquipmentCategoriesService(conn);
                VendorService vendorService = new VendorService(conn);
                Categories vendorByName = vendorService.getVendorByName(vendorName);
                Long equipmentCategoryIdByName = equipmentCategoriesService.getEquipmentCategoryIdByName(categoryName);
                Equipments equipments = new Equipments(modelName, description, fileName ,equipmentCategoryIdByName ,vendorByName.getId());
                Boolean addEquipment = equipmentService.addEquipment(equipments);
                if (Boolean.TRUE.equals(addEquipment)) {
                    conn.commit();
                    req.setAttribute(EQUIPMENT_ADDED_SUCCESSFULLY, EQUIPMENT_ADDED_SUCCESSFULLY_MESSAGE);
                    req.getRequestDispatcher("/catagory/addEquipment.jsp").forward(req, resp);
                } else {
                    conn.rollback();
                    System.out.println("Unable to add equipment");
                }
            } else {
                conn.rollback();
                req.setAttribute(DUPLICATE_EQUIPMENT, DUPLICATE_EQUIPMENT_CATEGORY_MESSAGE);
                req.getRequestDispatcher("/catagory/addEquipment.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
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
