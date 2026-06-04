package templates;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import io.github.cdimascio.dotenv.Dotenv;

/**
 * BotViewerTemplate.java
 * ─────────────────────────────────────────────────────────────────────────────
 * Servlet Filter — renders the full bot viewer shell.
 *
 * RESPONSIVE NAV — pills always visible at every screen width:
 *   > 860 px   : single row, full labels
 *   560–860 px : single row, tighter padding & font
 *   380–560 px : strip wraps to 2 rows; dividers hidden
 *   < 380 px   : pills even more compact, labels still readable
 *
 * TWO-COLOUR PALETTE:
 *   #0b0f1a  — dark background / surfaces
 *   #4ade80  — green brand accent
 *   #8892a4  — muted text / labels
 *   #eef2ff  — primary text
 * ─────────────────────────────────────────────────────────────────────────────
 */
public class BotViewerTemplate implements Filter {

    // ── Colour constants ──────────────────────────────────────────────────────
    private static final String C_BG      = "#0b0f1a";
    private static final String C_SURFACE = "#0d1117";
    private static final String C_BORDER  = "rgba(255,255,255,0.07)";
    private static final String C_GREEN   = "#4ade80";
    private static final String C_MUTED   = "#8892a4";
    private static final String C_TEXT    = "#eef2ff";

    // ── Resilient environment configuration ──────────────────────────────────
    private static final Dotenv dotenv;
    static {
        Dotenv tmp = null;
        try {
            tmp = Dotenv.configure()
                    .filename("/.env")
                    .ignoreIfMalformed()
                    .ignoreIfMissing()
                    .load();
        } catch (Exception ignored) {}
        dotenv = tmp;
    }

    private static String env(String key) {
        if (dotenv != null) {
            String v = dotenv.get(key);
            if (v != null && !v.trim().isEmpty()) return v.trim();
        }
        String v = System.getenv(key);
        if (v != null && !v.trim().isEmpty()) return v.trim();
        return System.getProperty(key, "");
    }

    private static final String URL_LEGAL = env("URL_LEGAL");
    private static final String URL_BANK  = env("URL_BANK");
    private static final String URL_GRAD  = env("URL_GRAD");
    private static final String URL_CV    = env("URL_CV");
    private static final String URL_HIV   = env("URL_HIV");

    @Override public void init(FilterConfig c) {}
    @Override public void destroy() {}

    // ─────────────────────────────────────────────────────────────────────────
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws ServletException, IOException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma",        "no-cache");
        response.setDateHeader("Expires",   0);

        String ctx    = request.getContextPath();
        String botKey = request.getParameter("bot");
        if (botKey == null) botKey = "";

        String botUrl;
        switch (botKey.toLowerCase()) {
            case "legal": botUrl = URL_LEGAL;                        break;
            case "bank":  botUrl = URL_BANK;                         break;
            case "grad":  botUrl = URL_GRAD;                         break;
            case "cv":    botUrl = URL_CV;                           break;
            case "hiv":   botUrl = URL_HIV;                          break;
            case "arch":  botUrl = ctx + "/arch-diagram";            break;
            // ── NEW: Social Impact Assessment page ──
            case "sia":    botUrl = ctx + "/SocialImpact";   break;
            case "ethics":    botUrl = ctx + "/AIEthics";             break;
            case "etymology": botUrl = ctx + "/Etymology";           break;
            case "hire":      botUrl = "__hire__";                    break;
            default:      botUrl = "";                               break;
        }

        CharResponseWrapper wrapper = new CharResponseWrapper(response);
        chain.doFilter(request, wrapper);

        String kl  = active(botKey, "legal");
        String kb  = active(botKey, "bank");
        String kg  = active(botKey, "grad");
        String kc  = active(botKey, "cv");
        String kh  = active(botKey, "hiv");
        String ka  = active(botKey, "arch");
        // ── NEW active state for sia pill ──
        String ks  = active(botKey, "sia");
        String ke  = active(botKey, "ethics");
        String kety = active(botKey, "etymology");

        String iframeBlock = botUrl.isEmpty()          ? emptyState(ctx)
                           : botUrl.equals("__hire__") ? hireBlock(ctx)
                           :                             iframe(botUrl);

        PrintWriter out = response.getWriter();
        out.println(page(ctx, iframeBlock, kl, kb, kg, kc, kh, ka, ks, ke, kety));
        out.close();
    }

    // =========================================================================
    //  HELPERS
    // =========================================================================

    private static String active(String key, String match) {
        return key.equalsIgnoreCase(match) ? " active" : "";
    }

    private static String emptyState(String ctx) {
        return "    <div style=\"height:100%;display:flex;flex-direction:column;"
             + "align-items:center;justify-content:center;background:" + C_BG + ";"
             + "color:" + C_MUTED + ";font-family:monospace;gap:14px;\">\n"
             + "      <svg xmlns='http://www.w3.org/2000/svg' width='48' height='48'"
             +        " viewBox='0 0 24 24' fill='none' stroke='" + C_MUTED + "'"
             +        " stroke-width='1.2' stroke-linecap='round' stroke-linejoin='round'>"
             + "<rect x='3' y='11' width='18' height='10' rx='2'/>"
             + "<path d='M9 11V7a3 3 0 0 1 6 0v4'/>"
             + "<circle cx='12' cy='16' r='1' fill='" + C_MUTED + "'/></svg>\n"
             + "      <span style=\"font-size:0.88rem;\">No assistant selected.</span>\n"
             + "      <a href=\"" + ctx + "/chat\""
             + " style=\"font-size:0.8rem;color:" + C_GREEN + ";text-decoration:none;"
             + "border-bottom:1px solid rgba(74,222,128,0.3);\">&#8592; Back to AI Suite</a>\n"
             + "    </div>\n";
    }

    private static String iframe(String botUrl) {
        return "    <iframe id=\"bot-frame\"\n"
             + "      src=\"" + botUrl + "\"\n"
             + "      title=\"AI Assistant\"\n"
             + "      allow=\"microphone; clipboard-write\"\n"
             + "      sandbox=\"allow-scripts allow-same-origin allow-forms allow-popups\"\n"
             + "      style=\"width:100%;height:100%;border:none;display:block;\">\n"
             + "    </iframe>\n";
    }

    // ── Hire page content — rendered inline inside BotViewerTemplate shell ──
    private static String hireBlock(String ctx) {
        return "<div style=\"max-width:900px;margin:0 auto;padding:clamp(20px,3vw,40px) clamp(16px,4vw,48px) 60px;\">\n"

            // ── Availability banner ──
            + "  <div style=\"display:flex;align-items:center;gap:12px;background:rgba(74,222,128,0.05);"
            + "border:1px solid rgba(74,222,128,0.18);border-left:3px solid #4ade80;border-radius:10px;"
            + "padding:12px 18px;flex-wrap:wrap;margin-bottom:28px;\">\n"
            + "    <span style=\"width:8px;height:8px;border-radius:50%;background:#4ade80;flex-shrink:0;"
            + "animation:pulse 2s ease-in-out infinite;\"></span>\n"
            + "    <span style=\"font-family:'IBM Plex Mono',monospace;font-size:0.62rem;letter-spacing:0.14em;"
            + "text-transform:uppercase;color:#4ade80;\">Available from July 2026</span>\n"
            + "    <div style=\"display:flex;gap:6px;flex-wrap:wrap;margin-left:auto;\">\n"
            + "      <span style=\"font-family:'IBM Plex Mono',monospace;font-size:0.50rem;letter-spacing:0.12em;"
            + "text-transform:uppercase;color:rgba(74,222,128,0.75);border:1px solid rgba(74,222,128,0.22);"
            + "background:rgba(74,222,128,0.06);padding:3px 10px;border-radius:20px;\">Kigali, Rwanda</span>\n"
            + "      <span style=\"font-family:'IBM Plex Mono',monospace;font-size:0.50rem;letter-spacing:0.12em;"
            + "text-transform:uppercase;color:rgba(74,222,128,0.75);border:1px solid rgba(74,222,128,0.22);"
            + "background:rgba(74,222,128,0.06);padding:3px 10px;border-radius:20px;\">Remote-first</span>\n"
            + "      <span style=\"font-family:'IBM Plex Mono',monospace;font-size:0.50rem;letter-spacing:0.12em;"
            + "text-transform:uppercase;color:rgba(74,222,128,0.75);border:1px solid rgba(74,222,128,0.22);"
            + "background:rgba(74,222,128,0.06);padding:3px 10px;border-radius:20px;\">Open to relocation</span>\n"
            + "      <span style=\"font-family:'IBM Plex Mono',monospace;font-size:0.50rem;letter-spacing:0.12em;"
            + "text-transform:uppercase;color:rgba(74,222,128,0.75);border:1px solid rgba(74,222,128,0.22);"
            + "background:rgba(74,222,128,0.06);padding:3px 10px;border-radius:20px;\">Consulting &amp; full-time</span>\n"
            + "    </div>\n"
            + "  </div>\n"

            // ── Headline ──
            + "  <h1 style=\"font-size:clamp(1.3rem,4vw,2.8rem);font-weight:800;line-height:1.08;"
            + "letter-spacing:-0.03em;color:#eef2ff;margin-bottom:12px;\">\n"
            + "    <span style=\"background:linear-gradient(110deg,#4ade80 0%,#86efac 100%);"
            + "-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;\">Available</span>"
            + " for <span style=\"background:linear-gradient(110deg,#4ade80 0%,#86efac 100%);"
            + "-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;\">AI&nbsp;roles</span>"
            + " &mdash; Rwanda &amp; worldwide.\n"
            + "  </h1>\n"
            + "  <p style=\"font-size:clamp(0.72rem,1.1vw,0.84rem);color:#8892a4;line-height:1.7;"
            + "max-width:660px;margin-bottom:28px;\">The only AI engineer in Rwanda building "
            + "<strong style=\"color:#c8d4e8;\">production multi-agent systems</strong> grounded in African "
            + "regulatory, clinical, and financial contexts &mdash; with <strong style=\"color:#c8d4e8;\">"
            + "5 live demos</strong> you can interact with right now.</p>\n"

            // ── Value proposition ──
            + "  <div style=\"background:rgba(19,25,41,0.7);border:1px solid rgba(74,222,128,0.15);"
            + "border-left:3px solid #4ade80;border-radius:0 10px 10px 0;padding:16px 20px;margin-bottom:28px;\">\n"
            + "    <p style=\"font-size:clamp(0.72rem,1.1vw,0.82rem);color:#c8d4e8;line-height:1.65;"
            + "font-style:italic;\">&#8220;I build <strong style=\"color:#4ade80;font-style:normal;\">"
            + "end-to-end AI platforms</strong> &mdash; from multi-agent CrewAI backends and hybrid RAG pipelines "
            + "to production Java EE frontends with SSE streaming. Every system I build is grounded in real domain "
            + "documentation: RPPA procurement law, RBC HIV clinical guidelines, World Bank IPF regulations.&#8221;</p>\n"
            + "    <p style=\"font-family:'IBM Plex Mono',monospace;font-size:0.50rem;letter-spacing:0.16em;"
            + "text-transform:uppercase;color:#8892a4;margin-top:8px;\">— GACIRANE Patrick &mdash; Kigali, Rwanda &mdash; 2026</p>\n"
            + "  </div>\n"

            // ── Metrics ──
            + "  <div style=\"display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin-bottom:28px;\">\n"
            + metric("5",     "Live AI Apps",        false)
            + metric("9",     "Max agents per crew", false)
            + metric("4",     "MCP RAG servers",     false)
            + metric("3",     "Apps in development", true)
            + "  </div>\n"

            // ── Engagement cards ──
            + "  <div style=\"display:grid;grid-template-columns:repeat(3,1fr);gap:14px;margin-bottom:28px;\">\n"
            + engageCard("Full-time / Long-term",    "AI Solutions Architect",
                "I design and build production AI systems end-to-end &mdash; multi-agent backends, RAG pipelines, streaming frontends, and vector datastores.",
                "Connect on LinkedIn", "https://www.linkedin.com/in/patricus/", false)
            + engageCard("Consulting / Contract",    "AI Platform Consulting",
                "Fractional AI architect for your organisation: RAG system design, multi-agent pipeline architecture, LLMOps, AI ethics assessments, or scaling a prototype to production.",
                "Discuss your project", "mailto:pgacirane@gmail.com", true)
            + engageCard("Partnerships / Investors", "Scale an MVP",
                "All five live MVPs are ready to scale with production investment. Each is architecturally validated and domain-grounded. Open to co-founders and institutional investors.",
                "Start the conversation", "mailto:pgacirane@gmail.com", false)
            + "  </div>\n"

            // ── CTA strip ──
            + "  <div style=\"display:flex;align-items:center;justify-content:center;gap:12px;"
            + "flex-wrap:wrap;padding:24px 0;border-top:1px solid rgba(74,222,128,0.08);\">\n"
            + ctaBtn("mailto:pgacirane@gmail.com",                     "Email me directly",  "green")
            + ctaBtn("https://www.linkedin.com/in/patricus/",          "LinkedIn profile",   "green")
            + ctaBtn(ctx + "/AiBotsDashboard",                         "View live demos",    "green")
            + "  </div>\n"

            + "</div>\n"
            + "<style>.hire-scroll-area{overflow:auto;}</style>\n";
    }

    private static String metric(String num, String label, boolean amber) {
        String colour = "#4ade80";
        return "    <div style=\"background:rgba(19,25,41,0.85);border:1px solid rgba(74,222,128,0.12);"
             + "border-radius:11px;padding:14px 15px;text-align:center;\">\n"
             + "      <div style=\"font-size:1.7rem;font-weight:800;color:" + colour + ";"
             + "letter-spacing:-0.03em;line-height:1;\">" + num + "</div>\n"
             + "      <div style=\"font-family:'IBM Plex Mono',monospace;font-size:0.50rem;"
             + "letter-spacing:0.14em;text-transform:uppercase;color:#8892a4;margin-top:6px;\">"
             + label + "</div>\n"
             + "    </div>\n";
    }

    private static String engageCard(String label, String title, String body,
                                      String cta, String href, boolean amber) {
        String accent = "rgba(74,222,128,0.6)";
        String ctaCol = "#4ade80";
        return "    <div style=\"background:#131929;border:1px solid rgba(255,255,255,0.07);"
             + "border-radius:14px;padding:18px 16px;display:flex;flex-direction:column;gap:8px;"
             + "position:relative;overflow:hidden;\">\n"
             + "      <div style=\"position:absolute;top:0;left:0;right:0;height:2px;"
             + "background:linear-gradient(90deg," + accent + ",rgba(74,222,128,0.06));\"></div>\n"
             + "      <span style=\"font-family:'IBM Plex Mono',monospace;font-size:0.48rem;"
             + "letter-spacing:0.2em;text-transform:uppercase;color:" + ctaCol + ";opacity:0.65;\">"
             + label + "</span>\n"
             + "      <div style=\"font-size:0.88rem;font-weight:700;color:#eef2ff;\">" + title + "</div>\n"
             + "      <div style=\"font-size:0.70rem;color:#8892a4;line-height:1.65;flex:1;\">" + body + "</div>\n"
             + "      <div style=\"padding-top:10px;border-top:1px solid rgba(255,255,255,0.05);\">\n"
             + "        <a href=\"" + href + "\" style=\"font-family:'IBM Plex Mono',monospace;"
             + "font-size:0.58rem;letter-spacing:0.12em;text-transform:uppercase;color:" + ctaCol + ";"
             + "text-decoration:none;\">" + cta + " &rarr;</a>\n"
             + "      </div>\n"
             + "    </div>\n";
    }

    private static String ctaBtn(String href, String label, String style) {
        String bg, border, colour;
        bg = "rgba(74,222,128,0.12)"; border = "rgba(74,222,128,0.45)"; colour = "#4ade80";
        return "    <a href=\"" + href + "\" style=\"font-family:'IBM Plex Mono',monospace;"
             + "font-size:0.65rem;letter-spacing:0.14em;text-transform:uppercase;text-decoration:none;"
             + "display:inline-flex;align-items:center;gap:8px;padding:10px 22px;border-radius:8px;"
             + "background:" + bg + ";border:1px solid " + border + ";color:" + colour + ";\">"
             + label + "</a>\n";
    }

    // ── AIonifier SVG logo ─────────────────────────────────────────────────────
    private static String logo() {
        return "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 32 32\""
             + " width=\"26\" height=\"26\" fill=\"none\" aria-hidden=\"true\""
             + " style=\"flex-shrink:0;display:block;\">\n"
             + "  <defs>\n"
             + "    <radialGradient id=\"pg-core\" cx=\"50%\" cy=\"50%\" r=\"50%\">\n"
             + "      <stop offset=\"0%\"   stop-color=\"#4ade80\"/>\n"
             + "      <stop offset=\"100%\" stop-color=\"#16a34a\"/>\n"
             + "    </radialGradient>\n"
             + "    <radialGradient id=\"pg-node\" cx=\"50%\" cy=\"50%\" r=\"50%\">\n"
             + "      <stop offset=\"0%\"   stop-color=\"#86efac\"/>\n"
             + "      <stop offset=\"100%\" stop-color=\"#4ade80\"/>\n"
             + "    </radialGradient>\n"
             + "    <filter id=\"pg-glow\" x=\"-40%\" y=\"-40%\" width=\"180%\" height=\"180%\">\n"
             + "      <feGaussianBlur stdDeviation=\"1.2\" result=\"blur\"/>\n"
             + "      <feMerge><feMergeNode in=\"blur\"/><feMergeNode in=\"SourceGraphic\"/></feMerge>\n"
             + "    </filter>\n"
             + "  </defs>\n"
             + "  <ellipse cx=\"16\" cy=\"16\" rx=\"13\" ry=\"5.5\""
             + "   stroke=\"rgba(74,222,128,0.22)\" stroke-width=\"1\""
             + "   transform=\"rotate(-30 16 16)\"/>\n"
             + "  <line x1=\"16\" y1=\"16\" x2=\"8\"  y2=\"9\"  stroke=\"rgba(74,222,128,0.35)\" stroke-width=\"0.9\"/>\n"
             + "  <line x1=\"16\" y1=\"16\" x2=\"24\" y2=\"9\"  stroke=\"rgba(74,222,128,0.35)\" stroke-width=\"0.9\"/>\n"
             + "  <line x1=\"16\" y1=\"16\" x2=\"26\" y2=\"19\" stroke=\"rgba(74,222,128,0.35)\" stroke-width=\"0.9\"/>\n"
             + "  <line x1=\"16\" y1=\"16\" x2=\"10\" y2=\"24\" stroke=\"rgba(74,222,128,0.35)\" stroke-width=\"0.9\"/>\n"
             + "  <line x1=\"16\" y1=\"16\" x2=\"22\" y2=\"25\" stroke=\"rgba(74,222,128,0.35)\" stroke-width=\"0.9\"/>\n"
             + "  <line x1=\"8\"  y1=\"9\"  x2=\"24\" y2=\"9\"  stroke=\"rgba(74,222,128,0.18)\" stroke-width=\"0.7\"/>\n"
             + "  <line x1=\"10\" y1=\"24\" x2=\"22\" y2=\"25\" stroke=\"rgba(74,222,128,0.18)\" stroke-width=\"0.7\"/>\n"
             + "  <line x1=\"24\" y1=\"9\"  x2=\"26\" y2=\"19\" stroke=\"rgba(74,222,128,0.18)\" stroke-width=\"0.7\"/>\n"
             + "  <circle cx=\"16\" cy=\"16\" r=\"4\"   fill=\"url(#pg-core)\" filter=\"url(#pg-glow)\"/>\n"
             + "  <circle cx=\"8\"  cy=\"9\"  r=\"2\"   fill=\"url(#pg-node)\" opacity=\"0.9\"/>\n"
             + "  <circle cx=\"24\" cy=\"9\"  r=\"1.6\" fill=\"url(#pg-node)\" opacity=\"0.8\"/>\n"
             + "  <circle cx=\"26\" cy=\"19\" r=\"1.8\" fill=\"url(#pg-node)\" opacity=\"0.85\"/>\n"
             + "  <circle cx=\"10\" cy=\"24\" r=\"1.6\" fill=\"url(#pg-node)\" opacity=\"0.8\"/>\n"
             + "  <circle cx=\"22\" cy=\"25\" r=\"2\"   fill=\"url(#pg-node)\" opacity=\"0.9\"/>\n"
             + "  <circle cx=\"16\" cy=\"16\" r=\"1.2\" fill=\"#d1fae5\" opacity=\"0.7\"/>\n"
             + "</svg>\n";
    }

    // ── Bot pill HTML helper ──────────────────────────────────────────────────
    private static String pill(String ctx, String bot, String active,
                                String faIcon, String label) {
        return "    <a class=\"bot-pill" + active + "\" href=\"" + ctx
             + "/BotViewer?bot=" + bot + "\">\n"
             + "      <span class=\"dot\"></span>\n"
             + "      <i class=\"fas " + faIcon + "\"></i>"
             + "<span class=\"pill-label\">" + label + "</span>\n"
             + "    </a>\n";
    }

    // ── Full page assembly — added ks parameter for sia pill ─────────────────
    private static String page(String ctx, String iframeBlock,
                                String kl, String kb, String kg,
                                String kc, String kh, String ka,
                                String ks, String ke, String kety) {
        return "<!DOCTYPE html>\n"
             + "<html lang=\"en\">\n"
             + "<head>\n"
             + "  <meta charset=\"UTF-8\">\n"
             + "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
             + "  <title>AI Assistant | AIonifier</title>\n"
             + "  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\""
             +       " rel=\"stylesheet\">\n"
             + "  <link href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css\""
             +       " rel=\"stylesheet\">\n"
             + "  <style>\n"
             + css()
             + "  </style>\n"
             + "</head>\n"
             + "<body>\n"
             + "<div id=\"page-wrapper\">\n"

             // ── Strip ──
             + "  <div class=\"bot-strip\">\n"
             + "    <div class=\"strip-left\">\n"
             + "      <a class=\"brand\" href=\"" + ctx + "/chat\" title=\"AIonifier Home\">\n"
             + "        " + logo()
             + "        <span class=\"brand-name\">AIonifier</span>\n"
             + "      </a>\n"
             + "      <span class=\"strip-div\"></span>\n"
             + "    </div>\n"
             + "    <div class=\"strip-pills\">\n"
             + pill(ctx, "hiv",   kh, "fa-heart-pulse",      "HIV Guidelines")
             + pill(ctx, "legal", kl, "fa-scale-balanced",   "Global Legal Advisor")
             + pill(ctx, "bank",  kb, "fa-building-columns", "Bank CRM Advisor")
             + pill(ctx, "grad",  kg, "fa-graduation-cap",   "Smart Grad")
             + pill(ctx, "cv",    kc, "fa-id-card-clip",     "Talk to My CV")
             + "      <span class=\"strip-div arch-div\"></span>\n"
             + pill(ctx, "arch",  ka, "fa-sitemap",          "Architecture")
             // ── NEW: Social Impact Assessment pill — separated by a divider ──
             + "      <span class=\"strip-div\"></span>\n"
             + pill(ctx, "sia",   ks, "fa-chart-pie",        "Social Impact")
             + "      <span class=\"strip-div\"></span>\n"
             + pill(ctx, "ethics", ke, "fa-shield-halved",    "AI Ethics")
             + "      <span class=\"strip-div\"></span>\n"
             + pill(ctx, "etymology", kety, "fa-book-open",   "AIonifier Etymology")
             // ── Hire Me — direct link to /BotViewer?bot=hire, bypasses BotViewer iframe ──
             + "      <span class=\"strip-div\"></span>\n"
             + "    <a class=\"bot-pill\" href=\"" + ctx + "/BotViewer?bot=hire\">\n"
             + "      <i class=\"fas fa-briefcase\"></i>"
             + "<span class=\"pill-label\">Hire Me</span>\n"
             + "    </a>\n"
             + "    </div>\n"
             + "  </div>\n"

             // ── Frame area ──
             + "  <div class=\"frame-area\">\n"
             + "    <div class=\"loading-overlay\" id=\"loadingOverlay\">\n"
             + "      <div class=\"spinner\"></div>\n"
             + "      <span style=\"font-size:0.8rem;font-family:monospace;color:" + C_MUTED + ";\">Connecting\u2026</span>\n"
             + "    </div>\n"
             + iframeBlock
             + "  </div>\n"

             // ── Footer ──
             + "  <div class=\"footer\">\n"
             + "          <p>\n" +
"        &copy; 2026\n" +
"        <a href=\"https://www.linkedin.com/in/patricus/\" target=\"_blank\" rel=\"noopener noreferrer\">GACIRANE Patrick</a>\n" +
"        &mdash; AIonifier AI Suite &mdash; MVP Showcase Portfolio &mdash; Not for production use.\n" +
"      </p>\n"
             + "  </div>\n"
             + "</div>\n"
             + "<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\n"
             + "<script>\n"
             + js()
             + "</script>\n"
             + "</body>\n"
             + "</html>";
    }

    // =========================================================================
    //  CSS — fully responsive nav, all pills always visible
    // =========================================================================
    private static String css() {
        return
            // ── Reset / base ──
            "    *, *::before, *::after { box-sizing:border-box; margin:0; padding:0; }\n"
          + "    :root {\n"
          + "      --bg:       " + C_BG      + ";\n"
          + "      --surface:  " + C_SURFACE + ";\n"
          + "      --border:   " + C_BORDER  + ";\n"
          + "      --green:    " + C_GREEN   + ";\n"
          + "      --green-lo: rgba(74,222,128,0.08);\n"
          + "      --green-md: rgba(74,222,128,0.16);\n"
          + "      --green-hi: rgba(74,222,128,0.30);\n"
          + "      --muted:    " + C_MUTED   + ";\n"
          + "      --text:     " + C_TEXT    + ";\n"
          + "    }\n"
          + "    html, body { height:100%; background:var(--bg); overflow:hidden; }\n"
          + "    #page-wrapper { height:100%; display:flex; flex-direction:column; }\n"

          + "    .bot-strip {\n"
          + "      background:var(--surface);\n"
          + "      border-bottom:1px solid var(--border);\n"
          + "      display:flex;\n"
          + "      align-items:center;\n"
          + "      flex-wrap:wrap;\n"
          + "      gap:4px;\n"
          + "      padding:6px 16px;\n"
          + "      min-height:50px;\n"
          + "      flex-shrink:0;\n"
          + "    }\n"

          + "    .strip-left {\n"
          + "      display:flex; align-items:center; gap:6px;\n"
          + "      flex-shrink:0;\n"
          + "    }\n"

          + "    .strip-pills {\n"
          + "      display:flex;\n"
          + "      align-items:center;\n"
          + "      flex-wrap:wrap;\n"
          + "      gap:4px;\n"
          + "      flex:1 1 auto;\n"
          + "    }\n"

          + "    .brand {\n"
          + "      display:inline-flex; align-items:center; gap:8px;\n"
          + "      text-decoration:none; flex-shrink:0;\n"
          + "    }\n"
          + "    .brand-name {\n"
          + "      font-family:'Segoe UI', system-ui, sans-serif;\n"
          + "      font-size:0.92rem; font-weight:700; letter-spacing:0.02em;\n"
          + "      background:linear-gradient(90deg,var(--green) 0%,#86efac 100%);\n"
          + "      -webkit-background-clip:text; -webkit-text-fill-color:transparent;\n"
          + "      background-clip:text; white-space:nowrap;\n"
          + "    }\n"
          + "    .brand:hover .brand-name { opacity:0.82; }\n"

          + "    .strip-div {\n"
          + "      width:1px; height:22px;\n"
          + "      background:var(--border);\n"
          + "      flex-shrink:0; margin:0 4px;\n"
          + "    }\n"

          + "    .bot-pill {\n"
          + "      display:inline-flex; align-items:center; gap:5px;\n"
          + "      padding:5px 12px; border-radius:999px;\n"
          + "      font-size:0.74rem; font-weight:600; white-space:nowrap;\n"
          + "      text-decoration:none;\n"
          + "      color:var(--muted);\n"
          + "      border:1px solid var(--border);\n"
          + "      background:transparent;\n"
          + "      transition:color .2s, background .2s, border-color .2s, transform .18s;\n"
          + "    }\n"
          + "    .bot-pill i { font-size:0.70rem; }\n"
          + "    .bot-pill:hover {\n"
          + "      color:var(--green); background:var(--green-lo);\n"
          + "      border-color:var(--green-hi); transform:translateY(-1px);\n"
          + "    }\n"
          + "    .bot-pill.active {\n"
          + "      color:var(--green); background:var(--green-md);\n"
          + "      border-color:var(--green-hi);\n"
          + "      box-shadow:0 0 0 2px rgba(74,222,128,0.30);\n"
          + "    }\n"

          // ── Social Impact pill — green accent when active ─────────────────
          + "    .bot-pill.sia-active,\n"
          + "    a.bot-pill[href*='bot=sia'].active {\n"
          + "      color:var(--green); background:var(--green-md);\n"
          + "      border-color:var(--green-hi);\n"
          + "      box-shadow:0 0 0 2px rgba(74,222,128,0.30);\n"
          + "    }\n"
          + "    a.bot-pill[href*='bot=sia']:hover {\n"
          + "      color:var(--green); background:var(--green-lo);\n"
          + "      border-color:var(--green-hi);\n"
          + "    }\n"

          // ── AI Ethics pill — violet/purple accent when active ───────────
          + "    a.bot-pill[href*='bot=ethics'].active {\n"
          + "      color:#a78bfa; background:rgba(167,139,250,0.14);\n"
          + "      border-color:rgba(167,139,250,0.40);\n"
          + "      box-shadow:0 0 0 2px rgba(167,139,250,0.22);\n"
          + "    }\n"
          + "    a.bot-pill[href*='bot=ethics']:hover {\n"
          + "      color:#a78bfa; background:rgba(167,139,250,0.08);\n"
          + "      border-color:rgba(167,139,250,0.35);\n"
          + "    }\n"

          + "    .dot {\n"
          + "      display:none; width:6px; height:6px; border-radius:50%;\n"
          + "      background:var(--green);\n"
          + "      animation:pulse 1.8s ease infinite;\n"
          + "    }\n"
          + "    .active .dot { display:inline-block; }\n"
          + "    @keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:0.4;transform:scale(0.6)} }\n"

          + "    .frame-area { flex:1 1 auto; overflow:auto; position:relative; min-height:0; }\n"

          + "    .loading-overlay {\n"
          + "      position:absolute; inset:0; background:var(--bg);\n"
          + "      display:flex; flex-direction:column; align-items:center;\n"
          + "      justify-content:center; gap:14px; z-index:10;\n"
          + "      transition:opacity 0.4s;\n"
          + "    }\n"
          + "    .loading-overlay.hidden { opacity:0; pointer-events:none; }\n"
          + "    .spinner {\n"
          + "      width:32px; height:32px;\n"
          + "      border:2.5px solid var(--border);\n"
          + "      border-top-color:var(--green);\n"
          + "      border-radius:50%;\n"
          + "      animation:spin 0.7s linear infinite;\n"
          + "    }\n"
          + "    @keyframes spin { to { transform:rotate(360deg); } }\n"

          + "    .footer {\n"
          + "      background:var(--bg); border-top:1px solid var(--border);\n"
          + "      color:var(--muted); text-align:center;\n"
          + "      font-size:0.78rem; padding:7px 20px; flex-shrink:0;\n"
          + "    }\n"
          + "    .footer a {\n"
          + "      color:var(--green); text-decoration:none;\n"
          + "      border-bottom:1px solid rgba(74,222,128,0.28);\n"
          + "    }\n"
          + "    .footer a:hover { opacity:0.82; }\n"

          + "    @media (max-width:860px) {\n"
          + "      .bot-strip  { padding:5px 12px; gap:3px; }\n"
          + "      .strip-pills{ gap:3px; }\n"
          + "      .bot-pill   { padding:4px 9px; font-size:0.70rem; gap:4px; }\n"
          + "      .bot-pill i { font-size:0.65rem; }\n"
          + "      .brand-name { font-size:0.86rem; }\n"
          + "    }\n"

          + "    @media (max-width:600px) {\n"
          + "      .bot-strip {\n"
          + "        padding:5px 10px;\n"
          + "        row-gap:5px;\n"
          + "      }\n"
          + "      .strip-left  { width:100%; justify-content:flex-start; }\n"
          + "      .strip-pills { width:100%; flex-wrap:wrap; }\n"
          + "      .strip-div   { display:none; }\n"
          + "      .bot-pill    { padding:4px 8px; font-size:0.68rem; gap:3px; }\n"
          + "      .bot-pill i  { font-size:0.63rem; }\n"
          + "      .brand-name  { font-size:0.82rem; }\n"
          + "      .footer      { font-size:0.70rem; padding:5px 12px; }\n"
          + "    }\n"

          + "    @media (max-width:400px) {\n"
          + "      .bot-pill    { padding:3px 6px; font-size:0.62rem; gap:2px; border-radius:6px; }\n"
          + "      .bot-pill i  { font-size:0.58rem; }\n"
          + "      .pill-label  { font-size:0.60rem; }\n"
          + "      .dot         { width:4px; height:4px; }\n"
          + "      .brand-name  { font-size:0.76rem; }\n"
          + "      .footer      { display:none; }\n"
          + "    }\n";
    }

    // =========================================================================
    //  JS — hide loading overlay once iframe loads
    // =========================================================================
    private static String js() {
        return
            "  var frame   = document.getElementById('bot-frame');\n"
          + "  var overlay = document.getElementById('loadingOverlay');\n"
          + "  if (frame && overlay) {\n"
          + "    frame.addEventListener('load', function() {\n"
          + "      overlay.classList.add('hidden');\n"
          + "      setTimeout(function(){ overlay.style.display='none'; }, 450);\n"
          + "    });\n"
          + "  } else if (overlay) {\n"
          + "    overlay.style.display = 'none';\n"
          + "  }\n";
    }

    // ── Response wrapper ──────────────────────────────────────────────────────
    private static class CharResponseWrapper extends HttpServletResponseWrapper {
        private final StringWriter sw = new StringWriter();
        private final PrintWriter  pw = new PrintWriter(sw);
        public CharResponseWrapper(HttpServletResponse r) { super(r); }
        @Override public PrintWriter getWriter()          { return pw; }
        @Override public String toString() { pw.flush(); return sw.toString(); }
    }
}