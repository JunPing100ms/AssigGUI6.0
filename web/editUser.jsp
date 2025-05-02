<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="domain.User" %>
<%@ page import="da.UserDA" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
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
    // Get the user object from the request attribute
    User editUser = (User)request.getAttribute("editUser");
    if (editUser != null) {
%>
    <h3 class=bar>Edit User</h3>
    <form action="editUserServlet" method="post">
        <p>ID: <input type="text" name="id" value="<%= editUser.getId() %>" readonly /></p>
        <p>Name: <input type="text" name="name" value="<%= editUser.getName() %>" /></p>
        <p>Email: <input type="email" name="email" value="<%= editUser.getEmail() %>" /></p>
        <p>Phone: <input type="text" name="phone" value="<%= editUser.getPhone() %>" /></p>
        <p>Birthday: <input type="date" name="hbd" value="<%= editUser.getHbd() %>" /></p>
        <p>Password: <input type="text" name="pwd" value="<%= editUser.getPwd() %>" /></p>
        <p>Permission:
            <input type="radio" id="User" name="permission" value="" <%= editUser.getPermission().equals("") ? "checked" : "" %> /> User
            <input type="radio" id="Staff" name="permission" value="Staff" <%= editUser.getPermission().equals("Staff") ? "checked" : "" %> /> Staff
            <input type="radio" id="Admin" name="permission" value="Admin" <%= editUser.getPermission().equals("Admin") ? "checked" : "" %> /> Admin
        </p>
        <input type="submit" value="Update">
    </form>
<%
    } else {
        out.println("<p class=bar>User not found!</p>");
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

<a href="admin.html">Return</a><br>
</div>
</body>
</html>