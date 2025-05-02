package user;

import da.AdminDA;
import da.StaffDA;
import domain.User;
import da.UserDA;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.logging.Level;
import java.util.logging.Logger;

public class getUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        UserDA userDA = new UserDA();
        AdminDA adminDA = new AdminDA();
        StaffDA staffDA = new StaffDA();
        
        try {
            // Fetch user by ID from the database
            User editUser = userDA.retrieveRecord(id);
            if (adminDA.retrieveRecord(id).getId() != 0) {editUser.setPermission("Admin");}
            else if (staffDA.retrieveRecord(id).getId() != 0) {editUser.setPermission("Staff");}
            else {editUser.setPermission("User");}
            
            if (editUser != null) {
                request.setAttribute("editUser", editUser);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/editUser.jsp");
                dispatcher.forward(request, response); 
            } else {
                request.setAttribute("error", "User not found.");
                response.sendRedirect("viewUserServlet"); 
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while fetching user data.");
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
        }
    }
}