package servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * HireServlet — forwards GET /Hire to WEB-INF/dashboard_viewer/Hire.jsp.
 *
 * Registration: web.xml ONLY (see web.xml entry below).
 * NO @WebServlet annotation — dual registration crashes Tomcat.
 *
 * web.xml entry to add:
 * ──────────────────────────────────────────────────
 * <servlet>
 *     <servlet-name>HireServlet</servlet-name>
 *     <servlet-class>servlets.HireServlet</servlet-class>
 * </servlet>
 * <servlet-mapping>
 *     <servlet-name>HireServlet</servlet-name>
 *     <url-pattern>/Hire</url-pattern>
 * </servlet-mapping>
 * ──────────────────────────────────────────────────
 */
public class HireServlet extends HttpServlet {

    private static final String JSP_PATH = "/WEB-INF/bot_viewer/Hire.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(JSP_PATH).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(request.getContextPath() + "/Hire");
    }
}