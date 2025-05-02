package staff;

import da.StaffDA;
import da.UserDA;
import domain.Staff;
import domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

public class viewStaffServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            UserDA userDA = new UserDA();
            StaffDA staffDA = new StaffDA();
            List<User> userList = userDA.getAllRecords();
            List<Staff> staffList = staffDA.getAllRecords();
            List<User> staffUserList = new ArrayList<>();

            // Loop through each user and staff to find matches
            for (User user : userList) {
                for (Staff staff : staffList) {
                    if (user.getPermission().equals(staff.getPermission_key()) && user.getId().equals(staff.getUser_id())) {
                        staffUserList.add(user);
                    }
                }
            }
            request.setAttribute("allUsers", staffUserList);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Unable to load staff.");
        }

        // forward to JSP
        request.setAttribute("userRole", "Staff");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/viewUser.jsp");
        dispatcher.forward(request, response);
    }
}