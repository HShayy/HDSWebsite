package com.hds.servlets;

import com.hds.db.DBCOnnection;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/InventoryServlet")
public class InventoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get a connection using DBCOnnection from the com.hds.db package
        Connection conn = DBCOnnection.getConnection();
        if (conn == null) {
            // Instead of writing output directly, forward to an error page or set an error attribute.
            request.setAttribute("error", "Failed to connect to the database.");
            request.getRequestDispatcher("inventory.jsp").forward(request, response);
            return;
        }

        // Create a list to hold each row of inventory data
        List<Map<String, String>> inventory = new ArrayList<>();

        try {
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM inventory";  // Adjust if your table name differs
            ResultSet rs = stmt.executeQuery(sql);
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();

            // Loop through each row in the result set
            while (rs.next()) {
                // Use LinkedHashMap to preserve column order
                Map<String, String> row = new LinkedHashMap<>();
                for (int i = 1; i <= columnCount; i++) {
                    String colName = rsmd.getColumnName(i);
                    String value = rs.getString(i);
                    row.put(colName, value);
                }
                inventory.add(row);
            }
            // Log the number of rows retrieved for debugging purposes.
            System.out.println("Inventory rows retrieved: " + inventory.size());
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving data from the database.");
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        // Set the inventory list as a request attribute and forward to inventory.jsp
        request.setAttribute("inventory", inventory);
        request.getRequestDispatcher("inventory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}