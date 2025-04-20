<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, com.hds.model.Product" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Products - Home Design Solutions</title>
  <!-- Link to the global CSS file if you have one -->
  <link rel="stylesheet" type="text/css" href="css/global.css" />
  <style>
    body {
      text-align: center;
      padding: 20px;
      background-color: #fff;
      font-family: Arial, sans-serif;
    }
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
    h1 {
      margin-top: 20px;
      margin-bottom: 20px;
      font-size: 32px;
      color: #333;
    }
    .products-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      justify-content: center;
    }
    .product {
      border: 1px solid #000;
      padding: 10px;
      width: 250px;
      vertical-align: top;
      text-align: center;
      background-color: #fafafa;
    }
    .product img {
      max-width: 150px;
      height: auto;
      margin-bottom: 10px;
    }
    .btn {
      padding: 8px 16px;
      border: 1px solid #000;
      background-color: #fff;
      cursor: pointer;
      text-decoration: none;
      margin-top: 10px;
    }
    footer {
      text-align: center;
      background-color: #f2f2f2;
      padding: 10px;
      border-top: 2px solid #000;
      margin-top: 20px;
    }
  </style>
</head>
<body>
  <!-- Header with logo and navigation -->
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

  <!-- Main Content: Product Grid -->
  <h1>Our Products</h1>
  <div class="products-grid">
    <%
      List<Product> products = (List<Product>) request.getAttribute("products");
      if (products != null && !products.isEmpty()) {
          for (Product p : products) {
              // Use the product's image URL if available; else use a placeholder image.
              String imageUrl = p.getImageUrl();
              if (imageUrl == null || imageUrl.trim().isEmpty()) {
                  imageUrl = "https://via.placeholder.com/150";
              }
    %>
      <div class="product">
        <img src="<%= imageUrl %>" alt="<%= p.getProductName() %>">
        <h2><%= p.getProductName() %></h2>
        <p>Price: $<%= String.format("%.2f", p.getPrice()) %></p>
        <form action="AddToCartServlet" method="post">
          <input type="hidden" name="productId" value="<%= p.getProductId() %>" />
          <input type="hidden" name="productName" value="<%= p.getProductName() %>" />
          <input type="hidden" name="productPrice" value="<%= p.getPrice() %>" />
          <input type="hidden" name="quantity" value="1" />
          <input type="submit" value="Add to Cart" class="btn" />
        </form>
      </div>
    <%
          }
      } else {
    %>
      <p>No products available at this time.</p>
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

