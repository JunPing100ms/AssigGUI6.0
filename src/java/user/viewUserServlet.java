package user;

import da.UserDA;
import domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

public class viewUserServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            UserDA userDA = new UserDA(); // initialize DAO
            List<User> userList = userDA.getAllRecords(); // get all records
            request.setAttribute("allUsers", userList); // set attribute
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Unable to load user.");
        }

        // forward to JSP
        request.setAttribute("userRole", "User");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/viewUser.jsp");
        dispatcher.forward(request, response);

    }

}