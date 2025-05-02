package user;

import domain.*;
import da.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

public class viewPaymentServlet extends HttpServlet {

    private UserDA usDA;
    
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userID = request.getParameter("userID"); // e.g., U001

        try {
            PaymentDA paymentDA = new PaymentDA();
            List<Payment> payments = paymentDA.getUserPayment(userID);
            request.setAttribute("paymentList", payments);
            
            String updated = request.getParameter("updated");
            if ("true".equals(updated)) {
                request.setAttribute("paymentUpdated", true);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load payments.");
        }
    RequestDispatcher rd = request.getRequestDispatcher("viewUserPayment.jsp");
    rd.forward(request, response);    }

}
