package com.buyMe15.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/buy_me_website";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "bro9090Code#165";

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            throw new RuntimeException("Failed to load MySQL JDBC driver.", e);
        }

        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                // Log or handle the exception
            }
        }
    }

    public static void main(String[] args) {
        ApplicationDB dao = new ApplicationDB();
        try (Connection connection = dao.getConnection()) {
            System.out.println("Connected successfully.");
        } catch (SQLException e) {
            System.err.println("Failed to connect to the database: " + e.getMessage());
        }
    }
}
