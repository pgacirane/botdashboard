package servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

/*
 * SocialImpactServlet.java
 * NO @WebServlet annotation — web.xml handles the mapping.
 */
public class SocialImpactServlet extends HttpServlet {

    private static final String JSP_PATH = "/WEB-INF/bot_viewer/SocialImpactAssessment.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma",        "no-cache");
        response.setDateHeader("Expires",   0);
        RequestDispatcher dispatcher = request.getRequestDispatcher(JSP_PATH);
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/SocialImpact");
    }
}