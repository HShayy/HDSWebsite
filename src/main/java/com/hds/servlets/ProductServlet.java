package com.hds.servlets;

import com.hds.db.DBCOnnection;
import com.hds.model.Product;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Create a list to store Product objects
        List<Product> products = new ArrayList<>();

        // Get a database connection from DBCOnnection
        Connection conn = DBCOnnection.getConnection();
        if (conn == null) {
            request.setAttribute("error", "Database connection failed.");
            request.getRequestDispatcher("products.jsp").forward(request, response);
            return;
        }
        
        /* 
         * Mapping the columns from the inventory table:
         *   `serial#` as product_id
         *   description as product_name
         *   cost as price (the cost string may include a $ sign and commas, so we convert them)
         *   image_url as image_url
         */
        String sql = "SELECT `serial#` as product_id, description as product_name, cost as price, image_url as image_url FROM inventory";
        
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            // Loop through each row in the result set
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                String productName = rs.getString("product_name");
                
                // Retrieve the cost as a string and remove any '$' signs and commas
                String priceStr = rs.getString("price");
                double price = 0.0;
                if (priceStr != null) {
                    priceStr = priceStr.replace("$", "").replace(",", "").trim();
                    try {
                        price = Double.parseDouble(priceStr);
                    } catch (NumberFormatException ex) {
                        ex.printStackTrace();
                    }
                }
                
                // Get the image URL; if it's null or empty, use a placeholder image.
                String imageUrl = rs.getString("image_url");
                if (imageUrl == null || imageUrl.trim().isEmpty()) {
                    imageUrl = "https://via.placeholder.com/150";
                }
                
                // Debug: Log each product's details
                System.out.println("Retrieved Product - ID: " + productId 
                                   + ", Name: " + productName
                                   + ", Price: " + price
                                   + ", Image URL: " + imageUrl);

                // Create a new Product object and add it to the list
                Product product = new Product(productId, productName, price, imageUrl);
                products.add(product);
            }
            System.out.println("ProductServlet: Retrieved " + products.size() + " products.");
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        
        // Set the list of products as a request attribute and forward to products.jsp
        request.setAttribute("products", products);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

