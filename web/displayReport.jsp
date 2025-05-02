<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="report.Report" %>
<html>
<head>
    <title>Display Report</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background-color: #eee;
        }
        h2 {
            text-align: center;
        }
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
    <div class = "content">
<h2>${reportTitle}</h2>

<%
    List<Report> reportList = (List<Report>) request.getAttribute("reportList");
    if (reportList != null && !reportList.isEmpty()) {
        Report sample = reportList.get(0); // check first item to see what fields exist
%>

<table>
    <thead>
    <tr>
        <% 
            if (sample.getItemID() != null) { 
        %>
            <th>ID</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price (RM)</th>
            <th>Total Quantity Sold</th>
            <th>Total Sales (RM)</th>
        <% 
            } else if (sample.getItemCategory() != null) { 
        %>
            <th>Category</th>
            <th>Total Quantity Sold</th>
            <th>Total Sales (RM)</th>
        <% 
            } 
        %>
    </tr>
    </thead>
    <tbody>
    <% for (Report r : reportList) { %>
        <tr>
            <% if (r.getItemID() != null) { %>
                <td><%= r.getItemID() %></td>
                <td><%= r.getItemName() %></td>
                <td><%= r.getItemCategory() %></td>
                <td><%= String.format("%.2f", r.getItemPrice()) %></td>
                <td><%= r.getTotalQuantity() %></td>
                <td><%= String.format("%.2f", r.getTotalSales()) %></td>
            <% } else if (r.getItemCategory() != null) { %>
                <td><%= r.getItemCategory() %></td>
                <td><%= r.getTotalQuantity() %></td>
                <td><%= String.format("%.2f", r.getTotalSales()) %></td>
            <% } %>
        </tr>
    <% } %>
    </tbody>
</table>

<%
    } else {
%>
    <p style="text-align: center;">No records found for the selected month.</p>
<%
    }
%>
<button onclick="window.print()">Print Report</button><br>
<a href="report.jsp">Return Back</a>
</div>
</body>
</html>