package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Serves the Platform Architecture diagram page.
 *
 * URL mappings:
 *   /arch         — standalone direct access.
 *                   Forwards to PlatformArchitecture.jsp, which renders
 *                   the outer shell + an <iframe src="/arch-diagram">.
 *
 *   /arch-diagram — iframe content endpoint.
 *                   Streams architecture-sketche.html directly from
 *                   WEB-INF/bot_viewer/.  Must NOT forward to
 *                   PlatformArchitecture.jsp — that would cause an
 *                   infinite loop (JSP → iframe → servlet → JSP → …).
 */
@WebServlet(name = "LoadArchitectureDiagram", urlPatterns = {"/arch", "/arch-diagram"})
public class LoadArchitectureDiagram extends HttpServlet {

    /** Path of the standalone HTML diagram inside WEB-INF. */
    private static final String HTML_PATH =
            "/WEB-INF/bot_viewer/architecture-sketche.html";

    /** Path of the JSP wrapper (used for /arch standalone access). */
    private static final String JSP_PATH =
            "/WEB-INF/bot_viewer/PlatformArchitecture.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uri = request.getRequestURI();   // e.g. /BOTGATEWAY/arch-diagram

        if (uri.endsWith("/arch-diagram")) {
            /*
             * ── /arch-diagram ─────────────────────────────────────────────
             * This URL is the iframe src set by PlatformArchitecture.jsp.
             * Stream architecture-sketche.html directly so the browser
             * renders it inside the iframe.
             *
             * Forwarding to PlatformArchitecture.jsp here would cause an
             * infinite loop because that JSP itself sets the iframe src
             * to /arch-diagram again.
             * ───────────────────────────────────────────────────────────── */
            streamHtmlDiagram(response);

        } else {
            /*
             * ── /arch ──────────────────────────────────────────────────────
             * Standalone direct access (no BotViewerTemplate wrapper).
             * Forward to PlatformArchitecture.jsp which renders the outer
             * shell (branding bar) plus the <iframe src="/arch-diagram">.
             * ───────────────────────────────────────────────────────────── */
            request.getRequestDispatcher(JSP_PATH).forward(request, response);
        }
    }

    /**
     * Streams architecture-sketche.html to the response as text/html.
     * The file lives in WEB-INF so it cannot be accessed by the browser
     * directly — this method is the only public gateway to it.
     */
    private void streamHtmlDiagram(HttpServletResponse response)
            throws IOException {

        InputStream in = getServletContext().getResourceAsStream(HTML_PATH);

        if (in == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "Architecture diagram not found: " + HTML_PATH);
            return;
        }

        response.setContentType("text/html;charset=UTF-8");

        try (InputStream src = in;
             OutputStream out = response.getOutputStream()) {

            byte[] buf = new byte[8192];
            int bytesRead;
            while ((bytesRead = src.read(buf)) != -1) {
                out.write(buf, 0, bytesRead);
            }
        }
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