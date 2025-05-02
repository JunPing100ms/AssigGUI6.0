<%@page import="java.sql.ResultSet"%>
<%@page import="item.Item"%>
<%@page import="cart.Cart"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link rel="stylesheet" href="resources/cart.css"/><link rel="stylesheet" href="styles.css" />
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
        <a href="products.jsp"><button>Back</button></a>
        <h2>Shopping Cart</h2>
        <%!
            //Retrieve item details from cart database
            Cart cart = new Cart();
            Item item = new Item();
        %>

        <%
            cart = cart.generateCart();

            //Cart section header
            if (cart.getCartItems().size() == 0) {
                out.println("<div style=\"justify-content: center\" id=\"empty-cart-msg\">"
                        + "<h3>Cart is empty</h3>"
                        + "</div>");
            } else {
                out.println("<table>"
                        + "<th>Item</th>"
                        + "<th>Quantity</th>"
                        + "<th>Unit Price (RM)</th>"
                        + "<th>Total Price (RM)</th>");
            }

            for (int i = 0; i < cart.getCartItems().size(); i++) {
                out.println("<tr>"
                        + "<td>" + cart.getCartItems().get(i).getName() + "</td>"
                        + "<td>" + cart.getCartItems().get(i).getQuantity() + "</td>"
                        + "<td>" + String.format("%.2f", cart.getCartItems().get(i).getPrice()) + "</td>"
                        + "<td>" + String.format("%.2f", (cart.getCartItems().get(i).getPrice() * cart.getCartItems().get(i).getQuantity())) + "</td>"
                        + "<form action=\"EditCartItemQuantityServlet\" method=\"post\"/>"
                        + "<td class=\"hidden\"><input type=\"hidden\" name=\"itemId\" value=\"" + cart.getCartItems().get(i).getID() + "\"/></td>"
                        + "<td class=\"input-num\"><input type=\"number\" name=\"editQty\" value=\"1\" min=\"1\" max=\"" + item.retrieveStockFromRecord(cart.getCartItems().get(i).getID()) + "\"/></td>"
                        + "<td class=\"input-sub\"><input type=\"submit\" value=\"Change Quantity\"/></td>"
                        + "</form>"
                        + "<form action=\"DeleteCartItemServlet\" method=\"post\"/>"
                        + "<td class=\"hidden\"><input type=\"hidden\" name=\"itemId\" value=\"" + cart.getCartItems().get(i).getID() + "\"/></td>"
                        + "<td class=\"input-sub\"><input type=\"submit\" value=\"Delete\"/></td>"
                        + "</form>"
                        + "</tr>");
            }
        %>

        <footer>
            <div class="aligner">
                <h3 style="margin-left: 10px; margin-right: 10px">Subtotal</h3>
                    <%
                        double subtotal = 0;
                        for (int i = 0; i < cart.getCartItems().size(); i++) {
                            subtotal += (cart.getCartItems().get(i).getPrice() * cart.getCartItems().get(i).getQuantity());
                        }
                        out.println("<span style=\"align-content: center; margin-left: 10px; margin-right: 10px\">RM" + String.format("%.2f", subtotal) + "</span>");
                    %>
                    <a href="checkout/checkout.jsp" style="align-content: center"><button style="margin-left: 10px; margin-right: 10px">Checkout</button></a>
            </div>
        </footer>
    </div>
    </body>
</html>
