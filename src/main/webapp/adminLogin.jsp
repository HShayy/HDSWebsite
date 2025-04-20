<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Home Design Solutions</title>
    <style>
        /* Basic reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background-color: #fff;
        }
        
        /* Header with brand and nav */
        header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #f2f2f2;
            padding: 10px 20px;
            border-bottom: 2px solid #000;
        }
        
        .logo {
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
        
        /* Container styles for both login and dashboard views */
        .login-container, .dashboard-container {
            width: 500px;
            margin: 40px auto;
            border: 2px solid #000;
            padding: 30px;
            border-radius: 4px;
            text-align: center;
            background-color: #fafafa;
        }
        
        /* Headings */
        .login-container h1, .dashboard-container h1 {
            font-size: 26px;
            margin-bottom: 20px;
        }
        
        /* Form field layout */
        .form-field {
            margin-bottom: 15px;
            text-align: left;
            width: 300px;
            margin: 0 auto;
        }
        
        .form-field label {
            display: inline-block;
            width: 120px;
            font-weight: bold;
        }
        
        .form-field input {
            width: 180px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        
        /* Forgot password link */
        .forgot-link {
            display: block;
            margin: 10px 0;
            text-align: right;
            width: 300px;
            margin: 0 auto 15px auto;
        }
        
        .forgot-link a {
            color: #000;
            text-decoration: none;
            font-size: 14px;
        }
        
        .forgot-link a:hover {
            text-decoration: underline;
        }
        
        /* Sign In button (red) */
        .sign-in-btn {
            margin-top: 15px;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            background-color: #d00;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        
        .sign-in-btn:hover {
            background-color: #a00;
        }
        
        /* Navigation buttons for admin dashboard */
        .nav-btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            background-color: #fff;
            color: #000;
            border: 2px solid #000;
            cursor: pointer;
            border-radius: 4px;
            text-decoration: none;
            margin: 10px 5px;
        }
        
        .nav-btn:hover {
            background-color: #f2f2f2;
        }
        
        /* Return link */
        .return-link {
            margin-top: 15px;
            font-size: 14px;
        }
        
        .return-link a {
            color: #000;
            text-decoration: none;
            font-weight: bold;
        }
        
        .return-link a:hover {
            text-decoration: underline;
        }
        
        /* Error message */
        .error {
            color: red;
            font-weight: bold;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <header>
        <div class="logo">Home Design Solutions</div>
        <nav>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="ProductServlet">Products</a></li>
                <li><a href="contact.html">Contact</a></li>
                <li><a href="cart.jsp">Cart</a></li>
                <li><a href="login.jsp">Sign in</a></li>
            </ul>
        </nav>
    </header>
    
    <%
       // Check for a session attribute that indicates the admin is logged in.
       Boolean isAdminLoggedIn = (Boolean) session.getAttribute("isAdminLoggedIn");
       if (isAdminLoggedIn != null && isAdminLoggedIn.booleanValue()) {
    %>
        <!-- Admin Dashboard View -->
        <div class="dashboard-container">
            <h1>Admin Dashboard</h1>
            <div>
                <a href="${pageContext.request.contextPath}/InventoryServlet" class="nav-btn">View Inventory</a>
                <a href="${pageContext.request.contextPath}/ReportsServlet" class="nav-btn">View Reports</a>
            </div>
            <div class="return-link">
                <a href="index.html">Return to Homepage</a>
            </div>
        </div>
    <%
       } else {
    %>
        <!-- Admin Login Form -->
        <div class="login-container">
            <h1>Admin Login</h1>
            <form action="AdminLoginServlet" method="post">
                <div class="form-field">
                    <label for="adminUsername">Username:</label>
                    <input type="text" id="adminUsername" name="adminUsername" required />
                </div>
                <div class="form-field">
                    <label for="adminPassword">Password:</label>
                    <input type="password" id="adminPassword" name="adminPassword" required />
                </div>
                <div class="forgot-link">
                    <a href="#">Forgot your password?</a>
                </div>
                <button type="submit" class="sign-in-btn">SIGN IN</button>
            </form>
            <div class="return-link">
                <a href="index.html">Return to Homepage</a>
            </div>
            <% 
                String errorMsg = request.getParameter("error");
                if (errorMsg != null) { 
            %>
                <div class="error"><%= errorMsg %></div>
            <% } %>
        </div>
    <%
       }
    %>
</body>
</html>