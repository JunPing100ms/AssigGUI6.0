package user;

import domain.User;
import da.UserDA;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Cookie;

public class deleteUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        //obtain the parameter value from the html form
        String id = request.getParameter("id");
        
        try {
            UserDA usDA = new UserDA();
            usDA.deleteProfileRecord(id);
            out.println("<script type='text/javascript'>");
            out.println("alert('User \"" + id + "\" has been deleted successfully.');");
            out.println("window.location.href = 'viewUserServlet';");
            out.println("</script>");
        } catch (Exception ex) {
            out.println(ex);
        }

        response.sendRedirect("/Assignment_Login/user/viewUserServlet");
    }
}
