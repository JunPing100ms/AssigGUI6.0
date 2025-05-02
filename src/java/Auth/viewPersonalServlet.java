package Auth;

import da.UserDA;
import domain.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class viewPersonalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cookie[] cookies = request.getCookies();
        String userId = null;
        String userPermission = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userId".equals(cookie.getName())) {
                    userId = cookie.getValue();
                } else if ("userPermission".equals(cookie.getName())) {
                    userPermission = cookie.getValue();
                }
            }
        }

        if (userId == null) {
            request.setAttribute("error", "User not logged in.");
            request.getRequestDispatcher("ProfileServlet").forward(request, response);
            return;
        }

        try {
            UserDA userDA = new UserDA();
            User user = userDA.retrieveRecord(userId);

            if (user == null) {
                request.setAttribute("error", "User not found.");
                request.getRequestDispatcher("ProfileServlet").forward(request, response);
                return;
            }

            request.setAttribute("id", userId);
            request.setAttribute("name", user.getName());
            request.setAttribute("email", user.getEmail());
            request.setAttribute("phone", user.getPhone());
            request.setAttribute("bd", user.getHbd());
            request.setAttribute("pwd", user.getPwd());
            request.getRequestDispatcher("../Auth/viewPersonalInfo.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("ProfileServlet").forward(request, response);
        }
    }
}
