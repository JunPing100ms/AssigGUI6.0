<html>
    <head>
        <title>Add New Item</title>
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
            <h3>New Item Details</h3>
            <form method="post" action="addItemServlet">
                <p>ID: 
                    <input type="text" name="id" value="<%= request.getAttribute("id") != null ? request.getAttribute("id") : ""%>" />
                    <br>
                    <span style="color:red;">
                        <%= request.getAttribute("error") != null ? request.getAttribute("error") : ""%>
                    </span>
                </p>
                <p>Name: <input type="text" name="name" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : ""%>" /></p>
                <p>Category: 
                    <select name="category">
                        <option value="Badminton" <%= "Badminton".equals(request.getAttribute("category")) ? "selected" : ""%>>Badminton</option>
                        <option value="Table Tennis" <%= "Table Tennis".equals(request.getAttribute("category")) ? "selected" : ""%>>Table Tennis</option>
                        <option value="General" <%= "General".equals(request.getAttribute("category")) ? "selected" : ""%>>General</option>
                    </select>
                </p>
                <p>Price: <input type="text" name="price" value="<%= request.getAttribute("price") != null ? request.getAttribute("price") : ""%>" /></p>
                <p>Stock: <input type="text" name="stock" value="<%= request.getAttribute("stock") != null ? request.getAttribute("stock") : ""%>" /></p>
                <input type="submit" value="Add Item">
            </form>

            <a href="viewItem">Return</a><br>
        </div>
    </body>
</html>
