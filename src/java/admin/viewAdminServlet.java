package admin;

import da.AdminDA;
import da.UserDA;
import domain.Admin;
import domain.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

public class viewAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            UserDA userDA = new UserDA();
            AdminDA adminDA = new AdminDA();
            List<User> userList = userDA.getAllRecords();
            List<Admin> adminList = adminDA.getAllRecords();
            List<User> adminUserList = new ArrayList<>();

            // Loop through each user and staff to find matches
            for (User user : userList) {
                for (Admin admin : adminList) {
                    if (user.getPermission().equals(admin.getPermission_key()) && user.getId().equals(admin.getUser_id())) {
                        adminUserList.add(user);
                    }
                }
            }
            request.setAttribute("allUsers", adminUserList);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Unable to load admin.");
        }

        // forward to JSP
        request.setAttribute("userRole", "Admin");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/viewUser.jsp");
        dispatcher.forward(request, response);
    }
}