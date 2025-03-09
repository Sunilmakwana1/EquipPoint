package com.equip.point.Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class HistoryService {

    private Connection connection;

    public HistoryService(Connection connection) {
        this.connection = connection;
    }

    public boolean addHistory(String tableName, long recordId, String action, String oldData, String newData, String status, String performedBy) {
        boolean isHistoryAdded = false;
        try {
            int i;
            String query = "INSERT INTO history (table_name, record_id, action, old_data, new_data, status, performed_by) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try(PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, tableName);
                preparedStatement.setLong(2, recordId);
                preparedStatement.setString(3, action);
                preparedStatement.setString(4, oldData);
                preparedStatement.setString(5, newData);
                preparedStatement.setString(6, status);
                preparedStatement.setString(7, performedBy);
                i = preparedStatement.executeUpdate();
            }
            if (i == 1) {
                isHistoryAdded = true;
            }
        } catch (SQLException e) {

        }
        return isHistoryAdded;
    }
}
