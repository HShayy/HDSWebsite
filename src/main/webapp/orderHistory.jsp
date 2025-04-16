<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hds.model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order History - Home Design Solutions</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #fff; padding: 20px; }
        h1 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #000; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        a { text-decoration: none; color: #000; }
    </style>
</head>
<body>
    <h1>Your Order History</h1>
    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        if (orders == null || orders.isEmpty()) {
    %>
        <p>No orders found.</p>
    <%
        } else {
    %>
        <table>
            <thead>
                <tr>
                    <th>Sale ID</th>
                    <th>Quantity</th>
                    <th>Total Cost</th>
                    <th>Sale Date</th>
                    <th>Serial</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Order order : orders) {
            %>
                <tr>
                    <td><%= order.getSaleId() %></td>
                    <td><%= order.getQuantity() %></td>
                    <td>$<%= order.getTotalCost() %></td>
                    <td><%= order.getSaleDate() %></td>
                    <td><%= order.getSerial() %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    <%
        }
    %>
    <p><a href="index.html">Return to Home</a></p>
</body>
</html>
