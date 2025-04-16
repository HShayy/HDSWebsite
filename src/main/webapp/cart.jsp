<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8" import="java.util.*, com.hds.model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart - Home Design Solutions</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f7f7;
            padding: 20px;
            color: #444;
        }
        
        /* Header */
        header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #fff;
            padding: 15px 20px;
            border-bottom: 2px solid #ddd;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
        .logo {
            font-size: 26px;
            font-weight: bold;
            color: #222;
        }
        nav ul {
            list-style: none;
            display: flex;
            gap: 20px;
        }
        nav ul li a {
            text-decoration: none;
            color: #444;
            font-weight: bold;
            transition: color 0.3s;
        }
        nav ul li a:hover {
            color: #000;
        }
        
        /* Cart container */
        .cart-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 30px;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .cart-container h1 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 32px;
            color: #333;
        }
        
        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
            background: #fff;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
            font-size: 15px;
        }
        th {
            background: #f0f0f0;
            color: #333;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        /* Action buttons */
        .action-btn {
            padding: 6px 12px;
            font-size: 14px;
            cursor: pointer;
            border: 1px solid #888;
            background-color: #fff;
            border-radius: 4px;
            transition: background-color 0.3s, border-color 0.3s;
        }
        .action-btn:hover {
            background-color: #eee;
            border-color: #666;
        }
        
        /* Summary area */
        .summary-box {
            text-align: right;
            font-size: 16px;
            margin-top: 20px;
            line-height: 1.6;
        }
        .summary-box p {
            margin-bottom: 10px;
        }
        .checkout-btn {
            display: block;
            width: 220px;
            margin: 30px auto 10px;
            padding: 12px 0;
            font-size: 16px;
            font-weight: bold;
            background-color: #222;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .checkout-btn:hover {
            background-color: #000;
        }
        
        /* Footer */
        footer {
            text-align: center;
            background: #fff;
            padding: 12px;
            border-top: 2px solid #ddd;
            margin-top: 30px;
            font-size: 14px;
            color: #666;
        }
        
        a {
            color: #0073e6;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
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
    
    <!-- Main Cart Container -->
    <div class="cart-container">
        <h1>Your Shopping Cart</h1>
        <%
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
        %>
            <p style="font-size: 18px; color: #d00; text-align: center;">
                Your cart is empty. <a href="products.jsp">Return to Products</a>
            </p>
        <%
            } else {
                double subtotal = 0.0;
                for (CartItem item : cart) {
                    subtotal += item.getPrice() * item.getQuantity();
                }
                double taxRate = 0.06;
                double tax = subtotal * taxRate;
                double total = subtotal + tax;
        %>
        <table>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
            <%
                for (CartItem item : cart) {
                    double itemTotal = item.getPrice() * item.getQuantity();
                    
                    // Always use the placeholder image (as getImageUrl() is not defined)
                    String thumbnailUrl = "https://via.placeholder.com/80";
            %>
            <tr>
                <td><%= item.getProductId() %></td>
                <td>
                    <img src="<%= thumbnailUrl %>" alt="Item Image" style="display:block; margin:0 auto 5px auto;" />
                    <%= item.getProductName() %>
                </td>
                <td>$<%= String.format("%.2f", item.getPrice()) %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= String.format("%.2f", itemTotal) %></td>
                <td>
                    <form action="RemoveFromCartServlet" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="<%= item.getProductId() %>" />
                        <input type="submit" value="Remove" class="action-btn" />
                    </form>
                    <br>
                    <form action="UpdateCartServlet" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="<%= item.getProductId() %>" />
                        <input type="text" name="newQuantity" value="<%= item.getQuantity() %>" size="3" style="margin-top:5px;" />
                        <input type="submit" value="Update" class="action-btn" style="margin-top:5px;" />
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </table>
        <div class="summary-box">
            <p>Subtotal: $<%= String.format("%.2f", subtotal) %></p>
            <p>Tax (6%): $<%= String.format("%.2f", tax) %></p>
            <p><strong>Total: $<%= String.format("%.2f", total) %></strong></p>
        </div>
        <form action="checkout.jsp" method="get">
            <button type="submit" class="checkout-btn">Proceed to Checkout</button>
        </form>
        <%
            }
        %>
    </div>
    
    <!-- Footer Section -->
    <footer>
        <p>&copy; 2025 Home Design Solutions</p>
    </footer>
</body>
</html>