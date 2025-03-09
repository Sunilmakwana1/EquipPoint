package com.equip.point.controller;

import com.equip.point.Service.EmailLogService;
import com.equip.point.Service.VendorService;
import com.equip.point.model.Categories;
import com.equip.point.util.CurrentLoginUser;
import com.equip.point.util.DbConnection;
import com.equip.point.util.EquipPointUtil;
import com.equip.point.util.Type;
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

@WebServlet("/api/add-equipment-categories")
@MultipartConfig
public class AddEquipmentCategories extends HttpServlet {

    /**
     * Handles the HTTP POST request to add a new vendor.
     *
     * @param req  The HttpServletRequest object that contains the request the client made to the servlet.
     * @param resp The HttpServletResponse object that contains the response the servlet returns to the client.
     * @throws ServletException If the request could not be handled.
     * @throws IOException      If an input or output error is detected when the servlet handles the request.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part filePart = req.getPart(VENDOR_IMAGE);
        String fileName = filePart.getSubmittedFileName();
        System.out.println(FILE_NAME + fileName);
        String uploadPath = UPLOAD_PATH + fileName;
        System.out.println(UPLOAD_PATH_MESSAGE + uploadPath);

        EquipPointUtil.uploadFile(uploadPath, filePart);

        Connection conn = null;
        EmailLogService emailLogService = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            String categoryName = req.getParameter(VENDOR_NAME);
            String description = req.getParameter(DESCRIPTION);
            VendorService vendorService = new VendorService(conn);
            emailLogService = new EmailLogService(conn);
            if (Boolean.TRUE.equals(vendorService.checkVendorExist(categoryName)) && !EquipPointUtil.isEmpty(categoryName) && !EquipPointUtil.isEmpty(description)) {
                Categories vendor = new Categories(categoryName, description, fileName, Type.EQUIPMENT);
                EquipPointUtil.setCurrentUserInSession(conn);
                Boolean addVendor = vendorService.addVendor(vendor);
                if (Boolean.TRUE.equals(addVendor)) {
                    conn.commit();
                    req.setAttribute(EQUIPMENT_ADDED_SUCCESSFULLY, EQUIPMENT_ADDED_SUCCESSFULLY_MESSAGE);
                    // Save the email log
                    emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), EQUIPMENT_ADDED, EQUIPMENT_ADDED_SUCCESSFULLY_MESSAGE, SENT, null);
                    req.getRequestDispatcher("/catagory/addEquipmentCategories.jsp").forward(req, resp);
                } else {
                    conn.rollback();
                }
            } else {
                conn.rollback();
                req.setAttribute(DUPLICATE_VENDOR, DUPLICATE_EQUIPMENT_MESSAGE);
                //Save the email log
                emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), EQUIPMENT_NOT_ADDED, EQUIPMENT_NOT_ADDED, SENT, DUPLICATE_VENDOR_MESSAGE);
                req.getRequestDispatcher("/catagory/addEquipmentCategories.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            System.out.println(ERROR_IN_ADDED_EQUIPMENT_CONTROLLER + e.getMessage());
            if (EquipPointUtil.isNotNull(emailLogService)) {
                // Save the email log with error message
                emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), EQUIPMENT_NOT_ADDED, EQUIPMENT_NOT_ADDED, SENT, e.getMessage());
            }
        }
    }
}
