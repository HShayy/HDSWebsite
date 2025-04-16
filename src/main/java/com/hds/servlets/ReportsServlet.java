package com.hds.servlets;

import com.hds.db.DBCOnnection;
import com.hds.model.Job;
import com.hds.model.SaleRecord;
import com.hds.model.Employee;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ReportsServlet")
public class ReportsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lists to hold dynamic data
        List<Job> pendingJobs = new ArrayList<>();
        List<Job> currentJobs = new ArrayList<>();
        List<SaleRecord> saleRecords = new ArrayList<>();
        List<Employee> employeeData = new ArrayList<>();
        
        // Get a connection using your DBCOnnection class
        Connection conn = DBCOnnection.getConnection();
        if (conn == null) {
            request.setAttribute("error", "Unable to connect to the database.");
            request.getRequestDispatcher("reports.jsp").forward(request, response);
            return;
        }
        
        try {
            // Query for Pending Jobs (using correct column names: job_id, job_name, description)
            String sqlPending = "SELECT job_id, job_name, description FROM pending_jobs";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sqlPending)) {
                while (rs.next()) {
                    int jobId = rs.getInt("job_id");
                    String jobName = rs.getString("job_name");
                    String description = rs.getString("description");
                    pendingJobs.add(new Job(jobId, jobName, description));
                }
            }
            
            // Query for Current Jobs
            String sqlCurrent = "SELECT job_id, job_name, description FROM current_jobs";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sqlCurrent)) {
                while (rs.next()) {
                    int jobId = rs.getInt("job_id");
                    String jobName = rs.getString("job_name");
                    String description = rs.getString("description");
                    currentJobs.add(new Job(jobId, jobName, description));
                }
            }
            
            // Query for Sales Records - use total_cost column instead of sale_amount
            String sqlSales = "SELECT sale_id, total_cost, sale_date FROM sales_records";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sqlSales)) {
                while (rs.next()) {
                    int saleId = rs.getInt("sale_id");
                    // Convert total_cost (a VARCHAR) to a double.
                    double saleAmount = Double.parseDouble(rs.getString("total_cost").trim());
                    Date saleDate = rs.getDate("sale_date");
                    saleRecords.add(new SaleRecord(saleId, saleAmount, saleDate));
                }
            }
            
            // Query for Employee Data
            String sqlEmployee = "SELECT employee_id, first_name, last_name FROM employee_data";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sqlEmployee)) {
                while (rs.next()) {
                    int employeeId = rs.getInt("employee_id");
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    employeeData.add(new Employee(employeeId, firstName, lastName));
                }
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
        } finally {
            try { 
                conn.close(); 
            } catch (SQLException ex) { 
                ex.printStackTrace();
            }
        }
        
        // Set the data as request attributes for the JSP
        request.setAttribute("pendingJobs", pendingJobs);
        request.setAttribute("currentJobs", currentJobs);
        request.setAttribute("saleRecords", saleRecords);
        request.setAttribute("employeeData", employeeData);
        
        // Forward the request to reports.jsp
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
