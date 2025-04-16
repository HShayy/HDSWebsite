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

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve parameters from the request
        String productIdStr = request.getParameter("productId");
        String newQuantityStr = request.getParameter("newQuantity");

        if (productIdStr != null && newQuantityStr != null) {
            try {
                int productId = Integer.parseInt(productIdStr.trim());
                int newQuantity = Integer.parseInt(newQuantityStr.trim());

                // Retrieve the cart from the session
                HttpSession session = request.getSession();
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

                if (cart != null) {
                    // Use an iterator for safe removal
                    Iterator<CartItem> iterator = cart.iterator();
                    while (iterator.hasNext()) {
                        CartItem item = iterator.next();
                        if (item.getProductId() == productId) {
                            if (newQuantity <= 0) {
                                // If quantity is zero or less, remove the item from cart
                                iterator.remove();
                            } else {
                                // Otherwise, update the quantity
                                item.setQuantity(newQuantity);
                            }
                            break;
                        }
                    }
                    // Save the updated cart back into the session
                    session.setAttribute("cart", cart);
                }
            } catch (NumberFormatException e) {
                // Optionally log the error or send an error message back
                e.printStackTrace();
            }
        }
        // Redirect back to the cart page
        response.sendRedirect("cart.jsp");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

