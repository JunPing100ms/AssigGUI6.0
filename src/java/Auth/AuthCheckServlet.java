package Auth;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuthCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check for authentication cookies
        boolean isAuthenticated = checkAuthCookies(request);
        
        if (isAuthenticated) {
            response.sendRedirect("ProfileServlet");
        } else {
            response.sendRedirect("Login.jsp");
        }
    }
    
    private boolean checkAuthCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            boolean hasUserId = false;
            boolean hasUserName = false;
            
            for (Cookie cookie : cookies) {
                if ("userId".equals(cookie.getName()) && !cookie.getValue().isEmpty()) {
                    hasUserId = true;
                }
                if ("userName".equals(cookie.getName()) && !cookie.getValue().isEmpty()) {
                    hasUserName = true;
                }
            }
            return hasUserId && hasUserName;
        }
        return false;
    }
}
