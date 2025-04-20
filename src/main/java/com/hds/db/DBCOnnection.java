package com.hds.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBCOnnection {

    // Replace with the PostgreSQL connection URL provided by Render
    private static final String URL = "jdbc:postgresql://dpg-d00i93c9c44c73fn053g-a/hds_main_database";
    private static final String USER = "hds_main_database_user";
    private static final String PASSWORD = "MDOpEbGNqP5uERqaEBZlbZgrNW9gM6TU";
    
    public static Connection getConnection() {
        try {
            // Load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");
            
            // Connect to the PostgreSQL database
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database connection successful!");
            return conn;
        } catch (ClassNotFoundException e) {
            System.out.println("PostgreSQL JDBC Driver not found.");
            e.printStackTrace();
            return null;
        } catch (SQLException e) {
            System.out.println("Failed to connect to the database. Check your URL, username, and password.");
            e.printStackTrace();
            return null;
        }
    }

    // Main method for testing the connection
    public static void main(String[] args) {
        Connection con = getConnection();
        if (con != null) {
            System.out.println("Connection test passed!");
        } else {
            System.out.println("Connection test failed.");
        }
    }
}

