package servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

/**
 * BotViewerServlet.java
 * ─────────────────────────────────────────────────────────────────────────────
 * Handles GET requests to /BotViewer?bot=xxx
 *
 * This servlet has ONE job: forward to the placeholder JSP so that
 * BotViewerTemplate (Filter) can intercept the response and render
 * the full page (nav bar + bot strip + iframe).
 *
 * The actual bot URL resolution and iframe rendering is done entirely
 * by BotViewerTemplate.java — this servlet does not need to touch it.
 *
 * URL: /BotViewer?bot=legal | bank | grad | cv
 *
 * web.xml — remove the old <servlet>/<jsp-file> entry for BotViewer
 * and replace with this servlet declaration:
 *
 *   <servlet>
 *     <servlet-name>BotViewerServlet</servlet-name>
 *     <servlet-class>servlets.BotViewerServlet</servlet-class>
 *   </servlet>
 *   <servlet-mapping>
 *     <servlet-name>BotViewerServlet</servlet-name>
 *     <url-pattern>/BotViewer</url-pattern>
 *   </servlet-mapping>
 *
 * OR simply rely on the @WebServlet annotation below and remove
 * the servlet + servlet-mapping entries from web.xml entirely.
 * ─────────────────────────────────────────────────────────────────────────────
 */
@WebServlet(name = "BotViewerServlet", urlPatterns = {"/BotViewer"})
public class BotViewer extends HttpServlet {

    /**
     * GET /BotViewer?bot=bank
     *
     * Forwards to the placeholder JSP.
     * BotViewerTemplate intercepts before the response is written
     * and renders the full shell + iframe.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Validate the bot parameter — reject unknown values early
        String botKey = request.getParameter("bot");
        if (botKey == null || !botKey.matches("legal|bank|grad|cv|hiv|coreg")) {
            // Unknown bot — forward anyway; BotViewerTemplate will show
            // the empty-state placeholder instead of an iframe
        }

        // Forward to the placeholder JSP inside WEB-INF (not directly accessible)
        // BotViewerTemplate captures the (empty) JSP output and replaces it
        // with the full rendered page.
        request.getRequestDispatcher("/WEB-INF/bot_viewer/Botviewer.jsp")
               .forward(request, response);
    }

    /**
     * POST is not used — redirect to GET to avoid form re-submission issues.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/BotViewer");
    }
}