package Auth;

import domain.User;
import da.UserDA;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("RESET PASSWORD");
        String email = request.getParameter("email");
        String password = request.getParameter("password1");
        String confirmPassword = request.getParameter("password2");
        String error = "";
        boolean hasError = false;
        
        UserDA userDA = new UserDA();
        // Validate email
        if (userDA.searchEmail(email)) {
            if (email != null) {
                error += "Email in use.<br>";
            }
        } else if (!email.matches("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}")) {
            error += "Please enter a valid email address.<br>";
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
            request.setAttribute("email",email);
            request.setAttribute("error",error);
            request.setAttribute("password", password);
            request.setAttribute("password1", confirmPassword);
            request.getRequestDispatcher("ResetPassword.jsp").forward(request, response);
        } else {
            
            User user = userDA.retrieveRecordEmail(email);
            user.setBlock(false);
            user.setFailCount(0);
            User userPassword = new User("","","","","",password);
            user.setPwd(userPassword.getPwd());
            System.out.println("Name: " + user.getName());
            System.out.println("Date: " + user.getHbd());
            userDA.updateProfileRecord(user);
            
            response.sendRedirect("Login.jsp");
            
        }
    }
}
