package com.hds.db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBCOnnection {

    // Update with your actual database name, username, and password.
	private static final String URL = "jdbc:mysql://host.docker.internal:3306/hds_database";
	private static final String USER = "root";
	private static final String PASSWORD = "Monster2@";
  

    public static Connection getConnection() {
        try {
            // Load the MySQL JDBC driver (for older Java versions, required; for newer, it's optional)
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Connect to your database
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database connection successful!");
            return conn;
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
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
        if(con != null) {
            System.out.println("Connection test passed!");
        } else {
            System.out.println("Connection test failed.");
        }
    }
}
