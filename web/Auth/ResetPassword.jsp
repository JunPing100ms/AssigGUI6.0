<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
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

            .input {
                width: 100%;
                height: 45px;
                line-height: 30px;
                padding: 0 5rem;
                padding-left: 3rem;
                border: 2px solid transparent;
                border-radius: 5px;
                outline: none;
                background-color: #f8fafc;
                color: #000;
                transition: .5s ease;
            }

            .form-control {
                position: relative;
                margin: 20px 20px 20px;
                width: 300px;
            }

            .form-control input {
                background-color: transparent;
                border: 0;
                border-bottom: 2px #000 solid;
                display: block;
                width: 100%;
                padding: 15px 0;
                font-size: 18px;
                color: #fff;
            }

            .form-control input:focus,
            .form-control input:valid {
                outline: 0;
                color: #000;
                border-bottom-color: black;
            }

            .form-control label {
                position: absolute;
                top: 15px;
                left: 0;
                pointer-events: none;
            }

            .form-control label span {
                display: inline-block;
                font-size: 18px;
                min-width: 5px;
                color: #000;
                transition: 0.3s cubic-bezier (0.68, -0.55, 0.265, 1.55);
            }

            .form-control input:focus+label span,
            .form-control input:valid+label span {
                color: #3D3D3D;

                transform: translateY(-30px);
            }

            .button-newpassword {
                --bg-color: beige;
                --main-color: black;
                margin: 50px 50px 0 auto;
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
            .button-newpassword:active {
                box-shadow: 0px 0px var(--main-color);
                transform: translate(3px, 3px);
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
            <a href="home.jsp"><img src="Images/logohorizon.png" height="90" width ="230" alt="alt" style="padding:0;
                                    margin:0;"/></a>
            <a href="home.jsp">Home</a>
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
            <h3>Reset Password</h3>
            <form method="post" action="ResetPasswordServlet">
                <table>
                    <tr>
                        <td>
                            <div class="form-control">
                                <input type="text" id="lemail" name="email" maxlength="30" value="${email}" required>
                                <label>
                                    <span style="transition-delay:0ms">E</span> 
                                    <span style="transition-delay:50ms">m</span>
                                    <span style="transition-delay:100ms">a</span>
                                    <span style="transition-delay:150ms">i</span>
                                    <span style="transition-delay:200ms">l</span>
                                </label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-control">
                                <input type="password" id="lpwd1" name="password1" maxlength="20" value="${pwd1}" required>
                                <label>
                                    <span style="transition-delay:0ms">P</span> 
                                    <span style="transition-delay:50ms">a</span>
                                    <span style="transition-delay:100ms">s</span>
                                    <span style="transition-delay:150ms">s</span>
                                    <span style="transition-delay:200ms">w</span>
                                    <span style="transition-delay:250ms">o</span>
                                    <span style="transition-delay:300ms">r</span>
                                    <span style="transition-delay:350ms">d</span>
                                </label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-control">
                                <input type="password" id="lpwd2" name="password2" maxlength="20" value="${pwd2}" required>
                                <label>
                                    <span style="transition-delay:0ms">C</span> 
                                    <span style="transition-delay:50ms">o</span>
                                    <span style="transition-delay:100ms">n</span>
                                    <span style="transition-delay:150ms">f</span>
                                    <span style="transition-delay:200ms">i</span>
                                    <span style="transition-delay:250ms">r</span>
                                    <span style="transition-delay:300ms">m</span>
                                    <span style="transition-delay:350ms"></span>
                                    <span style="transition-delay:400ms">P</span>
                                    <span style="transition-delay:450ms">a</span>
                                    <span style="transition-delay:500ms">s</span>
                                    <span style="transition-delay:550ms">s</span>
                                    <span style="transition-delay:600ms">w</span>
                                    <span style="transition-delay:650ms">o</span>
                                    <span style="transition-delay:700ms">r</span>
                                    <span style="transition-delay:750ms">d</span>
                                </label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <small style="color:red">
                                ${error}
                            </small>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button type="submit" class="button-newpassword">Submit new password</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>
