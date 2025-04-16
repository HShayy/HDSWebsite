package com.hds.servlets;

import com.hds.model.CartItem;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve the productId from the request parameter and trim any extra whitespace
        String productIdStr = request.getParameter("productId");
        if (productIdStr != null && !productIdStr.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdStr.trim());
                
                // Get the current session and retrieve the cart
                HttpSession session = request.getSession();
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                
                // If a cart exists, remove the item matching the productId
                if (cart != null) {
                    Iterator<CartItem> iterator = cart.iterator();
                    while (iterator.hasNext()) {
                        CartItem item = iterator.next();
                        if (item.getProductId() == productId) {
                            iterator.remove();
                            break;  // Remove the first matching item
                        }
                    }
                    session.setAttribute("cart", cart);  // Update the cart in the session
                }
            } catch (NumberFormatException e) {
                // If the productId cannot be parsed, you might want to log the error
                e.printStackTrace();
            }
        }
        
        // Redirect back to the cart page
        response.sendRedirect("cart.jsp");
    }
    
    // Optional: Allow GET requests to behave like POST (for testing purposes)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

