package com.hds.servlets;

import com.hds.model.Order;
import com.hds.db.DBCOnnection;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if the user is logged in by verifying the username is stored in session.
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        if (username == null || username.trim().isEmpty()){
            response.sendRedirect("login.jsp?error=Please+log+in+to+view+order+history");
            return;
        }
        
        // For this demo, we use a constant customer ID.
        // In your full application, retrieve the logged-in user's customer ID.
        int customerId = 455;
        
        List<Order> orders = new ArrayList<>();
        
        // Use try-with-resources to automatically close resources.
        try (Connection conn = DBCOnnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                "SELECT sale_id, quantity, total_cost, sale_date, serial, customer_id " +
                "FROM orders WHERE customer_id = ? ORDER BY sale_date DESC"
             )) {
             
            pstmt.setInt(1, customerId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()){
                    int saleId = rs.getInt("sale_id");
                    double quantity = rs.getDouble("quantity");
                    double totalCost = rs.getDouble("total_cost");
                    Date saleDate = rs.getDate("sale_date");
                    String serial = rs.getString("serial");
                    int custId = rs.getInt("customer_id");
                    
                    // Create an Order object (ensure your Order class has this constructor)
                    Order order = new Order(saleId, quantity, totalCost, saleDate, serial, custId);
                    orders.add(order);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error retrieving order history.");
        }
        
        // Debug: log the number of orders retrieved.
        System.out.println("OrderHistoryServlet: Retrieved " + orders.size() + " orders for customer " + customerId);
        
        // Set the orders list as a request attribute and forward to orderHistory.jsp.
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
