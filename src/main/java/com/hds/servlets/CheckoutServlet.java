package com.hds.servlets;

import com.hds.model.CartItem;
import com.hds.db.DBCOnnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve shipping and contact information from form parameters
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zip = request.getParameter("zip");
        
        // Retrieve user info from session (e.g., username)
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        if(username == null || username.trim().isEmpty()){
            response.sendRedirect("login.jsp?error=Please+log+in+to+checkout&returnUrl=checkout.jsp");
            return;
        }
        
        // Hard-coded customer ID for this demo (adjust as needed)
        int customerId = 455;
        
        // Retrieve the shopping cart from the session
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double subtotal = 0.0;
        if (cart != null) {
            for (CartItem item : cart) {
                subtotal += item.getPrice() * item.getQuantity();
            }
        }
        double taxRate = 0.06;
        double tax = subtotal * taxRate;
        double total = subtotal + tax;
        
        // Generate a unique sale_id (for simplicity, using current time mod some value)
        int saleId = (int)(System.currentTimeMillis() % 1000000);
        
        // Order processing: Insert each cart item as an order record
        Connection conn = DBCOnnection.getConnection();
        boolean orderSuccess = true;
        if (conn != null && cart != null && !cart.isEmpty()){
            String insertSQL = "INSERT INTO orders (sale_id, quantity, total_cost, sale_date, serial, customer_id) " +
                               "VALUES (?, ?, ?, CURDATE(), ?, ?)";
            try {
                for (CartItem item : cart){
                    double itemTotal = item.getPrice() * item.getQuantity();
                    // Instead of a hard-coded serial, we use the product ID converted to a string.
                    String productSerial = String.valueOf(item.getProductId());
                    
                    try (PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {
                        pstmt.setInt(1, saleId);
                        pstmt.setDouble(2, item.getQuantity());
                        pstmt.setDouble(3, itemTotal);
                        pstmt.setString(4, productSerial);
                        pstmt.setInt(5, customerId);
                        
                        int rows = pstmt.executeUpdate();
                        if (rows <= 0){
                            orderSuccess = false;
                            System.out.println("CheckoutServlet: No rows inserted for product ID " + item.getProductId());
                        }
                    }
                }
            } catch (SQLException ex){
                ex.printStackTrace();
                orderSuccess = false;
            } finally {
                try { 
                    conn.close(); 
                } catch (SQLException ex){ 
                    ex.printStackTrace();
                }
            }
        } else {
            orderSuccess = false;
            System.out.println("CheckoutServlet: Missing connection, cart, or cart items.");
        }
        
        // Optionally clear the cart
        session.removeAttribute("cart");
        
        // Set order details as request attributes for the confirmation page
        request.setAttribute("orderSuccess", orderSuccess);
        request.setAttribute("customerName", customerName);
        request.setAttribute("address", address);
        request.setAttribute("city", city);
        request.setAttribute("state", state);
        request.setAttribute("zip", zip);
        request.setAttribute("total", total);
        request.setAttribute("saleId", saleId);
        request.setAttribute("username", username);
        
        // Forward to orderConfirmation.jsp for display
        request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
