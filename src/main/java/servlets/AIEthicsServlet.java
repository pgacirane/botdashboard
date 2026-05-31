package servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

/*
 * AIEthicsServlet.java
 * NO @WebServlet annotation — web.xml handles the mapping.
 * Having both causes: "servlets named [AIEthics] and [servlets.AIEthicsServlet]
 * are both mapped to [/AIEthics] which is not permitted"
 */
public class AIEthicsServlet extends HttpServlet {

    private static final String JSP_PATH = "/WEB-INF/bot_viewer/AIEthics.jsp";

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
        response.sendRedirect(request.getContextPath() + "/AIEthics");
    }
}