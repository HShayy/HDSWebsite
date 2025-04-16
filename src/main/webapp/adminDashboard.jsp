<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Home Design Solutions</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            background-color: #fff; 
            padding: 20px; 
        }
        h1 { 
            text-align: center; 
        }
        .welcome { 
            text-align: center; 
            margin-bottom: 20px; 
        }
        /* Navigation buttons container */
        .nav-buttons {
            text-align: center;
            margin-bottom: 20px;
        }
        .nav-buttons a {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            background-color: #fff;
            color: #000;
            border: 2px solid #000;
            border-radius: 4px;
            text-decoration: none;
            margin: 0 10px;
        }
        .nav-buttons a:hover {
            background-color: #f2f2f2;
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px; 
        }
        th, td { 
            border: 1px solid #000; 
            padding: 8px; 
            text-align: left; 
        }
        th { 
            background-color: #f2f2f2; 
        }
        a { 
            text-decoration: none; 
            color: #000; 
        }
    </style>
</head>
<body>
    <!-- Welcome Section -->
    <div class="welcome">
        <h1>Welcome, Admin</h1>
        <p>This is your dashboard where you can view orders and manage inventory.</p>
    </div>
    
    <!-- Navigation Buttons for Inventory and Reports -->
    <div class="nav-buttons">
        <a href="${pageContext.request.contextPath}/InventoryServlet">View Inventory</a>
        <a href="${pageContext.request.contextPath}/ReportsServlet">View Reports</a>
    </div>
    
    <!-- Placeholder Orders Table (to be made dynamic later) -->
    <table>
        <thead>
            <tr>
                <th>Sale ID</th>
                <th>Quantity</th>
                <th>Total Cost</th>
                <th>Sale Date</th>
                <th>Serial</th>
                <th>Customer ID</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1054</td>
                <td>1</td>
                <td>$499</td>
                <td>2022-08-08</td>
                <td>10225688</td>
                <td>455</td>
            </tr>
            <!-- Additional rows can be added here later -->
        </tbody>
    </table>
    
    <p style="text-align: center;"><a href="index.html">Return to Home</a></p>
</body>
</html>
