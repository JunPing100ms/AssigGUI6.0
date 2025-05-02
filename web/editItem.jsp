<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="domain.*" %>
<%@ page import="da.*" %>
<%@ page import="item.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Item</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css" />
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
    <div class = "content">
<%
    // Get the item object from the request attribute
    Item i = (Item)request.getAttribute("editItem");
    if (i != null) {
%>
        <h3>Edit Item</h3>
        <form method="post" action="editItemServlet">
        <p>ID: <input type="text" name="id" value="<%= i.getID() %>" readonly /></p>
        <p>Name: <input type="text" name="name" value="<%= i.getName() %>" /></p>
        <p>Category: <select name="category" value="<%= i.getCategory() %>">
                    <option value = "Badminton">Badminton</option>
                    <option value = "Table Tennis">Table Tennis</option>
                    <option value = "General">General</option>
        </select></p>         
        <p>Price: <input type="text" name="price" value="<%= i.getPrice() %>" /></p>
        <p>Stock: <input type="text" name="stock" value="<%= i.getStock() %>" /></p>
        <input type="submit" value="Update">
    </form>
<%
    } else {
        out.println("<p>Item not found!</p>");
    }
%>

<%
    // Show any error message if it exists
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<%
    }
%>
    <a href="staff.html">Return</a><br>
</div>

    </body>
</html>
