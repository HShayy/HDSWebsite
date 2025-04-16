package com.hds.servlets;

import com.hds.db.DBCOnnection;  // Adjust the package if needed
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/OrdersServlet")
public class OrdersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set content type for HTML output
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // Get a connection using the DBCOnnection class
        Connection conn = DBCOnnection.getConnection();
        if (conn == null) {
            out.println("<html><body><h1>Failed to connect to the database.</h1></body></html>");
            return;
        }
        
        try {
            // Create a statement and execute a query to get all data from the orders table
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM orders";  // Adjust this query if your table name is different
            ResultSet rs = stmt.executeQuery(sql);
            
            // Get metadata to determine the number of columns
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            
            // Build the HTML output
            out.println("<html><head><title>Orders List</title></head><body>");
            out.println("<h1>Orders List</h1>");
            out.println("<table border='1' cellpadding='5' cellspacing='0'>");
            
            // Generate table header row with column names
            out.println("<tr>");
            for (int i = 1; i <= columnCount; i++) {
                out.println("<th>" + rsmd.getColumnName(i) + "</th>");
            }
            out.println("</tr>");
            
            // Generate table rows for each order in the result set
            while(rs.next()){
                out.println("<tr>");
                for (int i = 1; i <= columnCount; i++) {
                    out.println("<td>" + rs.getString(i) + "</td>");
                }
                out.println("</tr>");
            }
            out.println("</table>");
            out.println("</body></html>");
            
            // Close resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<html><body><h1>Error retrieving data from the database.</h1></body></html>");
        } finally {
            out.close();
        }
    }
}

