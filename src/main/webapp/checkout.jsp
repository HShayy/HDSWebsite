<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8" import="java.util.*, com.hds.model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - Home Design Solutions</title>
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
            color: #333;
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

        /* Main title for page */
        h1.page-title {
            text-align: center;
            margin: 20px 0;
        }

        /* Container for the two-column checkout layout */
        .checkout-container {
            display: flex;
            max-width: 1200px;
            margin: 0 auto;
            gap: 20px;
            padding: 0 20px 20px 20px; 
        }

        /* Left column for the form sections */
        .checkout-left {
            flex: 1;
            min-width: 300px;
            max-width: 600px; /* a bit wider so the form can breathe */
        }

        /* The box that wraps the form on the left side */
        .checkout-form-box {
            border: 2px solid #000;
            padding: 20px;
            background-color: #fafafa;
            border-radius: 4px;
        }

        /* Each major heading in the form (Contact, Delivery, Payment) */
        .form-section-heading {
            font-size: 18px;
            font-weight: bold;
            margin: 25px 0 10px;
        }

        /* The block that holds a group of related fields (like in your screenshot) */
        .form-block {
            margin-bottom: 25px; /* space between sections */
        }

        /* Label + input row styling */
        .input-row {
            display: flex;
            flex-wrap: wrap; 
            gap: 10px;
            margin-bottom: 10px;
        }
        .input-row label {
            flex: 1 0 150px;  /* label width */
            text-align: right;
            font-weight: bold;
            align-self: center;
        }
        .input-row input,
        .input-row select {
            flex: 3 0 250px; /* input is bigger, adapt for your preference */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        /* Payment/Submit button */
        .pay-now-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            width: 100%; /* full width button to mimic typical checkout style */
            font-size: 16px;
            font-weight: bold;
            background-color: #000;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        .pay-now-btn:hover {
            background-color: #444;
        }

        /* Right column for cart summary, images, discount code, and total */
        .checkout-right {
            flex: 1;
            min-width: 300px;
            max-width: 450px;
            border-left: 2px solid #ccc;
            padding-left: 20px;
        }
        .section-title-right {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        /* Cart items list */
        .cart-items {
            margin-top: 10px;
            margin-bottom: 15px;
        }
        .cart-item {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
            align-items: center;
        }
        .cart-item img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .cart-details h3 {
            margin: 0;
            font-size: 14px;
            font-weight: bold;
        }
        .cart-details p {
            margin: 3px 0;
            font-size: 14px;
        }

        /* Discount code input */
        .discount-field {
            display: flex;
            margin-top: 10px;
            margin-bottom: 15px;
        }
        .discount-field input[type="text"] {
            flex: 1;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .discount-field button {
            margin-left: 10px;
            padding: 8px 12px;
            cursor: pointer;
            font-size: 14px;
            border: none;
            background-color: #000;
            color: #fff;
            border-radius: 4px;
        }

        /* Price summary at bottom of right column */
        .price-summary p {
            margin: 5px 0;
            font-size: 14px;
        }
        .price-summary strong {
            font-size: 16px;
        }
        .total-amount {
            font-size: 16px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Header -->
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

    <h1 class="page-title">Checkout</h1>
    
    <%
        // Retrieve cart items from session
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <p style="text-align: center; font-size: 18px; color: #d00;">
            Your cart is empty. <a href="products.jsp">Return to Products</a>
        </p>
    <%
        } else {
            double subtotal = 0.0;
            for (CartItem item : cart) {
                subtotal += (item.getPrice() * item.getQuantity());
            }
            double tax = subtotal * 0.06;
            double total = subtotal + tax;
    %>
    
    <!-- Main container with two columns -->
    <div class="checkout-container">
        
        <!-- LEFT COLUMN: Form sections (Contact, Delivery, Payment) -->
        <div class="checkout-left">
            <div class="checkout-form-box">
              <form action="CheckoutServlet" method="post">
                  <!-- CONTACT SECTION -->
                  <div class="form-block">
                    <h2 class="form-section-heading">Contact information</h2>
                    <div class="input-row">
                      <label for="customerEmail">Email *</label>
                      <input type="email" id="customerEmail" name="customerEmail" required />
                    </div>
                    <div class="input-row">
                      <label for="customerName">Name *</label>
                      <input type="text" id="customerName" name="customerName" required />
                    </div>
                    <div class="input-row">
                      <label for="customerPhone">Phone</label>
                      <input type="text" id="customerPhone" name="customerPhone" />
                    </div>
                  </div>
                  
                  <!-- DELIVERY SECTION -->
                  <div class="form-block">
                    <h2 class="form-section-heading">Shipping address</h2>
                    <div class="input-row">
                      <label for="country">Country/region</label>
                      <select id="country" name="country">
                        <option value="US">United States (US)</option>
                        <option value="CA">Canada</option>
                        <option value="ES">Spain</option>
                        <!-- Add more countries as needed -->
                      </select>
                    </div>
                    <div class="input-row">
                      <label for="firstName">First name</label>
                      <input type="text" id="firstName" name="firstName" />
                    </div>
                    <div class="input-row">
                      <label for="lastName">Last name</label>
                      <input type="text" id="lastName" name="lastName" />
                    </div>
                    <div class="input-row">
                      <label for="address">Street and house number</label>
                      <input type="text" id="address" name="address" />
                    </div>
                    <div class="input-row">
                      <label for="address2">Apartment, suite, etc.</label>
                      <input type="text" id="address2" name="address2" />
                    </div>
                    <div class="input-row">
                      <label for="zip">Postal code</label>
                      <input type="text" id="zip" name="zip" />
                    </div>
                    <div class="input-row">
                      <label for="city">City</label>
                      <input type="text" id="city" name="city" />
                    </div>
                    <div class="input-row">
                      <label for="state">Province</label>
                      <input type="text" id="state" name="state" />
                    </div>
                    <div class="input-row">
                      <label for="phone2">Phone</label>
                      <input type="text" id="phone2" name="phone2" />
                    </div>
                  </div>
                  
                  <!-- PAYMENT SECTION -->
                  <div class="form-block">
                    <h2 class="form-section-heading">Payment</h2>
                    <div class="input-row">
                      <label for="cardNumber">Card Number</label>
                      <input type="text" id="cardNumber" name="cardNumber" />
                    </div>
                    <div class="input-row">
                      <label for="expDate">Expiration date</label>
                      <input type="text" id="expDate" name="cardExp" placeholder="MM/YY" />
                    </div>
                    <div class="input-row">
                      <label for="cardCvv">Security code</label>
                      <input type="text" id="cardCvv" name="cardCvv" size="3" />
                    </div>
                  </div>

                  <!-- Submit Button -->
                  <button type="submit" class="pay-now-btn">PAY NOW</button>
              </form>
            </div>
        </div>
        
        <!-- RIGHT COLUMN: Cart Items, Discount Code, Summary -->
        <div class="checkout-right">
            <h2 class="section-title-right">Order Summary</h2>
            
            <!-- List of cart items -->
            <div class="cart-items">
                <%
                  // For each item, show an image & details
                  for (CartItem item : cart) {
                      // Placeholder image, replace if you have actual product images
                      String thumbnailUrl = "https://via.placeholder.com/80";
                %>
                <div class="cart-item">
                    <img src="<%= thumbnailUrl %>" alt="Item Image" />
                    <div class="cart-details">
                        <h3><%= item.getProductName() %></h3>
                        <p>Price: $<%= String.format("%.2f", item.getPrice()) %></p>
                        <p>Quantity: <%= item.getQuantity() %></p>
                    </div>
                </div>
                <%
                  } // end for loop
                %>
            </div>

            <!-- Discount Code Input -->
            <div class="discount-field">
                <input type="text" placeholder="Discount code or gift card" />
                <button type="button">Apply</button>
            </div>
            
            <!-- Price summary at bottom -->
            <div class="price-summary">
                <p>Subtotal: $<%= String.format("%.2f", subtotal) %></p>
                <p>Shipping: $0.00</p>
                <p>Tax (6%): $<%= String.format("%.2f", tax) %></p>
                <p class="total-amount">Total: $<%= String.format("%.2f", total) %></p>
            </div>
        </div>
    </div>
    <%
        } // end else for cart check
    %>
</body>
</html>
