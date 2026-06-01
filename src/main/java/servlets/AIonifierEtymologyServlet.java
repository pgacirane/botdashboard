package servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

/*
 * AIonifierEtymologyServlet.java
 * Handles GET /Etymology
 * Forwards to /WEB-INF/bot_viewer/AIonifierEtymology.jsp
 * NO @WebServlet annotation — web.xml handles the mapping exclusively.
 */
public class AIonifierEtymologyServlet extends HttpServlet {

    private static final String JSP_PATH = "/WEB-INF/bot_viewer/AIonifierEtymology.jsp";

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
        response.sendRedirect(request.getContextPath() + "/Etymology");
    }
}