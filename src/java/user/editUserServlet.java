package user;

import Auth.AESEncryptor;
import da.AdminDA;
import da.StaffDA;
import domain.User;
import da.UserDA;
import domain.Admin;
import domain.Staff;

import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class editUserServlet extends HttpServlet {

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
        String permission = request.getParameter("permission");
        
        // check if variable enter is correct
        String error = "";
        boolean hasError = false;

        UserDA userDA = new UserDA();
        User userOLD = userDA.retrieveRecord(id);
        System.out.println("UID: "+ userOLD.getId());
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
            User editUser = new User(id, name, email, phone, hbd, password, permission);
            request.setAttribute("editUser", editUser);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/editUser.jsp");
            dispatcher.forward(request, response);
        }
        // Construct User object
        User user = userDA.retrieveRecord(id);
        
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setHbd(hbd);
        AESEncryptor aes = new AESEncryptor();
        try {
            user.setPwd(aes.encrypt(password));
        } catch (Exception ex) {
            Logger.getLogger(editUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        //Check if permission change
        String permission_original;
        StaffDA staffDA = new StaffDA();
        AdminDA adminDA = new AdminDA();
        if (adminDA.retrieveRecord(id).getId() != 0) {
            permission_original = "Admin";
        } else if (staffDA.retrieveRecord(id).getId() != 0) {
            permission_original = "Staff";
        } else {
            permission_original = "User";
        }

        //update permission attribtue
        if (!permission_original.equals(permission)) {
            if (permission_original.equals("Admin")) {
                adminDA.deleteProfileRecord(id);
            }
            if (permission_original.equals("Staff")) {
                staffDA.deleteProfileRecord(id);
            }
            if (permission.equals("Admin")) {
                Admin admin = new Admin(id);
                adminDA.createRecord(admin);
                user.setPermission(admin.getPermission_key());
            }
            if (permission.equals("Staff")) {
                Staff staff = new Staff(id);
                staffDA.createRecord(staff);
                user.setPermission(staff.getPermission_key());

            }
        }

        // Update user
        userDA.updateProfileRecord(user);
        
        response.sendRedirect("viewUserServlet");
    }
}
