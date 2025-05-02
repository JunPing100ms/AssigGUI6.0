package item;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

public class itemOrderServlet extends HttpServlet {

    private ItemDA itDA;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //List<Item> itemList = new ArrayList<>();
        try {
            ItemDA itDA = new ItemDA(); // initialize DAO
            List<Item> itemList = itDA.getAllRecord(); // get all records
            request.setAttribute("allItems", itemList); // set attribute
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Unable to load items.");
        }

        // forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/products.jsp");
        dispatcher.forward(request, response);
    }

}
