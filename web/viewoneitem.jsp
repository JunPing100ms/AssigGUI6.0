<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="domain.*" %>
<%@ page import="item.*" %>

<%
    Item item = (Item) request.getAttribute("item");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html> 
<style>
        table { border-collapse: collapse; width: 50%; margin: auto; }
        th, td { padding: 8px 12px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #f2f2f2; }
</style>
    
<head>
    <meta charset="UTF-8">
    <title>View Item</title><link rel="stylesheet" href="styles.css" />
    </head>
    <body>
        <div id="navbar">
            <div>
            </div>

            <div class="search-container"><form action="SearchItemServlet" method="get" style="text-align:center; margin-bottom:20px;">
                    <input type="text" name="search" placeholder="Search item by name" required />
                    <input type="submit" value="Search" />
                </form>
            </div>

            <div>
                <a class="login-btn" href="Auth/Login.jsp">Login</a>
            </div>
        </div>

        <div class="sidebar">
            <a href="home.jsp"><img src="Images/logohorizon.png" height="90" width ="230" alt="alt" style="padding:0;margin:0;"/></a>
            <a href="home.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="event.jsp">Events</a>
            <a href="checkout/cart.jsp">Cart</a>
            <a href="checkout/checkout.jsp">Checkout</a>
        </div>

        <div class="content">
<body>

<h2 style="text-align:center;">Item Details</h2>

    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } else if (item == null) { %>
        <p style="text-align:center;">Item not found.</p>
    <% } else { %>
        <table>
            <tr>
                <th>Item Name</th>
                <td><%= item.getName() %></td>
            </tr>
            <tr>
                <th>Category</th>
                <td><%= item.getCategory() %></td>
            </tr>
            <tr>
                <th>Price (RM)</th>
                <td><%= String.format("%.2f", item.getPrice()) %></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <form action="addToCartServlet" method="post">
                        <input type="hidden" name="id" value="<%= item.getID() %>" />
                        <input type="submit" value="Add to Cart" />
                    </form>
                </td>
            </tr>
        </table>
    <% } %>
    <a href="home.jsp">Return</a><br>
        </div>
</body>
</html>
