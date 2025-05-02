<%@page import="item.Item"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Product</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <%!
            Item item = new Item();
        %>
        <h2>Products</h2>
        <form action="AddToCartServlet" method="post">
            <input type="hidden" name="itemId" value="I002"/>
            <span>Item 1</span>
            <input class="quantity" type="number" name="quantity" value="1" min="1" max="<%= item.retrieveStockFromRecord("I002") %>"/>
            <input type="submit" value="Add to cart"/>
        </form>

        <form action="AddToCartServlet" method="post">
            <input type="hidden" name="itemId" value="I069"/>
            <span>Item 2</span>
            <input class="quantity" type="number" name="quantity" value="1" min="1" max="<%= item.retrieveStockFromRecord("I069") %>"/>
            <input type="submit" value="Add to cart"/>
        </form>

        <a checkout/cart.jsp><button>Cart</button></a>
        </div>
    </body>
</html>
