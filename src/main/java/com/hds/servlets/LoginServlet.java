package com.hds.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String VALID_USERNAME = "user";
    private static final String VALID_PASSWORD = "password";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve username, password, and returnUrl from the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String returnUrl = request.getParameter("returnUrl");

        if (VALID_USERNAME.equals(username) && VALID_PASSWORD.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            // Redirect to the returnUrl if provided, otherwise to the home page
            if (returnUrl != null && !returnUrl.trim().isEmpty()) {
                response.sendRedirect(returnUrl);
            } else {
                response.sendRedirect("index.html");
            }
        } else {
            // Login failed; preserve returnUrl if present
            if(returnUrl == null || returnUrl.trim().isEmpty()){
                returnUrl = "index.html";
            }
            response.sendRedirect("login.jsp?error=Invalid+credentials&returnUrl=" + returnUrl);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
