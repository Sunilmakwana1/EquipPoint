package com.equip.point.controller;

import com.equip.point.Service.VendorService;
import com.equip.point.model.Categories;
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

@WebServlet("/api/vendor-edit")
@MultipartConfig
public class EditVendorController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            Long id = Long.parseLong(req.getParameter("id"));
            String vendorName = req.getParameter("vendorName");
            String description = req.getParameter("description");
            Part filePart = req.getPart("vendorImage");
            String vendorImage = filePart.getSubmittedFileName();
            if (EquipPointUtil.isNotNullOrEmptyString(vendorImage)) {
                System.out.println("File name: " + vendorImage);
                String uploadPath = UPLOAD_PATH + vendorImage;
                System.out.println("Upload path: " + uploadPath);
                EquipPointUtil.uploadFile(uploadPath, filePart);
            }
            String image;
            VendorService vendorService = new VendorService(conn);
            Boolean checkVendorExistExceptCurrentVendorId = vendorService.checkVendorExistExceptCurrentVendorId(vendorName, id);
            Categories vendorById = vendorService.getVendorById(id);
            if (EquipPointUtil.isNotNullOrEmptyString(vendorImage)) {
                image = vendorImage;
            } else {
                image = vendorById.getImage();
            }
            if (Boolean.TRUE.equals(checkVendorExistExceptCurrentVendorId)) {
                Categories vendor = new Categories(id, vendorName, description, image);
                Boolean editVendor = vendorService.updateVendor(vendor);
                if (Boolean.TRUE.equals(editVendor)) {
                    conn.commit();
                    req.setAttribute(VENDOR_EDITED_SUCCESSFULLY, VENDOR_EDITED_SUCCESSFULLY_MESSAGE);
                    req.getRequestDispatcher("/catagory/viewVendor.jsp").forward(req, resp);
                } else {
                    conn.rollback();
                    System.out.println("Unable to edit vendor");
                }
            } else {
                conn.rollback();
                req.setAttribute(DUPLICATE_VENDOR, DUPLICATE_VENDOR_MESSAGE);
                req.getRequestDispatcher("/catagory/editVendor.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            System.out.println("Error in EditVendorController doPost: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    System.out.println("Error in EditVendorController doPost: " + e.getMessage());
                }
            }
        }
    }
}
