package com.equip.point.controller;

import com.equip.point.Service.EquipmentService;
import com.equip.point.model.Equipments;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/api/update-equipment")
public class UpdateEquipmentController  extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);
            String modelName = req.getParameter("modelName");
            String categoryName = req.getParameter("category");
            String available = req.getParameter("available");
            String price = req.getParameter("price");
            int manufacturing = Integer.parseInt(req.getParameter("manufacturing"));
            double weight = Double.parseDouble(req.getParameter("Weight"));
            double power = Double.parseDouble(req.getParameter("Power"));
            String fuel = req.getParameter("Fuel");
            String description = req.getParameter("Description");
            Equipments equipments = new Equipments();
            equipments.setModel(modelName);
            equipments.setEquipmentsCategories(categoryName);
            equipments.setAvailabilityStatus(available);
            equipments.setRentalRate(Double.parseDouble(price));
            equipments.setManufacturingYear(manufacturing);
            equipments.setOperatingWeight(weight);
            equipments.setEnginePower(power);
            equipments.setFuelType(fuel);
            equipments.setDescription(description);
            equipments.setId(Long.parseLong(req.getParameter("id")));
            EquipmentService equipmentsService = new EquipmentService(conn);
            Boolean updateEquipment = equipmentsService.updateEquipment(equipments);
            if (Boolean.TRUE.equals(updateEquipment)) {
                conn.commit();
                req.setAttribute("updateSuccess", "Equipment updated successfully");
                req.getRequestDispatcher("/catagory/viewEquipment.jsp").forward(req, resp);
            } else {
                conn.rollback();
                req.setAttribute("updateError", "Unable to update equipment");
                req.getRequestDispatcher("/catagory/viewEquipment.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (Exception rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            req.setAttribute("updateError", "An error occurred while updating equipment.");
            req.getRequestDispatcher("/catagory/viewEquipment.jsp").forward(req, resp);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception closeEx) {
                    closeEx.printStackTrace();
                }
            }

        }
    }
}
