package Auth;

import da.UserDA;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class deletePersonalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // Temporary solution for testing
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        UserDA userDA = new UserDA();
        try {
            System.out.println("HERE DELETE");
            userDA.deleteProfileRecord(id);
            response.sendRedirect("SignoutServlet");
        } catch (Exception ex ) {
        
        }
    }

}
