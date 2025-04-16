<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation - Home Design Solutions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fff;
            padding: 20px;
            margin: 0;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        .confirmation-container {
            border: 2px solid #000;
            padding: 20px;
            margin: 20px auto;
            width: 60%;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        .order-details {
            text-align: left;
            margin-top: 20px;
        }
        .order-details p {
            font-size: 16px;
            margin: 5px 0;
        }
        .return-home {
            margin-top: 30px;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            background-color: #000;
            text-decoration: none;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <%
            Boolean orderSuccess = (Boolean) request.getAttribute("orderSuccess");
            if (orderSuccess != null && orderSuccess) {
        %>
            <h1>Thank You for Your Order!</h1>
            <p>Your order has been placed successfully.</p>
            <div class="order-details">
                <p><strong>Order ID:</strong> <%= request.getAttribute("saleId") %></p>
                <p><strong>Name:</strong> <%= request.getAttribute("customerName") %></p>
                <p><strong>Shipping Address:</strong> 
                   <%= request.getAttribute("address") %>, 
                   <%= request.getAttribute("city") %>, 
                   <%= request.getAttribute("state") %> 
                   <%= request.getAttribute("zip") %>
                </p>
                <p><strong>Total Amount:</strong> $<%= String.format("%.2f", request.getAttribute("total")) %></p>
                <p><strong>Order Placed By:</strong> <%= request.getAttribute("username") %></p>
            </div>
        <%
            } else {
        %>
            <h1>Error Processing Order</h1>
            <p>Unfortunately, your order could not be processed at this time. Please try again later.</p>
        <%
            }
        %>
        <a class="return-home" href="index.html">Return to Home</a>
    </div>
</body>
</html>
