package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Serves the Platform Architecture diagram page.
 *
 * URL mappings:
 *   /arch          — standalone direct access (full page with its own header)
 *   /arch-diagram  — used by BotViewerTemplate as an iframe src
 *                    (same JSP, but the BotViewerTemplate provides the outer nav)
 *
 * Both URLs forward to the same JSP.
 */
@WebServlet(name = "LoadArchitectureDiagram", urlPatterns = {"/arch", "/arch-diagram"})
public class LoadArchitectureDiagram extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the diagram JSP.
        // When called via /arch-diagram (from BotViewerTemplate iframe),
        // the JSP renders inside the iframe — no changes needed in the JSP itself.
        request.getRequestDispatcher(
            "/WEB-INF/bot_viewer/PlatformArchitecture.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Serves the Platform Architecture diagram page.";
    }
}