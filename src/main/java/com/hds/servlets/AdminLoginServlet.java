package com.hds.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    // Hard-coded credentials for demonstration purposes.
    private static final String VALID_ADMIN_USERNAME = "admin";
    private static final String VALID_ADMIN_PASSWORD = "admin123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve admin credentials from the form
        String adminUsername = request.getParameter("adminUsername");
        String adminPassword = request.getParameter("adminPassword");

        // Simple check: if credentials match, log in; otherwise, redirect back with an error.
        if (VALID_ADMIN_USERNAME.equals(adminUsername) && VALID_ADMIN_PASSWORD.equals(adminPassword)) {
            HttpSession session = request.getSession();
            // Mark this session as admin
            session.setAttribute("admin", adminUsername);
            // Redirect to the admin dashboard
            response.sendRedirect("adminDashboard.jsp");
        } else {
            // If the credentials do not match, redirect back to adminLogin.jsp with an error message.
            response.sendRedirect("adminLogin.jsp?error=Invalid+admin+credentials");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For simplicity, call doPost if accessed via GET.
        doPost(request, response);
    }
}
