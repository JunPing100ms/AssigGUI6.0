package Auth;

import da.UserDA;
import domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class editPersonalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // Temporary solution for testing
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String hbd = request.getParameter("bd");
        String password = request.getParameter("password1");
        String confirmPassword = request.getParameter("password2");
        // check if variable enter is correct
        String error = "";
        boolean hasError = false;

        UserDA userDA = new UserDA();
        User userOLD = userDA.retrieveRecord(id);

        // Validate email
        if (userDA.searchEmail(email)) {
            if (userOLD != null && email != null && !email.equals(userOLD.getEmail())) {
                error += "Email in use.<br>";
            }
        } else if (!email.matches("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}")) {
            error += "Please enter a valid email address.<br>";
            hasError = true;
        }

        // Validate phone number (simple validation)
        if (userDA.searchPhone(phone)) {
            if (userOLD != null && phone != null && !phone.equals(userOLD.getPhone())) {
                error += "Email in use.<br>";
            }
        } else if (!phone.matches("^\\+60\\d{9,10}$")) {
            error += "Please enter a valid phone number (+601212341234).<br>";
            hasError = true;
        }
        // Validate password 
        if (confirmPassword == null) {
            System.out.println("NOT MATCH");
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
        }
        if (hasError) {
            System.out.println("HERE1");
            request.setAttribute("id", id);
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("bd", hbd);
            request.setAttribute("password1", password);
            request.setAttribute("password2", confirmPassword);
            request.getRequestDispatcher("../Auth/viewPersonalInfo.jsp").forward(request, response);
        }
        System.out.println("HERE2");

        User userNew = new User(id, name, email, phone, hbd, password);
        userNew.setPermission(userOLD.getPermission());
        userDA.updateProfileRecord(userNew);
        response.sendRedirect("ProfileServlet");
    }

}
