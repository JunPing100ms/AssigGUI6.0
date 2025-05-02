<%@ page import="java.util.List" %>
<%@ page import="report.Report" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>ATIERSPORTS</title>
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
                <a class="login-btn" href="Auth">Login</a>
            </div>
        </div>

        <div class="sidebar">
            <a href="home.jsp"><img src="Images/logohorizon.png" height="90" width ="230" alt="alt" style="padding:0;margin:0;"/></a>
            <a href="home.jsp">Home</a>
            <a href="order.jsp">Products</a>
            <a href="event.jsp">Events</a>
            <a href="checkout/cart.jsp">Cart</a>
            <a href="checkout/checkout.jsp">Checkout</a>
        </div>

        <div class="content">
            <p class ="bar">Top Items Sold</p>
<%
    List<Report> reportList = (List<Report>) request.getAttribute("reportList");
    if (reportList != null && !reportList.isEmpty()) {
        Report sample = reportList.get(0);
%>

<table>
    <thead>
    <tr>
        <% 
            if (sample.getItemID() != null) { 
        %>
            <th>Name</th>
            <th>Category</th>
            <th>Price (RM)</th>=
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
                <td><%= r.getItemName() %></td>
                <td><%= r.getItemCategory() %></td>
                <td><%= String.format("%.2f", r.getItemPrice()) %></td>
            <% } %>
        </tr>
    <% } %>
    </tbody>
</table>

<%
    } else {
%>
    <p style="text-align: center;">No records found</p>
<%
    }
%>
                <div class="info">
                    <h2>About Our Company</h2>
                    <p>
                        Welcome to ATIERSPORTS, your trusted source for quality sports equipment and gear.
                        Founded in 2023, we are committed to delivering the best products to athletes and enthusiasts of all levels.
                    </p>
                    <p>
                        We offer a wide range of equipment for sports such as football, basketball, tennis, and more. 
                        Our mission is to support your journey to greatness by equipping you with reliable and affordable gear.
                    </p>
                    <p>
                        Whether you?re a professional or just getting started, we?re here to help you play your best.
                        Thank you for choosing us!
                    </p>
                </div>

        </div>
    </body>
</html>
