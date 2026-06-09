/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
@WebServlet("/sitemap.xml")
public class SitemapServlet extends HttpServlet {

    private static final String BASE = "https://www.myportofolio.aionifier.ai";

    private static final List<String> PAGES = List.of(
        "/chat",
        "/BotViewer?bot=legal",
        "/BotViewer?bot=bank",
        "/BotViewer?bot=grad",
        "/BotViewer?bot=cv",
        "/BotViewer?bot=arch",
        "/BotViewer?bot=sia",
        "/BotViewer?bot=ethics",
        "/BotViewer?bot=etymology",
        "/Hire"
    );

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        res.setContentType("application/xml");
        res.setCharacterEncoding("UTF-8");

        String today = java.time.LocalDate.now().toString();
        PrintWriter out = res.getWriter();

        out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        out.println("<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">");

        for (String page : PAGES) {
            out.println("  <url>");
            out.println("    <loc>" + BASE + page + "</loc>");
            out.println("    <lastmod>" + today + "</lastmod>");
            out.println("    <changefreq>monthly</changefreq>");
            out.println("    <priority>" + (page.equals("/chat") ? "1.0" : "0.8") + "</priority>");
            out.println("  </url>");
        }

        out.println("</urlset>");
    }
}