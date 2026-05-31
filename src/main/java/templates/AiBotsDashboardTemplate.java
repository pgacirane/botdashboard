package templates;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

/**
 * AiBotsDashboardTemplate.java
 * Minimal shell — no header bar, no nav strip.
 * JSP content renders directly inside the galaxy background.
 */
public class AiBotsDashboardTemplate implements Filter {

    @Override public void init(FilterConfig config) {}
    @Override public void destroy() {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws ServletException, IOException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String ctx = request.getContextPath();

        CharResponseWrapper wrapper = new CharResponseWrapper(response);
        chain.doFilter(request, wrapper);

        PrintWriter out = response.getWriter();

        String header =
            "<!DOCTYPE html>\n"
          + "<html lang=\"en\">\n"
          + "<head>\n"
          + "  <meta charset=\"UTF-8\">\n"
          + "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
          + "  <title>AI Suite | AIoniser</title>\n"
          + "  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n"
          + "  <link href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css\" rel=\"stylesheet\">\n"
          + "  <style>\n"
          + "    *, *::before, *::after { box-sizing:border-box; margin:0; padding:0; }\n"
          + "    html, body { height:100%; background-color:#06080f; }\n"
          + "    body {\n"
          + "      background-image:\n"
          + "        radial-gradient(ellipse at 15% 35%, rgba(88,28,180,0.09) 0%, transparent 52%),\n"
          + "        radial-gradient(ellipse at 82% 12%, rgba(29,78,216,0.07) 0%, transparent 46%),\n"
          + "        radial-gradient(ellipse at 55% 78%, rgba(6,182,212,0.05) 0%, transparent 44%),\n"
          + "        radial-gradient(ellipse at 70% 50%, rgba(109,40,217,0.06) 0%, transparent 38%),\n"
          + "        radial-gradient(ellipse at 30% 80%, rgba(16,185,129,0.04) 0%, transparent 35%);\n"
          + "    }\n"
          + "    #galaxy-canvas { position:fixed; top:0; left:0; width:100%; height:100%; pointer-events:none; z-index:0; }\n"
          + "    #page-wrapper  { height:100%; display:flex; flex-direction:column; position:relative; z-index:1; }\n"
          + "    .container-center { flex:1 1 auto; overflow:hidden; display:flex; }\n"
          + "    .content-wrapper  { background:transparent; width:100%; display:flex; flex-direction:column; overflow:hidden; }\n"
          + "    .content-scroll   { flex:1 1 auto; overflow-y:auto; padding:0; }\n"
          + "    .footer { background:#060a12; border-top:1px solid rgba(255,255,255,0.06); color:#4b5563; text-align:center; font-size:0.82rem; padding:10px 20px; flex-shrink:0; }\n"
          + "    .footer a { color:#6b7a99; text-decoration:none; }\n"
          + "  </style>\n"
          + "</head>\n"
          + "<body>\n"
          + "<canvas id=\"galaxy-canvas\"></canvas>\n"
          + "<div id=\"page-wrapper\">\n"
          + "  <div class=\"container-center\">\n"
          + "    <div class=\"content-wrapper\">\n"
          + "      <div class=\"content-scroll\">\n";

        String footer =
            "      </div>\n"
          + "    </div>\n"
          + "  </div>\n"
          + "  <div class=\"footer\">\n"
          + "    &copy; 2026 AIonifier &mdash; by Patrick &nbsp;|&nbsp;\n"
          + "    <a href=\"https://www.linkedin.com/in/patricus/\">Patrick</a>\n"
          + "  </div>\n"
          + "</div>\n"
          + "<script>\n"
          + "(function(){\n"
          + "  var c=document.getElementById('galaxy-canvas');\n"
          + "  var ctx=c.getContext('2d');\n"
          + "  c.width=window.innerWidth; c.height=window.innerHeight;\n"
          + "  var rng=(function(){var s=42;return function(){s=(s*16807+0)%2147483647;return(s-1)/2147483646;}})();\n"
          + "  for(var i=0;i<110;i++){var x=rng()*c.width,y=rng()*c.height,r=rng()*0.75+0.15,a=rng()*0.45+0.1;ctx.beginPath();ctx.arc(x,y,r,0,Math.PI*2);ctx.fillStyle='rgba(255,255,255,'+a.toFixed(2)+')';ctx.fill();}\n"
          + "  var tints=['rgba(200,210,255,','rgba(255,220,200,','rgba(180,240,255,'];\n"
          + "  for(var j=0;j<8;j++){var x=rng()*c.width,y=rng()*c.height,r=rng()*1.2+0.6,a=rng()*0.35+0.15;ctx.beginPath();ctx.arc(x,y,r,0,Math.PI*2);ctx.fillStyle=tints[j%3]+a.toFixed(2)+')';ctx.fill();}\n"
          + "})();\n"
          + "</script>\n"
          + "<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\n"
          + "</body>\n"
          + "</html>";

        out.println(header);
        out.println(wrapper.toString());
        out.println(footer);
        out.close();
    }

    private static class CharResponseWrapper extends HttpServletResponseWrapper {
        private final StringWriter output;
        private final PrintWriter  writer;
        public CharResponseWrapper(HttpServletResponse response) {
            super(response);
            output = new StringWriter();
            writer = new PrintWriter(output);
        }
        @Override public PrintWriter getWriter() { return writer; }
        @Override public String toString() { writer.flush(); return output.toString(); }
    }
}