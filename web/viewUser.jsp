<%@page import="java.util.List"%>
<%@page import="domain.User"%>
<%@page import="da.UserDA"%>
<jsp:setProperty name="item" property="*"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: auto; }
        th, td { padding: 8px 12px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
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

        <div class="content">

    <div style="display: flex; justify-content: center; gap: 10px; margin-top: 20px;">
        <form action="viewUserServlet">
          <input type="submit" value="Display user" />
        </form>
        <form action="viewStaffServlet">
          <input type="submit" value="Display staff" />
        </form>
         <form action="viewAdminServlet">
          <input type="submit" value="Display admin" />
        </form>
    </div>
    <a href="addUser.html">Add user</a><br>

<h2 style="text-align:center;">All <%= request.getAttribute("userRole") != null ? request.getAttribute("userRole") : "Users" %></h2>

    <%
        List<User> userList = (List<User>) request.getAttribute("allUsers");
        if (userList != null && !userList.isEmpty()) {
    %>
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Birthday</th>
        <th>Password</th>
        <th>Create Date</th>
        <th colspan="2">Options</th>
    </tr>
    <%
        for (User u : userList) {
    %>
    <tr>
        <td><%= u.getId() %></td>
        <td><%= u.getName() %></td>
        <td><%= u.getEmail() %></td>
        <td><%= u.getPhone() %></td>
        <td><%= u.getHbd() %></td>
        <td><%= u.getPwd() %></td>
        <td><%= u.getCreateDate() %></td>
        <td>
        <form action="getUserServlet" method="get" style="display:inline;">
            <input type="hidden" name="id" value="<%= u.getId() %>" />
            <input type="submit" value="Edit" />
        </form>
        </td>
        <td>
            <form action="deleteUserServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this user?');">
                <input type="hidden" name="id" value="<%= u.getId() %>" />
                <input type="submit" value="Delete" />
            </form>
        </td>
    </tr>
    <%
        }
    %>
</table>
    <%
        } else {
    %>
        <!--<p style="text-align:center; color:red;">No users found.</p>-->
    <%
        }
    %>
     <a href="admin.html">Return</a><br>
        </div>
</body>
</html>