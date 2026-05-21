package servlets;



import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "/ChatServlet", urlPatterns = {"/chat"})
public class ChatServlet extends HttpServlet {

    /**
     * Handles the HTTP GET request.
     * Displays the login page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to the login JSP located in the protected WEB-INF folder
        request.getRequestDispatcher("/WEB-INF/dashboard_viewer/AibBotsDashboard.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP POST request.
     * Validates credentials and redirects based on user role.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //String email = request.getParameter("email");
        //String password = request.getParameter("password");

       

        try {
           

            
                //response.sendRedirect(request.getContextPath() + "/CrewResponseStream");
///ok ok

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "This is a Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/home_page/AibBotsDashboard.jsp").forward(request, response);
        } 
    }
}