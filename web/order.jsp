<%@ page import="java.util.List" %>
<%@ page import="item.Item" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Items</title>
        <style>
            .item-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: center;
                padding: 20px;
            }

            .item-card {
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 15px;
                width: 250px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                background-color: #f9f9f9;
            }

            .item-card h3 {
                margin-top: 0;
                color: #333;
            }

            .item-card p {
                margin: 5px 0;
                color: #555;
            }
        </style><link rel="stylesheet" href="styles.css" />
    </head>
    <body>
        <div id="navbar">
            <div>
            </div>

            <div class="search-container">
                <form action="SearchItemServlet" method="get" style="text-align:center; margin-bottom:20px;">
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
            <h2 style="text-align:center;">Order Items</h2>

            <div class="item-container">
                <%
                    List<Item> itemList = (List<Item>) request.getAttribute("allItems");
                    if (itemList != null && !itemList.isEmpty()) {
                        for (Item it : itemList) {
                %>
                <div class="item-card">
                    <h3><%= it.getName()%></h3>
                    <p><strong>ID:</strong> <%= it.getID()%></p>
                    <p><strong>Category:</strong> <%= it.getCategory()%></p>
                    <p><strong>Price:</strong> RM <%= it.getPrice()%></p>
                    <p><strong>Stock:</strong> <%= it.getStock()%></p>

                    <p><label>Amount</label>
                        <input type="text" name="amt" size="1" /></p>

                    <p><input type="submit" value="Add to cart" />
                        <input type="reset" value="Reset" /></p>
                </div>
                <%
                    }
                } else {
                %>
                <p style="text-align:center;">No items found.</p>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>
