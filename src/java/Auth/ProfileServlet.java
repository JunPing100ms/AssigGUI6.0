package Auth;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String userName = null;
        String userId = null;
        String userPermission = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                switch (cookie.getName()) {
                    case "userName":
                        userName = cookie.getValue();
                        break;
                    case "userId":
                        userId = cookie.getValue();
                        break;
                    case "userPermission":
                        userPermission = cookie.getValue();
                        break;
                }
            }
        }
        if(userName == null || userId == null) {
            response.sendRedirect("Login.jsp");
        } 
        
        request.setAttribute("userName", userName);
        request.setAttribute("userId", userId);
        
        request.setAttribute("isAdmin", "Admin".equals(userPermission));
        request.setAttribute("isStaff", "Staff".equals(userPermission));
        
        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }

}
