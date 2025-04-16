<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" import="java.util.List, com.hds.model.Job, com.hds.model.SaleRecord, com.hds.model.Employee" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Reports - Home Design Solutions</title>
  <style>
    /* Reset defaults */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      font-family: Arial, sans-serif;
      background-color: #fff;
      padding: 20px;
      text-align: center;
    }
    /* Header & Navigation */
    header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background-color: #f2f2f2;
      padding: 10px 20px;
      border-bottom: 2px solid #000;
      margin-bottom: 20px;
    }
    header .logo {
      font-size: 24px;
      font-weight: bold;
    }
    nav ul {
      list-style: none;
      display: flex;
      gap: 15px;
    }
    nav ul li a {
      text-decoration: none;
      color: #000;
      font-weight: bold;
    }
    h1 {
      font-size: 28px;
      margin-bottom: 30px;
    }
    /* Row for report boxes */
    .reports-row {
      display: flex;
      justify-content: center;
      gap: 20px;
      flex-wrap: wrap;
      margin-bottom: 40px;
    }
    .report-box {
      border: 2px solid #000;
      padding: 10px;
      width: 250px;
      text-align: center;
      background-color: #fafafa;
      cursor: pointer;
    }
    .report-box img {
      width: 100%;
      height: auto;
      border-bottom: 2px solid #000;
      margin-bottom: 10px;
    }
    .report-box h2 {
      font-size: 18px;
      margin-bottom: 5px;
    }
    .report-box p {
      font-size: 14px;
      margin-bottom: 10px;
    }
    .report-box button {
      background-color: #fff;
      border: 2px solid #000;
      padding: 5px 10px;
      font-weight: bold;
      cursor: pointer;
    }
    /* Hidden detail sections */
    .details-section {
      max-width: 600px;
      margin: 20px auto;
      text-align: left;
      border: 1px solid #ccc;
      padding: 10px;
      display: none; /* hidden by default */
    }
    .details-section h2 {
      margin-bottom: 10px;
    }
    .details-section p {
      margin: 5px 0;
      font-size: 14px;
    }
    /* Footer */
    footer {
      text-align: center;
      background-color: #f2f2f2;
      padding: 10px;
      border-top: 2px solid #000;
      margin-top: 20px;
    }
  </style>
  <script>
    function showDetails(sectionId) {
      // Hide all sections first
      document.getElementById('currentDetails').style.display = 'none';
      document.getElementById('pendingDetails').style.display = 'none';
      document.getElementById('salesDetails').style.display = 'none';
      document.getElementById('employeeDetails').style.display = 'none';
      
      // Then display the selected section
      document.getElementById(sectionId).style.display = 'block';
    }
  </script>
</head>
<body>
  <!-- Header -->
  <header>
    <div class="logo">Home Design Solutions</div>
    <nav>
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="products.jsp">Products</a></li>
        <li><a href="contact.html">Contact</a></li>
        <li><a href="cart.jsp">Cart</a></li>
        <li><a href="login.jsp">Sign in</a></li>
      </ul>
    </nav>
  </header>

  <h1>REPORTS</h1>
  
  <!-- Top Row: Four Report Boxes -->
  <div class="reports-row">
    <!-- Current Jobs Box -->
    <div class="report-box" onclick="showDetails('currentDetails')">
      <img src="https://via.placeholder.com/250x150?text=Current+Jobs" alt="Current Jobs">
      <h2>Current Jobs</h2>
      <p>Active job tasks</p>
      <button>View</button>
    </div>
    <!-- Pending Jobs Box -->
    <div class="report-box" onclick="showDetails('pendingDetails')">
      <img src="https://via.placeholder.com/250x150?text=Pending+Jobs" alt="Pending Jobs">
      <h2>Pending Jobs</h2>
      <p>Pending job tasks</p>
      <button>View</button>
    </div>
    <!-- Sales Record Box -->
    <div class="report-box" onclick="showDetails('salesDetails')">
      <img src="https://via.placeholder.com/250x150?text=Sales+Record" alt="Sales Record">
      <h2>Sales Record</h2>
      <p>Sales and orders</p>
      <button>View</button>
    </div>
    <!-- Employee Data Box -->
    <div class="report-box" onclick="showDetails('employeeDetails')">
      <img src="https://via.placeholder.com/250x150?text=Employee+Data" alt="Employee Data">
      <h2>Employee Data</h2>
      <p>Staff information</p>
      <button>View</button>
    </div>
  </div>
  
  <!-- Detail Section: Current Jobs -->
  <div id="currentDetails" class="details-section">
    <h2>Current Jobs</h2>
    <%
      List<Job> currentJobs = (List<Job>) request.getAttribute("currentJobs");
      if (currentJobs != null && !currentJobs.isEmpty()) {
          for (Job job : currentJobs) {
    %>
      <p><strong>Job ID:</strong> <%= job.getJobId() %> – <strong>Job Name:</strong> <%= job.getJobName() %> – <strong>Description:</strong> <%= job.getDescription() %></p>
    <%
          }
      } else {
    %>
      <p>No current jobs available.</p>
    <%
      }
    %>
  </div>
  
  <!-- Detail Section: Pending Jobs -->
  <div id="pendingDetails" class="details-section">
    <h2>Pending Jobs</h2>
    <%
      List<Job> pendingJobs = (List<Job>) request.getAttribute("pendingJobs");
      if (pendingJobs != null && !pendingJobs.isEmpty()) {
          for (Job job : pendingJobs) {
    %>
      <p><strong>Job ID:</strong> <%= job.getJobId() %> – <strong>Job Name:</strong> <%= job.getJobName() %> – <strong>Description:</strong> <%= job.getDescription() %></p>
    <%
          }
      } else {
    %>
      <p>No pending jobs available.</p>
    <%
      }
    %>
  </div>
  
  <!-- Detail Section: Sales Record -->
  <div id="salesDetails" class="details-section">
    <h2>Sales Record</h2>
    <%
      List<SaleRecord> saleRecords = (List<SaleRecord>) request.getAttribute("saleRecords");
      if (saleRecords != null && !saleRecords.isEmpty()) {
          for (SaleRecord sr : saleRecords) {
    %>
      <p>
        <strong>Sale ID:</strong> <%= sr.getSaleId() %> – 
        <strong>Amount:</strong> $<%= sr.getSaleAmount() %> – 
        <strong>Date:</strong> <%= sr.getSaleDate() %>
      </p>
    <%
          }
      } else {
    %>
      <p>No sales records available.</p>
    <%
      }
    %>
  </div>
  
  <!-- Detail Section: Employee Data -->
  <div id="employeeDetails" class="details-section">
    <h2>Employee Data</h2>
    <%
      List<Employee> employeeData = (List<Employee>) request.getAttribute("employeeData");
      if (employeeData != null && !employeeData.isEmpty()) {
          for (Employee emp : employeeData) {
    %>
      <p><strong>Employee ID:</strong> <%= emp.getEmployeeId() %> – <strong>Name:</strong> <%= emp.getFirstName() %> <%= emp.getLastName() %></p>
    <%
          }
      } else {
    %>
      <p>No employee data available.</p>
    <%
      }
    %>
  </div>
  
  <!-- Footer -->
  <footer>
    <p>&copy; 2025 Home Design Solutions</p>
  </footer>
</body>
</html>