<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Profile</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
            }

            #navbar {
                border-bottom: 5px solid #04484f;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
            }

            .sidebar {
                height: 100%;
                width: 250px;
                position: fixed;
                top: 0;
                left: 0;
                background-color: #ffffff;
                border-right: 5px solid #04484f;
                padding-top: 10px;
                z-index: 1000;
            }

            .sidebar a {
                padding: 10px 20px;
                text-decoration: none;
                font-size: 20px;
                color: #04484f;
                display: block;
                transition: 0.125s;
            }

            .sidebar a:hover {
                border: 2px solid #04484f;
                border-radius: 5px;
            }

            .search-container {
                display: flex;
                align-items: center;
                border: 2px solid #333;
                border-radius: 25px;
                padding: 5px 15px;
                max-width: 400px;
                width: 100%;
            }

            .search-container input {
                border: none;
                outline: none;
                font-size: 16px;
                flex: 1;
                padding: 10px;
            }

            .search-container button {
                background-color: #333;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 20px;
                cursor: pointer;
                font-size: 16px;
            }

            .search-container button:hover {
                background-color: #555;
            }

            .content {

                margin-left: 250px;
                padding: 20px;
            }

            .content h1 {
                margin-top: 0;
            }

            .content p {
                font-size: 18px;
            }

            .login-btn {
                border: 5px solid #04484f;
                padding: 15px 25px;
                border-radius: 25px;
                text-decoration: none;
                color: #04484f;
                font-size: 16px;
            }

            .login-btn:hover {
                background-color: #04484f;
                color: white;
            }
            table,th,td{
                border: 1px #000;
                width: auto;
                padding: 3px;
            }
            .redirect {
                float: right;
                --bg-color: beige;
                --main-color: black;
                margin: auto 10px auto 10px;
                width: 200px;
                height: 40px;
                border-radius: 5px;
                border: 2px solid var(--main-color);
                background-color: var(--bg-color);
                box-shadow: 4px 4px var(--main-color);
                font-size: 17px;
                font-weight: 600;
                color: var(--font-color);
                cursor: pointer;
            }
            .redirect:active {
                box-shadow: 0px 0px var(--main-color);
                transform: translate(3px, 3px);
            }
            a.redirect{
                text-decoration: none;
                text-align: center;
                line-height: 2.5;
            }
            h3 {
                border-bottom: 1px solid currentColor;
            }
        </style>
    </head>
    <body>
        <div id="navbar">
            <div>
            </div>

            <div class="search-container">
                <input type="text" placeholder="Search..." />
                <button type="submit">Search</button>
            </div>

            <div>
                <a class="login-btn" href="AuthCheckServlet">Login</a>
            </div>
        </div>

        <div class="sidebar">
            <a href="../home.jsp"><img src="Images/logohorizon.png" height="90" width ="230" alt="alt" style="padding:0;margin:0;"/></a>
            <a href="../home.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="event.jsp">Events</a>
            <a href="cart.jsp">Cart</a>
            <a href="checkout.jsp">Checkout</a>
            <!-- This part is for if I am an admin or a staff 
            if Admin :
            <a href="Product Details">Order products</a>
            <a href="Staff">Checkout</a>
            if Staff :
            <a href="Product Details">Product Details</a>
            -->
        </div>
        <div class="content">
            <table>
                <tr>
                    <td>
                        <p>Name : ${userName}</p>
                        <p>ID &nbsp; &nbsp; &nbsp; : ${userId}</p>
                    </td>
                </tr>
                <!-- Admin Features -->
                <%
                    Boolean isAdmin = (Boolean) request.getAttribute("isAdmin");
                    Boolean isStaff = (Boolean) request.getAttribute("isStaff");

                    if (isAdmin) {
                %>
                <tr>
                    <td colspan="5"><h3>Admin Privilege</h3></td>     
                </tr>
                <tr>
                    <th>User Management</th>
                    <td><a class="redirect" href="../user/viewUserServlet">Manage all user</a></td>
                </tr><tr>
                    <th>Report</th>
                    <td><a class="redirect" href="../report.jsp">Enter Report Page</td>
                </tr>
                <%  } %>
                <!-- Staff Features -->
                <%
                    if (isAdmin || isStaff) {
                %>
                <tr>
                    <td colspan="5"><h3>Staff Privilege</h3></td> 
                </tr>
                <tr>
                    <th>Item Management</th>
                    <td><a class="redirect" href="addItem.html">Add item</a></td>
                    <td><a class="redirect" href="viewItemServlet">View all item</a></td>
                    <td><a class="redirect" href="editItem.jsp">Edit item</a></td>
                    <td><a class="redirect" href="removeItem.html">Remove item</a></td>
                </tr>
                <% }%>
                <tr>
                    <td colspan="5"><h3>User Privilege</h3></td>     
                </tr>
                <tr>
                    <!-- Common User Features -->
                    <th>My Account</th>
                    <td><form action="../Auth/viewPersonalServlet" method="get"><button type="submit" class="redirect">View Personal Info</button></form></td>
                    <td><form action="itemOrderServlet" method="POST"><button type="submit" class="redirect">Order</button></form></td>
                    <td><form action="SignoutServlet" method="POST"><button type="submit" class="redirect">Sign Out</button></form></td>
                </tr>
                <tr>
                    <td>
                       ${error} 
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>

