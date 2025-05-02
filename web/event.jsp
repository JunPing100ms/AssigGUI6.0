<%@ page import="domain.Event" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upcoming Events</title>
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
            background-color: white;
            
        }
        
        h2 {
            text-align: center;
        }
        img.event-image {
            max-width: 150px;
            height: auto;
        }
    </style>
    <link rel="stylesheet" href="styles.css" />
    </head>
    <body>
        <div id="navbar">

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
    <h2>Upcoming Events</h2>

    <p class="bar"><%= request.getAttribute("heymessage") %></p>

    <%
        List<Event> events = (List<Event>) request.getAttribute("eventList");
        if (events == null || events.isEmpty()) {
    %>
        <p style="text-align:center;">No events available.</p>
    <%
        } else {
    %>
        <table>
            <tr>
                <th>Image</th>
                <th>Title</th>
                <th>Date</th>
                <th>Description</th>
            </tr>
            <%
                for (Event event : events) {
            %>
            <tr>
                <td><img src="<%= event.getImageFileName() %>" alt="Event Image" class="event-image" /></td>
                <td><%= event.getTitle() %></td>
                <td><%= event.getDate() %></td>
                <td><%= event.getDescription() %></td>
            </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
        </div>
</body>
</html>
