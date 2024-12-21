package com.equip.point.util;

import java.sql.Connection;

public class DbConnection {

    private static Connection conn;


    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = java.sql.DriverManager.getConnection(DbConstant.URL, DbConstant.USERNAME, DbConstant.PASSWORD);
            System.out.printf("Connection Established");
        } catch (Exception e) {
            System.out.printf("Connection Failed" + e.getMessage());
        }
        return conn;
    }
}
