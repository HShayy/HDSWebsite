<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Log-in - Home Design Solutions</title>
    <style>
        /* Reset some basics */
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
            margin-bottom: 30px;
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

        /* Centered Container for the login box */
        .login-container {
            width: 500px;          /* Increased width for a bigger box */
            margin: 40px auto;     /* Center horizontally with top/bottom margin */
            border: 2px solid #000;
            padding: 30px;
            border-radius: 4px;
            text-align: center;    /* Center the heading, but we'll adjust form fields for alignment */
            background-color: #fafafa;
        }

        .login-container h1 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        /* Subtext under heading */
        .account-note {
            font-size: 14px;
            margin-bottom: 20px;
        }

        /* Form field layout */
        .form-field {
            margin-bottom: 15px;
            text-align: left; /* Align labels and inputs to the left */
            margin: 0 auto;  /* Center the form row horizontally */
            width: 300px;    /* Restrict width so labels/inputs line up */
        }
        .form-field label {
            display: inline-block;
            width: 80px;
            font-weight: bold;
        }
        .form-field input {
            width: 200px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        /* Forgot password link */
        .forgot-link {
            font-size: 13px;
            margin: 8px 0;
            text-align: right;
            width: 300px;
            margin: 0 auto 15px auto;  /* center it, with bottom margin */
        }
        .forgot-link a {
            color: #000;
            text-decoration: none;
        }
        .forgot-link a:hover {
            text-decoration: underline;
        }

        /* SIGN IN button - bright green from mockup */
        .signin-btn {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            background-color: #bff600; /* Bright green */
            color: #000;              
            border: 2px solid #000;
            cursor: pointer;
            margin-top: 10px;
            border-radius: 4px;
        }
        .signin-btn:hover {
            background-color: #a4de00; /* Darker on hover */
        }

        /* Admin Login button - styled similarly */
        .admin-btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            background-color: #fff;
            color: #000;
            border: 2px solid #000;
            cursor: pointer;
            border-radius: 4px;
            margin-top: 20px;
            text-decoration: none;
        }
        .admin-btn:hover {
            background-color: #f2f2f2;
        }

        /* Return link and error message */
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
                <li><a href="products.jsp">Products</a></li>
                <li><a href="contact.html">Contact</a></li>
                <li><a href="cart.jsp">Cart</a></li>
                <li><a href="login.jsp">Sign in</a></li>
            </ul>
        </nav>
    </header>

    <!-- Login Container -->
    <div class="login-container">
        <h1>Customer Log-in</h1>
        <div class="account-note">
            Don't have an account? Create an account.
        </div>

        <!-- Form -->
        <form action="LoginServlet" method="post">
            <!-- Email Field -->
            <div class="form-field">
                <label for="username">Email:</label>
                <input type="text" id="username" name="username" required />
            </div>

            <!-- Password Field -->
            <div class="form-field">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required />
            </div>

            <!-- Forgot password link -->
            <div class="forgot-link">
                <a href="#">Forgot your password?</a>
            </div>

            <!-- Sign In button -->
            <input type="submit" value="SIGN IN" class="signin-btn" />
            
            <!-- Error message (if any) -->
            <%
                String errorMsg = request.getParameter("error");
                if (errorMsg != null) {
            %>
                <div class="error"><%= errorMsg %></div>
            <% } %>
        </form>

        <!-- Extra Option: Admin Login using context path -->
        <div class="return-link" style="margin-top: 25px;">
            <a href="${pageContext.request.contextPath}/adminLogin.jsp" class="admin-btn">Log in as Admin</a>
        </div>

        <!-- Return link -->
        <div class="return-link">
            <a href="index.html">Return to Homepage</a>
        </div>
    </div>
</body>
</html>