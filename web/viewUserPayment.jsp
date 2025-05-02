<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="da.*" %>
<%@ page import="domain.*" %>

<%
    List<Payment> paymentList = (List<Payment>) request.getAttribute("paymentList");
    Boolean paymentUpdated = (Boolean) request.getAttribute("paymentUpdated");
    if (paymentUpdated == null) paymentUpdated = false;
    String userID = (String) request.getAttribute("userID");
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Payments</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #000;
        }
        h2 {
            margin-top: 40px;
            color: #333;
        }
        .success-popup {
            display: none;
            background-color: lightgreen;
            padding: 10px;
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

        <div class="content">
<%
    String updatedParam = request.getParameter("updated");
    boolean paymentUpdatedBool = "true".equalsIgnoreCase(updatedParam);
%>
<div id="successPopup" class="success-popup" style="<%= paymentUpdatedBool ? "display:block;" : "display:none;" %>">
    <p>Updated to Paid!</p>
</div>
    <h1 style="text-align:center;">Payment & Order Details</h1>

    <%
        if (paymentList != null && !paymentList.isEmpty()) {
            for (Payment p : paymentList) {
    %>
        <h2>Payment ID: <%= p.getPaymentID() %></h2>
        <p>Total Price: RM <%= p.getTotalPrice() %><br>
           Payment Method: <%= p.getPaymentMethod() %><br>
           Payment Status: 
           <span style="color: <%= p.getPaymentStatus().equals("Paid") ? "green" : "red" %>;">
               <%= p.getPaymentStatus() %>
           </span><br>

        <% if (p.getPaymentStatus().equals("Pending")) { %>
            <!-- Button to show the payment method form -->
            <button onclick="togglePaymentForm('<%= p.getPaymentID() %>')">Select Payment Method</button>
        <% } %>

        <!-- Payment Method Form (Initially hidden) -->
        <form id="paymentForm-<%= p.getPaymentID() %>" action="updatePaymentStatusServlet" method="post" style="display: none;">
            <input type="hidden" name="paymentID" value="<%= p.getPaymentID() %>" />
            <input type="hidden" name="userID" value="<%= p.getUserID() %>" />
            <label for="paymentMethod">Select Payment Method:</label>
            <select name="paymentMethod">
                <option value="TNG">TNG</option>
                <option value="Card">Card</option>
                <option value="Cash">Cash</option>
            </select>
            <button type="submit">Confirm Payment</button>
        </form>

        <!-- Orders Table -->
        <table>
            <tr>
                <th>Order ID</th>
                <th>Item Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Order Date</th>
            </tr>
            <%
                for (Order o : p.getOrders()) {
            %>
                <tr>
                    <td><%= o.getOrderID() %></td>
                    <td><%= o.getItemName() %></td>
                    <td><%= o.getItemCategory() %></td>
                    <td>RM <%= o.getPrice() %></td>
                    <td><%= o.getQuantity() %></td>
                    <td><%= o.getOrderDate() %></td>
                </tr>
            <%
                }
            %>
        </table>

    <%
            }
        } else {
    %>
        <p style="text-align:center; color:red;">No payment records found.</p>
    <%
        }
    %>

    <!-- Success Popup -->
    <div id="successPopup" class="success-popup">
        <p>Updated to Paid!</p>
    </div>

    <div style="text-align:center;">
        <a href="user.html">Back to Home</a>
    </div>

    <script>
        function togglePaymentForm(paymentID) {
            var form = document.getElementById("paymentForm-" + paymentID);
            form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
        }
    </script>
<% if (paymentUpdatedBool) { %>
<script>
    setTimeout(() => {
        document.getElementById("successPopup").style.display = "none";
    }, 3000);
</script>
<% } %>
        </div>
</body>
</html>