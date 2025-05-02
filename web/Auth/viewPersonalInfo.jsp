<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="domain.User" %>
<%@ page import="da.UserDA" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Add User</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
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

            .form-control input:read-only,
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

            .form-control input:read-only+label span,
            .form-control input:focus+label span,
            .form-control input:valid+label span {
                color: #3D3D3D;

                transform: translateY(-30px);
            }
            .button-return,
            .button-update {
                display: flex;
                justify-content: center;
                gap: 10px;
                --bg-color: beige;
                --main-color: black;
                margin: auto 10px auto 10px;
                width: 180px;
                height: 40px;
                border-radius: 5px;
                border: 2px solid var(--main-color);
                background-color: var(--bg-color);
                box-shadow: 4px 4px var(--main-color);
                font-size: 17px;
                font-weight: 600;
                color: var(--font-color);
                cursor: pointer;
                line-height: 2.0;
            }
            .button-update:active,
            .button-return:active {
                box-shadow: 0px 0px var(--main-color);
                transform: translate(3px, 3px);
            }
            a.button-return {
                text-decoration: none;
                text-align: center;
                line-height: 2.5;
            }
            .radio-container {
                margin: 0 auto;
                max-width: 300px;
                color: black;
            }

            .radio-wrapper {
                margin-bottom: 20px;
            }

            .radio-button {
                display: flex;
                align-items: center;
                cursor: pointer;
                transition: all 0.2s ease-in-out;
            }

            .radio-button:hover {
                transform: translateY(-2px);
            }

            .radio-button input[type="radio"] {
                display: none;
            }

            .radio-checkmark {
                display: inline-block;
                position: relative;
                width: 16px;
                height: 16px;
                margin-right: 10px;
                border: 2px solid #333;
                border-radius: 50%;
            }

            .radio-checkmark:before {
                content: "";
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%) scale(0);
                width: 8px;
                height: 8px;
                border-radius: 50%;
                background-color: #333;
                transition: all 0.2s ease-in-out;
            }

            .radio-button input[type="radio"]:checked ~ .radio-checkmark:before {
                transform: translate(-50%, -50%) scale(1);
            }

            .radio-label {
                font-size: 16px;
                font-weight: 600;
            }
        </style>
    </head>
    <body>

        <a class="button-return" href="../Auth/ProfileServlet">Return</a>
        <h2>Personal Info</h2>
        <form action="../Auth/editPersonalServlet" method="post">
            <table>
                <tr>
                    <td>
                        <div class="form-control">
                            <input type="text" id="lid" name="id" maxlength="20" value="${id}" readonly>
                            <label>
                                <span style="transition-delay:0ms">I</span>
                                <span style="transition-delay:50ms">D</span>
                            </label>
                        </div>
                    </td>
                    <td>
                        <div class="form-control">
                            <input type="text" id="lname" name="name" maxlength="100" value="${name}" required>
                            <label>
                                <span style="transition-delay:0ms">N</span> 
                                <span style="transition-delay:50ms">a</span>
                                <span style="transition-delay:100ms">m</span>
                                <span style="transition-delay:150ms">e</span>
                            </label>
                        </div>
                    </td>
                    <td>
                        <div class="form-control">
                            <input type="date" id="lbd" name="bd" value="${bd}" required>
                            <label>
                                <span style="transition-delay:0ms">B</span> 
                                <span style="transition-delay:50ms">i</span>
                                <span style="transition-delay:100ms">r</span>
                                <span style="transition-delay:150ms">t</span>
                                <span style="transition-delay:200ms">h</span>
                                <span style="transition-delay:250ms"></span>
                                <span style="transition-delay:300ms">D</span>
                                <span style="transition-delay:350ms">a</span>
                                <span style="transition-delay:400ms">t</span>
                                <span style="transition-delay:450ms">e</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-control">
                            <input type="text" id="lemail" name="email" maxlength="100" value="${email}" required>
                            <label>
                                <span style="transition-delay:0ms">E</span> 
                                <span style="transition-delay:50ms">m</span>
                                <span style="transition-delay:100ms">a</span>
                                <span style="transition-delay:150ms">i</span>
                                <span style="transition-delay:150ms">l</span>
                            </label>
                        </div>
                    </td>
                    <td>
                        <div class="form-control">
                            <input type="text" id="lphone" name="phone" maxlength="20" value="${phone}" required>
                            <label>
                                <span style="transition-delay:0ms">P</span> 
                                <span style="transition-delay:50ms">h</span>
                                <span style="transition-delay:100ms">o</span>
                                <span style="transition-delay:150ms">n</span>
                                <span style="transition-delay:200ms">e</span>
                                <span style="transition-delay:250ms"></span>
                                <span style="transition-delay:300ms">N</span>
                                <span style="transition-delay:350ms">u</span>
                                <span style="transition-delay:400ms">m</span>
                                <span style="transition-delay:450ms">b</span>
                                <span style="transition-delay:500ms">e</span>
                                <span style="transition-delay:550ms">r</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-control">
                            <input type="text" id="lpwd1" name="password1" maxlength="30" value="${pwd}" required>
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
                    <td>
                        <div class="form-control">
                            <input type="text" id="lpwd2" name="password2" maxlength="30" value="">
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
                        <button type="submit" class="button-update">Edit Profile</button>
                    </td>
                    <td>

                    </td>
                </tr>
            </table>
        </form>
        <form action="deletePersonalServlet" method="post">
            <button type="submit" class="button-update">Delete Profile</button>
        </form>
        <p style="color:red;">${error}</p>

    </body>
</html>