<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inventory List - Home Design Solutions</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            background-color: #fff; 
            padding: 20px; 
        }
        h1 { 
            text-align: center; 
            margin-bottom: 20px;
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
    <h1>Inventory List</h1>
    <%
        // Retrieve the inventory list set by InventoryServlet
        List<Map<String, String>> inventory = (List<Map<String, String>>) request.getAttribute("inventory");
        if (inventory == null || inventory.isEmpty()) {
    %>
        <p>No inventory available.</p>
    <%
        } else {
            // Use the first row to get table headers
            Map<String, String> firstRow = inventory.get(0);
    %>
        <table>
            <thead>
                <tr>
                    <% for (String colName : firstRow.keySet()) { %>
                        <th><%= colName %></th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> row : inventory) { %>
                    <tr>
                    <% for (String value : row.values()) { %>
                        <td><%= value %></td>
                    <% } %>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <%
        }
    %>
    <p style="text-align: center;"><a href="index.html">Return to Home</a></p>
</body>
</html>