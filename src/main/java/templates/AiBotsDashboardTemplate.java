package templates;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

/**
 * AiBotsDashboardTemplate.java
 * ─────────────────────────────────────────────────────────────────────────────
 * Servlet Filter that wraps AiBotsDashboard.jsp.
 * Responsibilities:
 *   1. Render the standard application nav bar
 *   2. Render the horizontal bot quick-links strip
 *      — pills route through /BotViewer?bot=xxx (no external links)
 *   3. Inject the JSP page output between header and footer
 * ─────────────────────────────────────────────────────────────────────────────
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

        // Capture JSP output
        CharResponseWrapper wrapper = new CharResponseWrapper(response);
        chain.doFilter(request, wrapper);

        PrintWriter out = response.getWriter();

        // ── HEADER ───────────────────────────────────────────────────────────
        String header =
            "<!DOCTYPE html>\n"
          + "<html lang=\"en\">\n"
          + "<head>\n"
          + "  <meta charset=\"UTF-8\">\n"
          + "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
          + "  <title>AI Suite | PagaDromeda</title>\n"
          + "  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n"
          + "  <link href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css\" rel=\"stylesheet\">\n"
          + "  <style>\n"

          // ── Base ──
          + "    html, body {\n"
          + "      height:100%; margin:0; padding:0; overflow:hidden;\n"
          + "      background-color:#06080f;\n"
          + "    }\n"
          + "    body {\n"
          + "      background-image:\n"
          + "        radial-gradient(ellipse at 15% 35%, rgba(88,28,180,0.09) 0%, transparent 52%),\n"
          + "        radial-gradient(ellipse at 82% 12%, rgba(29,78,216,0.07) 0%, transparent 46%),\n"
          + "        radial-gradient(ellipse at 55% 78%, rgba(6,182,212,0.05) 0%, transparent 44%),\n"
          + "        radial-gradient(ellipse at 70% 50%, rgba(109,40,217,0.06) 0%, transparent 38%),\n"
          + "        radial-gradient(ellipse at 30% 80%, rgba(16,185,129,0.04) 0%, transparent 35%);\n"
          + "    }\n"

          // ── Galaxy canvas ──
          + "    #galaxy-canvas {\n"
          + "      position:fixed; top:0; left:0; width:100%; height:100%;\n"
          + "      pointer-events:none; z-index:0;\n"
          + "    }\n"

          + "    #page-wrapper { height:100%; display:flex; flex-direction:column; position:relative; z-index:1; }\n"

          // ── Nav bar ──
          + "    .header {\n"
          + "      background:#0d6efd; color:white;\n"
          + "      display:flex; justify-content:space-between; align-items:center;\n"
          + "      padding:10px 20px; flex-shrink:0;\n"
          + "    }\n"

          // ── Bot strip ──
          + "    .bot-strip {\n"
          + "      background:#0d1117;\n"
          + "      border-bottom:1px solid rgba(255,255,255,0.07);\n"
          + "      display:flex; align-items:center; gap:6px;\n"
          + "      padding:0 20px; height:46px; flex-shrink:0;\n"
          + "      overflow-x:auto; scrollbar-width:none;\n"
          + "    }\n"
          + "    .bot-strip::-webkit-scrollbar { display:none; }\n"
          + "    .strip-label {\n"
          + "      font-family:monospace; font-size:0.65rem; letter-spacing:0.18em;\n"
          + "      text-transform:uppercase; color:#374151;\n"
          + "      white-space:nowrap; margin-right:8px;\n"
          + "    }\n"

          // ── Pill base ──
          + "    .bot-pill {\n"
          + "      display:inline-flex; align-items:center; gap:6px;\n"
          + "      padding:5px 14px; border-radius:999px;\n"
          + "      font-size:0.76rem; font-weight:600;\n"
          + "      text-decoration:none; border:1px solid; white-space:nowrap;\n"
          + "      transition:background 0.2s, transform 0.18s;\n"
          + "    }\n"
          + "    .bot-pill:hover { transform:translateY(-1px); }\n"

          // ── Pill colours ──
          + "    .bot-pill.legal { color:#f59e0b; border-color:rgba(245,158,11,0.3);  background:rgba(245,158,11,0.07);  }\n"
          + "    .bot-pill.bank  { color:#22d3ee; border-color:rgba(34,211,238,0.3);  background:rgba(34,211,238,0.07);  }\n"
          + "    .bot-pill.grad  { color:#a78bfa; border-color:rgba(167,139,250,0.3); background:rgba(167,139,250,0.07); }\n"
          + "    .bot-pill.cv    { color:#fb923c; border-color:rgba(251,146,60,0.3);  background:rgba(251,146,60,0.07);  }\n"
          + "    .bot-pill.hiv   { color:#4ade80; border-color:rgba(74,222,128,0.3);  background:rgba(74,222,128,0.07);  }\n"
          + "    .bot-pill.arch  { color:#38bdf8; border-color:rgba(56,189,248,0.3);  background:rgba(56,189,248,0.07);  }\n"
          + "    .bot-pill.legal:hover { background:rgba(245,158,11,0.18); }\n"
          + "    .bot-pill.bank:hover  { background:rgba(34,211,238,0.18); }\n"
          + "    .bot-pill.grad:hover  { background:rgba(167,139,250,0.18); }\n"
          + "    .bot-pill.cv:hover    { background:rgba(251,146,60,0.18); }\n"
          + "    .bot-pill.hiv:hover   { background:rgba(74,222,128,0.18); }\n"
          + "    .bot-pill.arch:hover  { background:rgba(56,189,248,0.18); }\n"

          // ── Content + footer ──
          + "    .container-center { flex:1 1 auto; overflow:hidden; display:flex; }\n"
          + "    .content-wrapper  { background:transparent; width:100%; display:flex; flex-direction:column; overflow:hidden; }\n"
          + "    .content-scroll   { flex:1 1 auto; overflow-y:auto; padding:0; }\n"
          + "    .footer {\n"
          + "      background:#060a12; border-top:1px solid rgba(255,255,255,0.06);\n"
          + "      color:#4b5563; text-align:center; font-size:0.82rem;\n"
          + "      padding:10px 20px; flex-shrink:0;\n"
          + "    }\n"
          + "    .footer a { color:#6b7a99; text-decoration:none; }\n"
          + "  </style>\n"
          + "</head>\n"
          + "<body>\n"

          // ── Galaxy canvas ────────────────────────────────────────────────
          + "<canvas id=\"galaxy-canvas\"></canvas>\n"

          + "<div id=\"page-wrapper\">\n"

          // ── Nav bar ──────────────────────────────────────────────────────
          + "  <div class=\"header\">\n"
          + "    <div class=\"d-flex align-items-center gap-3\">\n"
          + "      <a href=\"" + ctx + "/Home\" class=\"text-white text-decoration-none fw-bold\">Public Procurement Companion</a>\n"
          + "      <span class=\"badge\" style=\"background:rgba(255,255,255,0.15);font-size:0.68rem;letter-spacing:0.08em;\">AI SUITE</span>\n"
          + "    </div>\n"
          + "    <div class=\"d-flex align-items-center gap-3\">\n"
          + "      <div class=\"dropdown\">\n"
          + "        <button class=\"btn btn-light dropdown-toggle\" type=\"button\" data-bs-toggle=\"dropdown\">&#8942;</button>\n"
          + "        <ul class=\"dropdown-menu dropdown-menu-end\">\n"
          + "          <li><a class=\"dropdown-item\" href=\"" + ctx + "/ViewQueries\">My Queries</a></li>\n"
          + "          <li><a class=\"dropdown-item\" href=\"" + ctx + "/SaveBill\">Upgrade Your Plan</a></li>\n"
          + "          <li><a class=\"dropdown-item\" href=\"" + ctx + "/ViewBills\">My Bills</a></li>\n"
          + "          <li><hr class=\"dropdown-divider\"></li>\n"
          + "          <li><a class=\"dropdown-item\" href=\"" + ctx + "/Logout\">Logout</a></li>\n"
          + "          <li><a class=\"dropdown-item text-danger\" href=\"" + ctx + "/Unregister\">Unregister</a></li>\n"
          + "        </ul>\n"
          + "      </div>\n"
          + "    </div>\n"
          + "  </div>\n"

          // ══════════════════════════════════════════════════════════════════
          // ── Bot strip — FIXED: all pills correct, arch pill added ─────────
          // ══════════════════════════════════════════════════════════════════
          + "  <div class=\"bot-strip\">\n"
          + "    <span class=\"strip-label\">AI Apps:</span>\n"

          + "    <a class=\"bot-pill legal\" href=\"" + ctx + "/BotViewer?bot=legal\">\n"
          + "      <i class=\"fas fa-scale-balanced\" style=\"font-size:0.72rem;\"></i> Global Legal Advisor\n"
          + "    </a>\n"

          + "    <a class=\"bot-pill bank\" href=\"" + ctx + "/BotViewer?bot=bank\">\n"
          + "      <i class=\"fas fa-building-columns\" style=\"font-size:0.72rem;\"></i> Bank CRM Advisor\n"
          + "    </a>\n"

          + "    <a class=\"bot-pill grad\" href=\"" + ctx + "/BotViewer?bot=grad\">\n"
          + "      <i class=\"fas fa-graduation-cap\" style=\"font-size:0.72rem;\"></i> Smart Grad\n"
          + "    </a>\n"

          // FIX: cv pill was missing its text label and closing tag was wrong
          + "    <a class=\"bot-pill cv\" href=\"" + ctx + "/BotViewer?bot=cv\">\n"
          + "      <i class=\"fas fa-id-card-clip\" style=\"font-size:0.72rem;\"></i> Talk to My CV\n"
          + "    </a>\n"

          // FIX: hiv pill had ctx as a literal string instead of being interpolated
          + "    <a class=\"bot-pill hiv\" href=\"" + ctx + "/BotViewer?bot=hiv\">\n"
          + "      <i class=\"fas fa-heart-pulse\" style=\"font-size:0.72rem;\"></i> HIV Guidelines\n"
          + "    </a>\n"

          // NEW: architecture pill — routes through BotViewer so the template wraps it
          + "    <a class=\"bot-pill arch\" href=\"" + ctx + "/BotViewer?bot=arch\">\n"
          + "      <i class=\"fas fa-sitemap\" style=\"font-size:0.72rem;\"></i> Architecture\n"
          + "    </a>\n"

          + "  </div>\n"
          // ══════════════════════════════════════════════════════════════════

          // ── Content area — JSP output injected here ──────────────────────
          + "  <div class=\"container-center\">\n"
          + "    <div class=\"content-wrapper\">\n"
          + "      <div class=\"content-scroll\">\n";

        // ── FOOTER ───────────────────────────────────────────────────────────
        String footer =
            "      </div>\n"
          + "    </div>\n"
          + "  </div>\n"
          + "  <div class=\"footer\">\n"
          + "    &copy; 2026 PagaDromeda &mdash; by Patrick &nbsp;|&nbsp;\n"
          + "    <a href=\"https://www.linkedin.com/in/patricus/\">Patrick</a>\n"
          + "  </div>\n"
          + "</div>\n"

          // ── Star field script ─────────────────────────────────────────────
          + "<script>\n"
          + "(function(){\n"
          + "  var c=document.getElementById('galaxy-canvas');\n"
          + "  var ctx=c.getContext('2d');\n"
          + "  c.width=window.innerWidth; c.height=window.innerHeight;\n"
          + "  var rng=(function(){var s=42;return function(){s=(s*16807+0)%2147483647;return(s-1)/2147483646;}})();\n"
          + "  for(var i=0;i<110;i++){\n"
          + "    var x=rng()*c.width, y=rng()*c.height;\n"
          + "    var r=rng()*0.75+0.15;\n"
          + "    var a=rng()*0.45+0.1;\n"
          + "    ctx.beginPath();\n"
          + "    ctx.arc(x,y,r,0,Math.PI*2);\n"
          + "    ctx.fillStyle='rgba(255,255,255,'+a.toFixed(2)+')';\n"
          + "    ctx.fill();\n"
          + "  }\n"
          + "  var tints=['rgba(200,210,255,','rgba(255,220,200,','rgba(180,240,255,'];\n"
          + "  for(var j=0;j<8;j++){\n"
          + "    var x=rng()*c.width, y=rng()*c.height;\n"
          + "    var r=rng()*1.2+0.6;\n"
          + "    var a=rng()*0.35+0.15;\n"
          + "    ctx.beginPath();\n"
          + "    ctx.arc(x,y,r,0,Math.PI*2);\n"
          + "    ctx.fillStyle=tints[j%3]+a.toFixed(2)+')';\n"
          + "    ctx.fill();\n"
          + "  }\n"
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

    // ── Response wrapper ─────────────────────────────────────────────────────
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