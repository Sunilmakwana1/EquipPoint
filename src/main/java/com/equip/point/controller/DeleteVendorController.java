package com.equip.point.controller;

import com.equip.point.Service.VendorService;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import static com.equip.point.util.AppConstant.VENDOR_DELETED_SUCCESSFULLY;
import static com.equip.point.util.AppConstant.VENDOR_DELETED_SUCCESSFULLY_MESSAGE;

@WebServlet("/api/delete-vendor")
public class DeleteVendorController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            Long id = Long.parseLong(req.getParameter("id"));
            VendorService vendorService = new VendorService(conn);
            Boolean deleteVendor = vendorService.deleteVendor(id);
            if (Boolean.TRUE.equals(deleteVendor)) {
                conn.commit();
                req.setAttribute(VENDOR_DELETED_SUCCESSFULLY, VENDOR_DELETED_SUCCESSFULLY_MESSAGE);
                req.getRequestDispatcher("/catagory/viewVendor.jsp").forward(req, resp);
            } else {
                conn.rollback();
                System.out.println("Unable to delete vendor");
            }
        } catch (Exception e) {
            System.out.println("Error in DeleteVendorController doPut: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.out.println("Error in DeleteVendorController doPut: " + e.getMessage());
                }
            }
        }
    }
}
