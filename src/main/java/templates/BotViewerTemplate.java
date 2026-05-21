package templates;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import io.github.cdimascio.dotenv.Dotenv;

/**
 * BotViewerTemplate.java
 * ─────────────────────────────────────────────────────────────────────────────
 * Servlet Filter that renders the full bot viewer layout:
 *
 * ┌──────────────────────────────────────────────────────────┐
 * │ [logo] PagaDromeda ● HIV ● Legal ● Bank CRM ● Grad ● CV ● Architecture │
 * ├──────────────────────────────────────────────────────────┤
 * │   <iframe src="remote-bot-url OR local /arch-diagram" /> │
 * └──────────────────────────────────────────────────────────┘
 *
 * HOW TO SELECT A BOT — Pass a "bot" query parameter:
 *   /BotViewer?bot=legal  → Global Legal Advisor
 *   /BotViewer?bot=bank   → Bank CRM Advisor
 *   /BotViewer?bot=grad   → Smart Grad
 *   /BotViewer?bot=cv     → Talk to My CV
 *   /BotViewer?bot=hiv    → HIV Guidelines
 *   /BotViewer?bot=arch   → Platform Architecture diagram  ← NEW
 *
 * web.xml filter mapping (no changes needed):
 *   <url-pattern>/BotViewer</url-pattern>
 * ─────────────────────────────────────────────────────────────────────────────
 */
public class BotViewerTemplate implements Filter {

    // ── Resilient Environment Configuration ──────────────────────────────────
    private static final Dotenv dotenv;
    static {
        Dotenv tempDotenv = null;
        try {
            tempDotenv = Dotenv.configure()
                    .filename("/.env")
                    .ignoreIfMalformed()
                    .ignoreIfMissing()
                    .load();
        } catch (Exception e) {
            // Suppress initialization errors safely
        }
        dotenv = tempDotenv;
    }

    private static String getEnvVar(String key) {
        if (dotenv != null) {
            String value = dotenv.get(key);
            if (value != null && !value.trim().isEmpty()) {
                return value.trim();
            }
        }
        String systemVal = System.getenv(key);
        if (systemVal != null && !systemVal.trim().isEmpty()) {
            return systemVal.trim();
        }
        return System.getProperty(key, "");
    }

    // Remote bot URLs (loaded from .env / system environment)
    private static final String URL_LEGAL = getEnvVar("URL_LEGAL");
    private static final String URL_BANK  = getEnvVar("URL_BANK");
    private static final String URL_GRAD  = getEnvVar("URL_GRAD");
    private static final String URL_CV    = getEnvVar("URL_CV");
    private static final String URL_HIV   = getEnvVar("URL_HIV");
    // Architecture is a local servlet — no env var needed

    @Override
    public void init(FilterConfig config) {}

    @Override
    public void destroy() {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws ServletException, IOException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma",        "no-cache");
        response.setDateHeader("Expires",   0);

        String ctx = request.getContextPath();

        // ── Resolve bot key → URL ─────────────────────────────────────────────
        String botKey = request.getParameter("bot");
        if (botKey == null) botKey = "";

        String botUrl;
        switch (botKey.toLowerCase()) {
            case "legal":
                botUrl = URL_LEGAL;
                break;
            case "bank":
                botUrl = URL_BANK;
                break;
            case "grad":
                botUrl = URL_GRAD;
                break;
            case "cv":
                botUrl = URL_CV;
                break;
            case "hiv":
                botUrl = URL_HIV;
                break;
            // ── CHANGE 1: Architecture page served locally ────────────────────
            case "arch":
                botUrl = ctx + "/arch-diagram";
                break;
            // ─────────────────────────────────────────────────────────────────
            default:
                botUrl = "";
                break;
        }

        // Consume the downstream JSP (intentionally empty for this filter)
        CharResponseWrapper wrapper = new CharResponseWrapper(response);
        chain.doFilter(request, wrapper);

        // ── CHANGE 2: Active pill state variables (ka added for arch) ─────────
        String kl = botKey.equalsIgnoreCase("legal") ? " active" : "";
        String kb = botKey.equalsIgnoreCase("bank")  ? " active" : "";
        String kg = botKey.equalsIgnoreCase("grad")  ? " active" : "";
        String kc = botKey.equalsIgnoreCase("cv")    ? " active" : "";
        String kh = botKey.equalsIgnoreCase("hiv")   ? " active" : "";
        String ka = botKey.equalsIgnoreCase("arch")  ? " active" : "";
        // ─────────────────────────────────────────────────────────────────────

        // ── Iframe or empty-state block ───────────────────────────────────────
        String iframeBlock = botUrl.isEmpty()
                ? "    <div style=\"height:100%;display:flex;flex-direction:column;"
                + "align-items:center;justify-content:center;background:#0b0f1a;"
                + "color:#4b5563;font-family:monospace;gap:14px;\">\n"
                + "      <i class=\"fas fa-robot\" style=\"font-size:2.8rem;color:#1e293b;\"></i>\n"
                + "      <span style=\"font-size:0.88rem;\">No assistant selected.</span>\n"
                + "      <a href=\"" + ctx + "/chat\""
                + " style=\"font-size:0.8rem;color:#3b82f6;text-decoration:none;\">&#8592; Back to AI Suite</a>\n"
                + "    </div>\n"
                : "    <iframe id=\"bot-frame\"\n"
                + "      src=\"" + botUrl + "\"\n"
                + "      title=\"AI Assistant\"\n"
                + "      allow=\"microphone; clipboard-write\"\n"
                + "      sandbox=\"allow-scripts allow-same-origin allow-forms allow-popups\"\n"
                + "      style=\"width:100%;height:100%;border:none;display:block;\">\n"
                + "    </iframe>\n";

        // ── PagaDromeda inline SVG logo ───────────────────────────────────────
        String logo
                = "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 32 32\""
                + " width=\"26\" height=\"26\" fill=\"none\" aria-hidden=\"true\""
                + " style=\"flex-shrink:0;display:block;\">\n"
                + "  <defs>\n"
                + "    <radialGradient id=\"pg-core\" cx=\"50%\" cy=\"50%\" r=\"50%\">\n"
                + "      <stop offset=\"0%\"  stop-color=\"#60a5fa\"/>\n"
                + "      <stop offset=\"100%\" stop-color=\"#2563eb\"/>\n"
                + "    </radialGradient>\n"
                + "    <radialGradient id=\"pg-node\" cx=\"50%\" cy=\"50%\" r=\"50%\">\n"
                + "      <stop offset=\"0%\"  stop-color=\"#a5f3fc\"/>\n"
                + "      <stop offset=\"100%\" stop-color=\"#22d3ee\"/>\n"
                + "    </radialGradient>\n"
                + "    <filter id=\"pg-glow\" x=\"-40%\" y=\"-40%\" width=\"180%\" height=\"180%\">\n"
                + "      <feGaussianBlur stdDeviation=\"1.2\" result=\"blur\"/>\n"
                + "      <feMerge><feMergeNode in=\"blur\"/><feMergeNode in=\"SourceGraphic\"/></feMerge>\n"
                + "    </filter>\n"
                + "  </defs>\n"
                + "  <ellipse cx=\"16\" cy=\"16\" rx=\"13\" ry=\"5.5\""
                + " stroke=\"rgba(96,165,250,0.22)\" stroke-width=\"1\""
                + " transform=\"rotate(-30 16 16)\"/>\n"
                + "  <line x1=\"16\" y1=\"16\" x2=\"8\"  y2=\"9\"  stroke=\"rgba(34,211,238,0.35)\" stroke-width=\"0.9\"/>\n"
                + "  <line x1=\"16\" y1=\"16\" x2=\"24\" y2=\"9\"  stroke=\"rgba(34,211,238,0.35)\" stroke-width=\"0.9\"/>\n"
                + "  <line x1=\"16\" y1=\"16\" x2=\"26\" y2=\"19\" stroke=\"rgba(34,211,238,0.35)\" stroke-width=\"0.9\"/>\n"
                + "  <line x1=\"16\" y1=\"16\" x2=\"10\" y2=\"24\" stroke=\"rgba(34,211,238,0.35)\" stroke-width=\"0.9\"/>\n"
                + "  <line x1=\"16\" y1=\"16\" x2=\"22\" y2=\"25\" stroke=\"rgba(34,211,238,0.35)\" stroke-width=\"0.9\"/>\n"
                + "  <line x1=\"8\"  y1=\"9\"  x2=\"24\" y2=\"9\"  stroke=\"rgba(96,165,250,0.18)\" stroke-width=\"0.7\"/>\n"
                + "  <line x1=\"10\" y1=\"24\" x2=\"22\" y2=\"25\" stroke=\"rgba(96,165,250,0.18)\" stroke-width=\"0.7\"/>\n"
                + "  <line x1=\"24\" y1=\"9\"  x2=\"26\" y2=\"19\" stroke=\"rgba(96,165,250,0.18)\" stroke-width=\"0.7\"/>\n"
                + "  <circle cx=\"16\" cy=\"16\" r=\"4\" fill=\"url(#pg-core)\" filter=\"url(#pg-glow)\"/>\n"
                + "  <circle cx=\"8\"  cy=\"9\"  r=\"2\"   fill=\"url(#pg-node)\" opacity=\"0.9\"/>\n"
                + "  <circle cx=\"24\" cy=\"9\"  r=\"1.6\" fill=\"url(#pg-node)\" opacity=\"0.8\"/>\n"
                + "  <circle cx=\"26\" cy=\"19\" r=\"1.8\" fill=\"url(#pg-node)\" opacity=\"0.85\"/>\n"
                + "  <circle cx=\"10\" cy=\"24\" r=\"1.6\" fill=\"url(#pg-node)\" opacity=\"0.8\"/>\n"
                + "  <circle cx=\"22\" cy=\"25\" r=\"2\"   fill=\"url(#pg-node)\" opacity=\"0.9\"/>\n"
                + "  <circle cx=\"16\" cy=\"16\" r=\"1.2\" fill=\"#e0f2fe\" opacity=\"0.7\"/>\n"
                + "</svg>\n";

        PrintWriter out = response.getWriter();

        out.println(
                "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "<head>\n"
                + "  <meta charset=\"UTF-8\">\n"
                + "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                + "  <title>AI Assistant | PagaDromeda</title>\n"
                + "  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n"
                + "  <link href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css\" rel=\"stylesheet\">\n"
                + "  <style>\n"
                + "    html, body { height:100%; margin:0; padding:0; background:#0b0f1a; overflow:hidden; }\n"
                + "    #page-wrapper { height:100%; display:flex; flex-direction:column; }\n"
                // ── Bot strip ──
                + "    .bot-strip {\n"
                + "      background:#0d1117;\n"
                + "      border-bottom:1px solid rgba(255,255,255,0.07);\n"
                + "      display:flex; align-items:center; gap:6px;\n"
                + "      padding:0 16px; height:50px; flex-shrink:0;\n"
                + "      overflow-x:auto; scrollbar-width:none;\n"
                + "    }\n"
                + "    .bot-strip::-webkit-scrollbar { display:none; }\n"
                // ── Brand ──
                + "    .paga-brand {\n"
                + "      display:inline-flex; align-items:center; gap:8px;\n"
                + "      text-decoration:none; flex-shrink:0; margin-right:10px;\n"
                + "    }\n"
                + "    .paga-brand-name {\n"
                + "      font-family:'Segoe UI', system-ui, sans-serif;\n"
                + "      font-size:0.92rem; font-weight:700; letter-spacing:0.02em;\n"
                + "      background:linear-gradient(90deg,#60a5fa 0%,#a5f3fc 100%);\n"
                + "      -webkit-background-clip:text; -webkit-text-fill-color:transparent;\n"
                + "      background-clip:text; white-space:nowrap;\n"
                + "    }\n"
                + "    .paga-brand:hover .paga-brand-name { opacity:0.82; }\n"
                // ── Divider ──
                + "    .strip-divider {\n"
                + "      width:1px; height:22px; background:rgba(255,255,255,0.1);\n"
                + "      flex-shrink:0; margin:0 8px 0 4px;\n"
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
                // ── CHANGE 3: arch pill colour (sky-blue) ─────────────────────
                + "    .bot-pill.arch  { color:#38bdf8; border-color:rgba(56,189,248,0.3);  background:rgba(56,189,248,0.07);  }\n"
                // ─────────────────────────────────────────────────────────────
                + "    .bot-pill.legal:hover { background:rgba(245,158,11,0.18); }\n"
                + "    .bot-pill.bank:hover  { background:rgba(34,211,238,0.18); }\n"
                + "    .bot-pill.grad:hover  { background:rgba(167,139,250,0.18); }\n"
                + "    .bot-pill.cv:hover    { background:rgba(251,146,60,0.18); }\n"
                + "    .bot-pill.hiv:hover   { background:rgba(74,222,128,0.18); }\n"
                + "    .bot-pill.arch:hover  { background:rgba(56,189,248,0.18); }\n"
                // ── Active pills ──
                + "    .bot-pill.legal.active { background:rgba(245,158,11,0.2);  box-shadow:0 0 0 2px rgba(245,158,11,0.45);  }\n"
                + "    .bot-pill.bank.active  { background:rgba(34,211,238,0.2);  box-shadow:0 0 0 2px rgba(34,211,238,0.45);  }\n"
                + "    .bot-pill.grad.active  { background:rgba(167,139,250,0.2); box-shadow:0 0 0 2px rgba(167,139,250,0.45); }\n"
                + "    .bot-pill.cv.active    { background:rgba(251,146,60,0.2);  box-shadow:0 0 0 2px rgba(251,146,60,0.45);  }\n"
                + "    .bot-pill.hiv.active   { background:rgba(74,222,128,0.2);  box-shadow:0 0 0 2px rgba(74,222,128,0.45);  }\n"
                + "    .bot-pill.arch.active  { background:rgba(56,189,248,0.2);  box-shadow:0 0 0 2px rgba(56,189,248,0.45);  }\n"
                // ── Live dot ──
                + "    .dot { display:none; width:6px; height:6px; border-radius:50%; background:currentColor; animation:pulse 1.8s ease infinite; }\n"
                + "    .active .dot { display:inline-block; }\n"
                + "    @keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:0.45;transform:scale(0.65)} }\n"
                // ── Frame area ──
                + "    .bot-frame-area { flex:1 1 auto; overflow:hidden; position:relative; }\n"
                // ── Loading overlay ──
                + "    .loading-overlay {\n"
                + "      position:absolute; inset:0; background:#0b0f1a;\n"
                + "      display:flex; flex-direction:column; align-items:center;\n"
                + "      justify-content:center; gap:14px; color:#4b5563; z-index:10;\n"
                + "      transition:opacity 0.4s;\n"
                + "    }\n"
                + "    .loading-overlay.hidden { opacity:0; pointer-events:none; }\n"
                + "    .spinner {\n"
                + "      width:34px; height:34px;\n"
                + "      border:3px solid rgba(255,255,255,0.08);\n"
                + "      border-top-color:#3b82f6;\n"
                + "      border-radius:50%;\n"
                + "      animation:spin 0.7s linear infinite;\n"
                + "    }\n"
                + "    @keyframes spin { to { transform:rotate(360deg); } }\n"
                // ── Footer ──
                + "    .footer {\n"
                + "      background:#060a12; border-top:1px solid rgba(255,255,255,0.06);\n"
                + "      color:#4b5563; text-align:center; font-size:0.8rem;\n"
                + "      padding:8px 20px; flex-shrink:0;\n"
                + "    }\n"
                + "    .footer a { color:#6b7a99; text-decoration:none; }\n"
                + "  </style>\n"
                + "</head>\n"
                + "<body>\n"
                + "<div id=\"page-wrapper\">\n"
                // ── Bot strip ────────────────────────────────────────────────
                + "  <div class=\"bot-strip\">\n"
                + "    <a class=\"paga-brand\" href=\"" + ctx + "/chat\" title=\"PagaDromeda Home\">\n"
                + "      " + logo
                + "      <span class=\"paga-brand-name\">PagaDromeda</span>\n"
                + "    </a>\n"
                + "    <a class=\"bot-pill hiv" + kh + "\" href=\"" + ctx + "/BotViewer?bot=hiv\">\n"
                + "      <span class=\"dot\"></span>\n"
                + "      <i class=\"fas fa-heart-pulse\" style=\"font-size:0.72rem;\"></i> HIV Guidelines\n"
                + "    </a>\n"
                + "    <span class=\"strip-divider\"></span>\n"
                + "    <a class=\"bot-pill legal" + kl + "\" href=\"" + ctx + "/BotViewer?bot=legal\">\n"
                + "      <span class=\"dot\"></span>\n"
                + "      <i class=\"fas fa-scale-balanced\" style=\"font-size:0.72rem;\"></i> Global Legal Advisor\n"
                + "    </a>\n"
                + "    <a class=\"bot-pill bank" + kb + "\" href=\"" + ctx + "/BotViewer?bot=bank\">\n"
                + "      <span class=\"dot\"></span>\n"
                + "      <i class=\"fas fa-building-columns\" style=\"font-size:0.72rem;\"></i> Bank CRM Advisor\n"
                + "    </a>\n"
                + "    <a class=\"bot-pill grad" + kg + "\" href=\"" + ctx + "/BotViewer?bot=grad\">\n"
                + "      <span class=\"dot\"></span>\n"
                + "      <i class=\"fas fa-graduation-cap\" style=\"font-size:0.72rem;\"></i> Smart Grad\n"
                + "    </a>\n"
                + "    <a class=\"bot-pill cv" + kc + "\" href=\"" + ctx + "/BotViewer?bot=cv\">\n"
                + "      <span class=\"dot\"></span>\n"
                + "      <i class=\"fas fa-id-card-clip\" style=\"font-size:0.72rem;\"></i> Talk to My CV\n"
                + "    </a>\n"
                // ── CHANGE 4: Architecture pill added at end of strip ─────────
                + "    <span class=\"strip-divider\"></span>\n"
                + "    <a class=\"bot-pill arch" + ka + "\" href=\"" + ctx + "/BotViewer?bot=arch\">\n"
                + "      <span class=\"dot\"></span>\n"
                + "      <i class=\"fas fa-sitemap\" style=\"font-size:0.72rem;\"></i> Architecture\n"
                + "    </a>\n"
                // ─────────────────────────────────────────────────────────────
                + "  </div>\n"
                // ── Frame area ───────────────────────────────────────────────
                + "  <div class=\"bot-frame-area\">\n"
                + "    <div class=\"loading-overlay\" id=\"loadingOverlay\">\n"
                + "      <div class=\"spinner\"></div>\n"
                + "      <span style=\"font-size:0.8rem;font-family:monospace;\">Connecting to assistant\u2026</span>\n"
                + "    </div>\n"
                + iframeBlock
                + "  </div>\n"
                // ── Footer ───────────────────────────────────────────────────
                + "  <div class=\"footer\">\n"
                + "    &copy; 2026 PagaDromeda &mdash; by Patrick &nbsp;|&nbsp;\n"
                + "    <a href=\"https://www.linkedin.com/in/patricus/\">Patrick Gacirane</a>\n"
                + "  </div>\n"
                + "</div>\n"
                + "<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\n"
                + "<script>\n"
                + "  var frame   = document.getElementById('bot-frame');\n"
                + "  var overlay = document.getElementById('loadingOverlay');\n"
                + "  if (frame && overlay) {\n"
                + "    frame.addEventListener('load', function() {\n"
                + "      overlay.classList.add('hidden');\n"
                + "      setTimeout(function(){ overlay.style.display='none'; }, 450);\n"
                + "    });\n"
                + "  } else if (overlay) {\n"
                + "    overlay.style.display = 'none';\n"
                + "  }\n"
                + "</script>\n"
                + "</body>\n"
                + "</html>"
        );

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

        @Override
        public PrintWriter getWriter() { return writer; }

        @Override
        public String toString() {
            writer.flush();
            return output.toString();
        }
    }
}