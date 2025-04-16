package com.hds.servlets;

import com.hds.model.CartItem;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve form parameters
        String productIdStr = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String productPriceStr = request.getParameter("productPrice");
        String quantityStr = request.getParameter("quantity");
        
        // Check for missing values
        if (productIdStr == null || productIdStr.trim().isEmpty() ||
            productName == null || productName.trim().isEmpty() ||
            productPriceStr == null || productPriceStr.trim().isEmpty() ||
            quantityStr == null || quantityStr.trim().isEmpty()) {
            
            response.getWriter().println("<html><body><h1>Error: Missing product parameters.</h1></body></html>");
            return;
        }
        
        // Parse values; trim to remove any extra spaces.
        int productId = Integer.parseInt(productIdStr.trim());
        double productPrice = Double.parseDouble(productPriceStr.trim());
        int quantity = Integer.parseInt(quantityStr.trim());
        
        // Create a new CartItem (make sure your CartItem class has a constructor that matches these parameters)
        CartItem item = new CartItem(productId, productName, productPrice, quantity);
        
        // Retrieve the shopping cart from the session; create a new one if it doesn't exist.
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        
        // Optionally, check if the product already exists in the cart to update the quantity.
        // Here, for simplicity, we're just adding the item.
        cart.add(item);
        
        // Store the updated cart back in the session.
        session.setAttribute("cart", cart);
        
        // Instead of redirecting to products.jsp, redirect back to the referring page.
        String referer = request.getHeader("referer");
        if (referer == null || referer.trim().isEmpty()) {
            referer = "products.jsp"; // Fallback in case referer is not available.
        }
        response.sendRedirect(referer);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

