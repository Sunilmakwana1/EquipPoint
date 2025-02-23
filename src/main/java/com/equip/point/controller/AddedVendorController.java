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

@WebServlet("/api/vendor-added")
@MultipartConfig
public class AddedVendorController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part filePart = req.getPart("vendorImage");
        String fileName = filePart.getSubmittedFileName();
        System.out.println("File name: " + fileName);
        String uploadPath = UPLOAD_PATH + fileName;
        System.out.println("Upload path: " + uploadPath);

        EquipPointUtil.uploadFile(uploadPath, filePart);

        Connection conn = null;
        EmailLogService emailLogService = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            String categoryName = req.getParameter("vendorName");
            String description = req.getParameter("description");
            VendorService vendorService = new VendorService(conn);
            emailLogService = new EmailLogService(conn);
            if (Boolean.TRUE.equals(vendorService.checkVendorExist(categoryName))) {
                Categories vendor = new Categories(categoryName, description, fileName, Type.VENDOR);
                Boolean addVendor = vendorService.addVendor(vendor);
                if (Boolean.TRUE.equals(addVendor)) {
                    conn.commit();
                    req.setAttribute(VENDOR_ADDED_SUCCESSFULLY, VENDOR_ADDED_SUCCESSFULLY_MESSAGE);
                    emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), "Vendor Added", "Vendor Added Successfully", "sent", null);
                    req.getRequestDispatcher("/catagory/addVendor.jsp").forward(req, resp);
                } else {
                    conn.rollback();
                }
            } else {
                conn.rollback();
                req.setAttribute(DUPLICATE_VENDOR, DUPLICATE_VENDOR_MESSAGE);
                emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), "Vendor Added", "Vendor Added Successfully", "sent", DUPLICATE_VENDOR_MESSAGE);
                req.getRequestDispatcher("/catagory/addVendor.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            System.out.println("Error in AddedVendorController doPost: " + e.getMessage());
            if (EquipPointUtil.isNotNull(emailLogService)) {
                emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), "Vendor Added", "Vendor Added Successfully", "sent", e.getMessage());
            }
        }
    }
}
