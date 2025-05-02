package Auth;

import domain.User;
import da.UserDA;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String username = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String bd = request.getParameter("bd");
        String password = request.getParameter("password1");
        String confirmPassword = request.getParameter("password2");

        String error = "";
        boolean hasError = false;

        UserDA userDA = new UserDA();
        User user = userDA.retrieveRecord(id);

        // Validate ID
        if (userDA.searchId(id)) {
            error += "Repeated ID.<br>";
            hasError = true;
        }

        // Validate email
        if (userDA.searchEmail(email)) {
            error += "Email in use.<br>";
        } else if (!email.matches("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}")) {
            error += "Please enter a valid email address.<br>";
            hasError = true;
        }

        // Validate phone number (simple validation)
        if (userDA.searchPhone(phone)) {
            error += "Email in use.<br>";
        } else if (!phone.matches("^\\+60\\d{9,10}$")) {
            error += "Please enter a valid phone number (+601212341234).<br>";
            hasError = true;
        }

        // Validate password 
        if (password.length() < 8 || !password.matches(".*[0-9].*") || !password.matches(".*[A-Z].*") || !password.matches(".*[a-z].*")) {
            error += "Password is not secure.<br>";
            hasError = true;
            if (!password.matches(".*[A-Z].*")) {
                error += " - at least 9 characters.<br>";
            }
            if (!password.matches(".*[0-9].*")) {
                error += " - at least one number.<br>";
            }
            if (!password.matches(".*[A-Z].*")) {
                error += " - at least one uppercase letter (A-Z).<br>";
            }
            if (!password.matches(".*[a-z].*")) {
                error += " - at least one lowercase letter (a-z).<br>";
            }
        } else {
            // Validate password match
            if (!password.equals(confirmPassword)) {
                error += "Passwords do not match.<br>";
                hasError = true;
            }
        }

        if (hasError) {
            // Go back to page
            request.setAttribute("error", error);
            request.setAttribute("id", id);
            request.setAttribute("name", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("bd", bd);
            request.setAttribute("pwd1", password);
            request.setAttribute("pwd2", confirmPassword);

            request.getRequestDispatcher("SignupServlet").forward(request, response);
        }
        //Store sql, store cookie, and go to profile page
        user = new User(id, username, email, phone, bd, password);
        userDA.createRecord(user);
        response.sendRedirect("Login.jsp");
    }
}
