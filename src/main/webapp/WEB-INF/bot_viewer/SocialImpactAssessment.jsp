<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Social Impact Assessment — AIoniser Platform</title>
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Source+Sans+3:ital,wght@0,300;0,400;0,600;0,700;1,300;1,400&display=swap" rel="stylesheet"/>
<style>
/* ═══════════════════════════════════════════════════════════════
   TOKENS
═══════════════════════════════════════════════════════════════ */
:root {
  /* Brand palette */
  --ink:        #0f1520;
  --ink2:       #2d3a4e;
  --ink3:       #5a6a80;
  --rule:       #c8d4e0;
  --rule-light: #e4ecf4;
  --page:       #f7f9fc;
  --white:      #ffffff;

  /* SmartAttorney accent — deep cobalt */
  --sa-hdr:     #0a2463;
  --sa-hdr2:    #1a4a9e;
  --sa-hdr-txt: #ffffff;
  --sa-row-a:   #0a2463;   /* row label bg harms */
  --sa-row-b:   #1a4a9e;   /* row label bg benefits */
  --sa-row-txt: #ffffff;
  --sa-col-hdr: #d6e4f7;
  --sa-stripe:  #eef4fb;
  --sa-badge:   #c41e3a;   /* harm badge */
  --sa-badge2:  #1a7a3e;   /* benefit badge */
  --sa-accent:  #1a4a9e;

  /* HIV Guidelines accent — deep teal */
  --hv-hdr:     #00443a;
  --hv-hdr2:    #006b5a;
  --hv-hdr-txt: #ffffff;
  --hv-row-a:   #00443a;
  --hv-row-b:   #006b5a;
  --hv-row-txt: #ffffff;
  --hv-col-hdr: #d0eee8;
  --hv-stripe:  #e8f7f4;
  --hv-badge:   #c41e3a;
  --hv-badge2:  #005a8e;
  --hv-accent:  #006b5a;

  /* Typography */
  --font-display: 'Playfair Display', Georgia, serif;
  --font-body:    'Source Sans 3', 'Segoe UI', sans-serif;

  /* Layout */
  --page-max:   1280px;
  --pad:        40px;
}

/* ═══════════════════════════════════════════════════════════════
   RESET & BASE
═══════════════════════════════════════════════════════════════ */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }

body {
  background: var(--page);
  color: var(--ink);
  font-family: var(--font-body);
  font-size: 14px;
  line-height: 1.55;
  -webkit-text-size-adjust: 100%;
}

/* ═══════════════════════════════════════════════════════════════
   PAGE HEADER
═══════════════════════════════════════════════════════════════ */
.page-header {
  background: linear-gradient(135deg, #0a1628 0%, #0a2463 55%, #1a4a9e 100%);
  color: #fff;
  padding: 48px var(--pad) 44px;
  position: relative;
  overflow: hidden;
}
.page-header::before {
  content: '';
  position: absolute; inset: 0;
  background-image:
    radial-gradient(circle at 80% 20%, rgba(255,255,255,.06) 0%, transparent 60%),
    radial-gradient(circle at 10% 80%, rgba(255,255,255,.04) 0%, transparent 50%);
  pointer-events: none;
}
.page-header::after {
  content: '';
  position: absolute; bottom: 0; left: 0; right: 0; height: 4px;
  background: linear-gradient(90deg, #f0b429, #e05252, #3b82f6, #22c55e);
}

.ph-inner {
  max-width: var(--page-max);
  margin: 0 auto;
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 24px;
  flex-wrap: wrap;
}
.ph-left { flex: 1; min-width: 280px; }
.ph-kicker {
  font-family: var(--font-body);
  font-size: 11px; font-weight: 600;
  letter-spacing: .18em; text-transform: uppercase;
  color: rgba(255,255,255,.55);
  margin-bottom: 10px;
}
.ph-title {
  font-family: var(--font-display);
  font-size: clamp(22px,4vw,36px);
  font-weight: 800; line-height: 1.15;
  color: #fff;
  margin-bottom: 10px;
}
.ph-subtitle {
  font-size: 14px; color: rgba(255,255,255,.72);
  max-width: 560px; line-height: 1.6;
}

.ph-meta {
  display: flex; flex-direction: column;
  align-items: flex-end; gap: 8px;
  flex-shrink: 0;
}
.ph-meta-badge {
  background: rgba(255,255,255,.12);
  border: 1px solid rgba(255,255,255,.22);
  border-radius: 6px; padding: 5px 12px;
  font-size: 11px; color: rgba(255,255,255,.8);
  white-space: nowrap;
}
.ph-meta-badge strong { color: #fff; }

/* Nav tabs */
.nav-tabs {
  background: var(--white);
  border-bottom: 1px solid var(--rule);
  padding: 0 var(--pad);
  position: sticky; top: 0; z-index: 50;
  box-shadow: 0 2px 8px rgba(0,0,0,.06);
}
.nav-tabs-inner {
  max-width: var(--page-max); margin: 0 auto;
  display: flex; gap: 0; overflow-x: auto;
}
.nav-tab {
  display: inline-flex; align-items: center; gap: 7px;
  padding: 14px 20px;
  font-size: 13px; font-weight: 600;
  color: var(--ink3);
  text-decoration: none;
  border-bottom: 3px solid transparent;
  transition: color .15s, border-color .15s;
  white-space: nowrap; cursor: pointer;
}
.nav-tab:hover { color: var(--ink); }
.nav-tab.sa { border-bottom-color: var(--sa-accent); color: var(--sa-accent); }
.nav-tab.hv { border-bottom-color: var(--hv-accent); color: var(--hv-accent); }
.nav-tab .tab-icon { font-size: 15px; }

/* ═══════════════════════════════════════════════════════════════
   MAIN CONTENT
═══════════════════════════════════════════════════════════════ */
.main-content {
  max-width: var(--page-max);
  margin: 0 auto;
  padding: 44px var(--pad) 64px;
  display: flex; flex-direction: column; gap: 64px;
}

/* ═══════════════════════════════════════════════════════════════
   ASSESSMENT SECTION
═══════════════════════════════════════════════════════════════ */
.assessment-section { display: flex; flex-direction: column; gap: 40px; }

/* Section heading */
.section-heading {
  display: flex; align-items: flex-start; gap: 18px;
  padding-bottom: 20px;
  border-bottom: 2px solid var(--rule);
}
.section-heading .sh-icon {
  width: 52px; height: 52px; border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  font-size: 26px; flex-shrink: 0;
}
.section-heading.sa .sh-icon { background: linear-gradient(135deg, var(--sa-hdr), var(--sa-hdr2)); }
.section-heading.hv .sh-icon { background: linear-gradient(135deg, var(--hv-hdr), var(--hv-hdr2)); }
.sh-text { flex: 1; }
.sh-kicker {
  font-size: 11px; font-weight: 600; letter-spacing: .14em; text-transform: uppercase;
  margin-bottom: 5px;
}
.section-heading.sa .sh-kicker { color: var(--sa-accent); }
.section-heading.hv .sh-kicker { color: var(--hv-accent); }
.sh-title {
  font-family: var(--font-display);
  font-size: clamp(18px,3vw,26px); font-weight: 700;
  color: var(--ink); line-height: 1.2; margin-bottom: 6px;
}
.sh-desc { font-size: 13px; color: var(--ink3); max-width: 680px; line-height: 1.6; }

/* Matrix wrapper */
.matrix-block { display: flex; flex-direction: column; gap: 6px; }

.matrix-label {
  display: flex; align-items: center; gap: 10px;
  margin-bottom: 4px;
}
.ml-badge {
  display: inline-flex; align-items: center; gap: 6px;
  padding: 4px 12px; border-radius: 20px;
  font-size: 11px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase;
  color: #fff;
}
.ml-badge.harms   { background: #c41e3a; }
.ml-badge.benefits{ background: #1a7a3e; }
.ml-sub {
  font-size: 12px; color: var(--ink3); font-style: italic;
}

/* ═══════════════════════════════════════════════════════════════
   MATRIX TABLE
═══════════════════════════════════════════════════════════════ */
.matrix-wrap { overflow-x: auto; border-radius: 10px; box-shadow: 0 2px 16px rgba(0,0,0,.08); }

.matrix-table {
  width: 100%; border-collapse: separate; border-spacing: 0;
  font-size: 13px; min-width: 700px;
}

/* Column widths */
.matrix-table colgroup .col-row  { width: 13%; }
.matrix-table colgroup .col-cell { width: 29%; }

/* ── Header row ── */
.matrix-table thead tr th {
  padding: 13px 16px;
  font-size: 12px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase;
  text-align: left;
  border-bottom: 2px solid rgba(255,255,255,.2);
}
.matrix-table thead tr th:first-child {
  border-radius: 10px 0 0 0;
  width: 14%;
}
.matrix-table thead tr th:last-child {
  border-radius: 0 10px 0 0;
}

/* SA header colours */
.sa-tbl thead th            { background: var(--sa-hdr); color: var(--sa-hdr-txt); }
.sa-tbl thead th.col-header { background: var(--sa-hdr2); }

/* HV header colours */
.hv-tbl thead th            { background: var(--hv-hdr); color: var(--hv-hdr-txt); }
.hv-tbl thead th.col-header { background: var(--hv-hdr2); }

/* ── Row label cell ── */
.row-label {
  font-weight: 700; font-size: 12px;
  letter-spacing: .04em; text-transform: uppercase;
  padding: 16px 14px;
  vertical-align: top;
  white-space: nowrap;
  border-right: 2px solid rgba(255,255,255,.18);
}
.sa-tbl .row-label.r-harm    { background: var(--sa-row-a); color: var(--sa-row-txt); }
.sa-tbl .row-label.r-benefit { background: var(--sa-row-b); color: var(--sa-row-txt); }
.hv-tbl .row-label.r-harm    { background: var(--hv-row-a); color: var(--hv-row-txt); }
.hv-tbl .row-label.r-benefit { background: var(--hv-row-b); color: var(--hv-row-txt); }

/* Rotate label text vertically */
.row-label-inner {
  writing-mode: vertical-rl;
  text-orientation: mixed;
  transform: rotate(180deg);
  display: block;
  min-height: 80px;
  display: flex; align-items: center; justify-content: center;
}

/* ── Data cells ── */
.matrix-table tbody td {
  padding: 14px 16px;
  vertical-align: top;
  border-bottom: 1px solid var(--rule-light);
  border-right: 1px solid var(--rule-light);
  line-height: 1.55;
  color: var(--ink2);
}
.matrix-table tbody td:last-child { border-right: none; }

/* Alternating stripe */
.sa-tbl tbody tr:nth-child(even) td:not(.row-label) { background: var(--sa-stripe); }
.sa-tbl tbody tr:nth-child(odd)  td:not(.row-label) { background: var(--white); }
.hv-tbl tbody tr:nth-child(even) td:not(.row-label) { background: var(--hv-stripe); }
.hv-tbl tbody tr:nth-child(odd)  td:not(.row-label) { background: var(--white); }

/* Last row rounded corners */
.matrix-table tbody tr:last-child td:first-child { border-radius: 0 0 0 10px; }
.matrix-table tbody tr:last-child td:last-child  { border-radius: 0 0 10px 0; }

/* Cell bullet list */
.cell-list {
  list-style: none; padding: 0; margin: 0;
  display: flex; flex-direction: column; gap: 6px;
}
.cell-list li {
  display: flex; align-items: flex-start; gap: 7px;
  font-size: 12.5px; line-height: 1.5; color: var(--ink2);
}
.cell-list li::before {
  content: '';
  width: 6px; height: 6px; border-radius: 50%;
  margin-top: 5px; flex-shrink: 0;
}
.sa-tbl .r-harm   + td .cell-list li::before,
.sa-tbl .r-benefit + td .cell-list li::before { background: var(--sa-accent); }
.hv-tbl .r-harm   + td .cell-list li::before,
.hv-tbl .r-benefit + td .cell-list li::before { background: var(--hv-accent); }

/* Fix: any cell in a sa-tbl / hv-tbl row */
.sa-tbl .cell-list li::before { background: var(--sa-accent); }
.hv-tbl .cell-list li::before { background: var(--hv-accent); }

/* Severity badge inside cells */
.severity {
  display: inline-flex; align-items: center; gap: 4px;
  font-size: 10px; font-weight: 700; letter-spacing: .05em; text-transform: uppercase;
  padding: 2px 8px; border-radius: 10px; margin-bottom: 6px;
}
.sev-high   { background: #fde8e8; color: #b91c1c; }
.sev-medium { background: #fef3cd; color: #92400e; }
.sev-low    { background: #d1fae5; color: #065f46; }
.sev-pos    { background: #dbeafe; color: #1d4ed8; }

/* ═══════════════════════════════════════════════════════════════
   DIVIDER
═══════════════════════════════════════════════════════════════ */
.section-divider {
  border: none;
  border-top: 1px solid var(--rule);
  margin: 0;
}

/* ═══════════════════════════════════════════════════════════════
   FOOTNOTE / FOOTER
═══════════════════════════════════════════════════════════════ */
.page-footer {
  background: var(--ink);
  color: rgba(255,255,255,.5);
  text-align: center;
  padding: 24px var(--pad);
  font-size: 11px; letter-spacing: .04em;
}
.page-footer strong { color: rgba(255,255,255,.8); }

/* ═══════════════════════════════════════════════════════════════
   PRINT
═══════════════════════════════════════════════════════════════ */
@media print {
  .nav-tabs, .print-btn-wrap { display: none !important; }
  body { background: #fff; font-size: 11px; }
  .main-content { padding: 10px 0; gap: 32px; }
  .page-header { padding: 20px 16px; }
  .matrix-wrap { box-shadow: none; }
  .matrix-table { min-width: 0 !important; font-size: 10px; }
  .matrix-table tbody td { padding: 9px 10px; }
  .cell-list li { font-size: 10px; }
}

/* ═══════════════════════════════════════════════════════════════
   PRINT BUTTON
═══════════════════════════════════════════════════════════════ */
.print-btn-wrap {
  display: flex; justify-content: flex-end;
  max-width: var(--page-max); margin: 0 auto;
  padding: 12px var(--pad) 0;
}
.print-btn {
  display: inline-flex; align-items: center; gap: 8px;
  padding: 9px 20px; border-radius: 8px;
  background: var(--ink2); color: #fff;
  border: none; cursor: pointer;
  font-family: var(--font-body); font-size: 12px; font-weight: 600;
  letter-spacing: .03em; text-transform: uppercase;
  transition: background .15s, transform .1s;
}
.print-btn:hover  { background: var(--ink); }
.print-btn:active { transform: scale(.97); }

/* ═══════════════════════════════════════════════════════════════
   RESPONSIVE
═══════════════════════════════════════════════════════════════ */
@media (max-width: 768px) {
  :root { --pad: 18px; }
  .ph-meta { align-items: flex-start; }
  .row-label-inner { writing-mode: horizontal-tb; transform: none; min-height: auto; font-size: 11px; }
  .row-label { white-space: normal; min-width: 80px; }
}
@media (max-width: 500px) {
  :root { --pad: 12px; }
  .section-heading { flex-direction: column; }
  .ph-title { font-size: 20px; }
}
</style>
</head>
<body>

<!-- ══════════════════════════════════════════════════════════
     PAGE HEADER
══════════════════════════════════════════════════════════ -->
<div class="page-header">
  <div class="ph-inner">
    <div class="ph-left">
      <div class="ph-kicker">AIoniser Platform &nbsp;·&nbsp; Evolve Ltd &nbsp;·&nbsp; Kigali, Rwanda</div>
      <h1 class="ph-title">Social Impact Assessment<br>Matrix Report</h1>
      <p class="ph-subtitle">
        A structured evaluation of social harms and benefits arising from two AI-powered public-service platforms:
        <strong>SmartAttorney AI</strong> and the <strong>Rwanda HIV Clinical Guidelines Assistant</strong>.
        Methodology follows the Social Impact Matrix framework (Assessing Harms &amp; Amplifying Benefits).
      </p>
    </div>
    <div class="ph-meta">
      <div class="ph-meta-badge">Prepared by <strong>Gacirane Patrick</strong></div>
      <div class="ph-meta-badge">Framework: <strong>Social Impact Matrix</strong></div>
      <div class="ph-meta-badge">Year: <strong>2026</strong></div>
      <div class="ph-meta-badge">Context: <strong>Rwanda / East Africa</strong></div>
    </div>
  </div>
</div>

<!-- ══════════════════════════════════════════════════════════
     STICKY NAVIGATION
══════════════════════════════════════════════════════════ -->
<nav class="nav-tabs" aria-label="Jump to section">
  <div class="nav-tabs-inner">
    <a class="nav-tab sa" href="#smartattorney">
      <span class="tab-icon">⚖️</span> SmartAttorney AI
    </a>
    <a class="nav-tab hv" href="#hivguidelines">
      <span class="tab-icon">🏥</span> HIV Guidelines Assistant
    </a>
  </div>
</nav>

<div class="print-btn-wrap">
  <button class="print-btn" onclick="window.print()">🖨 Print / Export PDF</button>
</div>

<!-- ══════════════════════════════════════════════════════════
     MAIN CONTENT
══════════════════════════════════════════════════════════ -->
<main class="main-content">

  <!-- ────────────────────────────────────────────────────────
       1. SMARTATTORNEY AI
  ──────────────────────────────────────────────────────── -->
  <section id="smartattorney" class="assessment-section">

    <div class="section-heading sa">
      <div class="sh-icon">⚖️</div>
      <div class="sh-text">
        <div class="sh-kicker">Case 1 &nbsp;·&nbsp; Legal Technology</div>
        <h2 class="sh-title">SmartAttorney AI — Legal Compliance Assistant</h2>
        <p class="sh-desc">
          A multi-agent AI system providing legal guidance, regulatory compliance support, and
          jurisdiction-specific legal advice across Rwanda and East Africa. Deployed as a
          natural-language interface accessible by individuals, SMEs, and public institutions.
        </p>
      </div>
    </div>

    <!-- ── HARMS MATRIX ── -->
    <div class="matrix-block">
      <div class="matrix-label">
        <span class="ml-badge harms">⚠ Assessing Harms</span>
        <span class="ml-sub">Potential negative social impacts of AI-generated legal guidance</span>
      </div>

      <div class="matrix-wrap">
        <table class="matrix-table sa-tbl" aria-label="SmartAttorney Harms Matrix">
          <colgroup>
            <col class="col-row"/>
            <col class="col-cell"/>
            <col class="col-cell"/>
            <col class="col-cell"/>
          </colgroup>
          <thead>
            <tr>
              <th>Dimension</th>
              <th class="col-header">Individual</th>
              <th class="col-header">Collective</th>
              <th class="col-header">Societal</th>
            </tr>
          </thead>
          <tbody>

            <tr>
              <td class="row-label r-harm"><span class="row-label-inner">Type of Harm</span></td>
              <td>
                <span class="severity sev-high">● High</span>
                <ul class="cell-list">
                  <li>Reliance on AI legal advice without professional verification, leading to adverse legal outcomes in court proceedings or contract disputes</li>
                  <li>Misinterpretation of jurisdiction-specific laws (e.g. Rwandan vs. Kenyan regulations) causing incorrect compliance actions</li>
                  <li>Denial of individual rights through inaccurate guidance on labour law, property rights, or criminal procedures</li>
                  <li>Erosion of legal literacy as citizens substitute AI responses for genuine understanding of the law</li>
                </ul>
              </td>
              <td>
                <span class="severity sev-medium">● Medium</span>
                <ul class="cell-list">
                  <li>SMEs and community organisations acting uniformly on incorrect AI-generated legal templates, amplifying errors at scale</li>
                  <li>Marginalised groups (women, rural communities, informal workers) disproportionately harmed when AI produces guidance biased toward formal urban legal contexts</li>
                  <li>Collective erosion of trust in digital government services if AI advice leads to visible legal failures</li>
                </ul>
              </td>
              <td>
                <span class="severity sev-high">● High</span>
                <ul class="cell-list">
                  <li>Undermining the rule of law if AI legal guidance inconsistently applies regulations, creating confusion about legal standards</li>
                  <li>Displacement of qualified legal professionals, reducing access to nuanced human advocacy over time</li>
                  <li>Reinforcing existing inequalities if the tool is inaccessible to populations without smartphones or internet</li>
                  <li>Risk of foreign legal frameworks inadvertently displacing Rwandan jurisprudence in AI training data</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-harm"><span class="row-label-inner">Source of Harm</span></td>
              <td>
                <ul class="cell-list">
                  <li>Hallucination of legal citations — AI fabricates case references or legislative sections that do not exist</li>
                  <li>Outdated legal knowledge where training data does not reflect recent legislative amendments</li>
                  <li>Language and translation errors for users querying in Kinyarwanda or Swahili</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Homogeneous advice generation causing collective legal errors across similarly-situated groups</li>
                  <li>Lack of cultural and customary law sensitivity — AI trained predominantly on English-language formal legal sources</li>
                  <li>No mechanism for community-level feedback to correct systematic errors</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Regulatory gap: no specific legal framework in Rwanda governing AI-generated legal advice as of 2026</li>
                  <li>Commercial LLM providers (e.g. OpenAI) having limited accountability under Rwandan jurisdiction</li>
                  <li>Concentration of AI legal tools in urban centres, deepening rural-urban access divide</li>
                  <li>Insufficient AI auditing standards in East African legal technology sector</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-harm"><span class="row-label-inner">Measure of Harm</span></td>
              <td>
                <ul class="cell-list">
                  <li>Number of cases where users acted on incorrect AI advice and suffered legal consequences (false positive / negative rate)</li>
                  <li>Rate of AI hallucination per 100 queries in law-specific benchmarks</li>
                  <li>User satisfaction and complaint frequency tracked via platform analytics</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Volume of incorrectly-filed business registrations or contract templates attributed to AI errors</li>
                  <li>Number of communities reporting disproportionate adverse outcomes from AI legal guidance</li>
                  <li>Survey-based digital trust index among target user groups</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Percentage reduction in formally-qualified legal professionals serving low-income populations</li>
                  <li>Number of legislative or judicial challenges related to AI-generated legal documents</li>
                  <li>Breadth of digital divide in AI legal service access (rural vs. urban penetration rate)</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-harm"><span class="row-label-inner">Mitigation of Harm</span></td>
              <td>
                <ul class="cell-list">
                  <li>Prominent AI disclaimer on every response: <em>"This is AI-generated guidance — always verify with a qualified attorney"</em></li>
                  <li>Mandatory source citation: all advice must reference specific laws, articles, or regulations</li>
                  <li>2 queries/day limit to discourage over-reliance and promote professional consultation</li>
                  <li>Multilingual support (Kinyarwanda, French, Swahili) to reduce translation-induced errors</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Community legal aid partnerships — refer complex queries to Rwanda Bar Association or Legal Aid Forum</li>
                  <li>Periodic bulk-output audits by legal professionals to identify systemic error patterns</li>
                  <li>Inclusive design testing with rural, women-led, and informal-economy user groups before wide deployment</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Engage Rwanda Utilities Regulatory Authority (RURA) and Ministry of Justice to develop AI legal advice governance framework</li>
                  <li>Publish model cards and quarterly bias audits under open-access policy</li>
                  <li>Offline mode / USSD access pathway to extend reach to users without smartphones</li>
                  <li>Human-in-the-loop escalation protocol for high-stakes queries (land rights, criminal matters)</li>
                </ul>
              </td>
            </tr>

          </tbody>
        </table>
      </div>
    </div><!-- /harms matrix -->

    <!-- ── BENEFITS MATRIX ── -->
    <div class="matrix-block">
      <div class="matrix-label">
        <span class="ml-badge benefits">✦ Amplifying Benefits</span>
        <span class="ml-sub">Positive social value generated by AI-powered legal access</span>
      </div>

      <div class="matrix-wrap">
        <table class="matrix-table sa-tbl" aria-label="SmartAttorney Benefits Matrix">
          <colgroup>
            <col class="col-row"/>
            <col class="col-cell"/>
            <col class="col-cell"/>
            <col class="col-cell"/>
          </colgroup>
          <thead>
            <tr>
              <th>Dimension</th>
              <th class="col-header">Individual</th>
              <th class="col-header">Collective</th>
              <th class="col-header">Societal</th>
            </tr>
          </thead>
          <tbody>

            <tr>
              <td class="row-label r-benefit"><span class="row-label-inner">Type of Benefit</span></td>
              <td>
                <span class="severity sev-pos">● High Value</span>
                <ul class="cell-list">
                  <li>Democratised access to legal information — individuals who cannot afford lawyers gain instant, free guidance</li>
                  <li>Empowerment of entrepreneurs registering businesses, understanding labour rights, or drafting contracts</li>
                  <li>Reduced anxiety and time burden for citizens navigating unfamiliar legal processes</li>
                  <li>Multilingual support enables non-English speakers to access legal information in their first language</li>
                </ul>
              </td>
              <td>
                <span class="severity sev-pos">● High Value</span>
                <ul class="cell-list">
                  <li>SME ecosystem strengthened through accessible compliance guidance, reducing regulatory violations</li>
                  <li>Community organisations and cooperatives better equipped to manage legal obligations</li>
                  <li>Rural communities gain equivalent access to legal knowledge previously only available in cities</li>
                </ul>
              </td>
              <td>
                <span class="severity sev-pos">● High Value</span>
                <ul class="cell-list">
                  <li>Contribution to Rwanda's Vision 2050 knowledge economy goals through digital legal infrastructure</li>
                  <li>Reduction of court backlog as citizens resolve minor disputes or clarify rights without litigation</li>
                  <li>Improved investor confidence through consistent, accessible regulatory compliance information</li>
                  <li>Advancement of East Africa AI governance leadership through responsible deployment model</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-benefit"><span class="row-label-inner">Source of Benefit</span></td>
              <td>
                <ul class="cell-list">
                  <li>24/7 availability — legal guidance accessible outside office hours and without travel to urban centres</li>
                  <li>Zero marginal cost per query enabling free access at point of use</li>
                  <li>Natural language interface lowering technical and literacy barriers</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Multi-jurisdictional knowledge base covering Rwanda, Kenya, Uganda, Tanzania simultaneously</li>
                  <li>Scalability allowing simultaneous service to thousands of users, unlike individual lawyers</li>
                  <li>Integration with CrewAI multi-agent pipeline ensuring cross-checking of retrieved legal information</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Alignment with Rwanda's National Digital Transformation Policy and Smart Africa agenda</li>
                  <li>Platform generates structured data on most common legal queries, informing policy prioritisation</li>
                  <li>Open-source deployment model allows government adaptation and localisation</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-benefit"><span class="row-label-inner">Measure of Benefit</span></td>
              <td>
                <ul class="cell-list">
                  <li>Number of unique users successfully completing a legal compliance action after AI guidance</li>
                  <li>User-reported confidence score pre/post interaction (self-assessed legal literacy)</li>
                  <li>Time saved per user compared to seeking traditional legal consultation</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Number of SMEs achieving successful regulatory filings attributable to AI guidance</li>
                  <li>Geographic distribution of active users (urban vs. rural ratio)</li>
                  <li>Volume of queries from underserved languages (Kinyarwanda, Swahili) as proxy for inclusion</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Reduction in minor civil cases brought to magistrate courts in served districts</li>
                  <li>Ministry of Justice adoption of query-data insights for law reform priorities</li>
                  <li>Platform cited in regional AI governance frameworks as responsible deployment case study</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-benefit"><span class="row-label-inner">Amplification of Benefit</span></td>
              <td>
                <ul class="cell-list">
                  <li>Integration with MyCV assistant to provide employment law and contract review guidance to job seekers</li>
                  <li>Personalised follow-up queries enabled through session memory for complex multi-step legal needs</li>
                  <li>PDF export of AI-generated legal summaries for use in formal submissions</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Partnerships with Rwanda Cooperative Agency, RDB, and sector regulators to embed AI guidance in onboarding workflows</li>
                  <li>Train-the-trainer programme enabling community paralegals to use SmartAttorney as a reference tool</li>
                  <li>Integration with Bank CRM Advisory for business financing compliance queries</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>MINICT funding pathways under Pre-Commercial Procurement (PCP) framework to scale to national deployment</li>
                  <li>East African Community (EAC) cross-border harmonisation of AI legal guidance standards</li>
                  <li>Academic partnership with University of Rwanda Law Faculty for continuous model improvement and bias research</li>
                  <li>Feed anonymised query patterns into Rwanda Law Reform Commission to surface legislative gaps</li>
                </ul>
              </td>
            </tr>

          </tbody>
        </table>
      </div>
    </div><!-- /benefits matrix -->

  </section><!-- /SmartAttorney -->

  <hr class="section-divider"/>

  <!-- ────────────────────────────────────────────────────────
       2. HIV GUIDELINES ASSISTANT
  ──────────────────────────────────────────────────────── -->
  <section id="hivguidelines" class="assessment-section">

    <div class="section-heading hv">
      <div class="sh-icon">🏥</div>
      <div class="sh-text">
        <div class="sh-kicker">Case 2 &nbsp;·&nbsp; Clinical Health Technology</div>
        <h2 class="sh-title">Rwanda HIV Clinical Guidelines Assistant</h2>
        <p class="sh-desc">
          A RAG-powered multi-agent AI system providing clinicians, health workers, and patients with
          accurate, verifiable guidance drawn exclusively from the Rwanda HIV Clinical Guidelines 2022
          (Rwanda Biomedical Centre). Deployed to support ART regimen selection, PMTCT protocols,
          paediatric care, and viral load monitoring.
        </p>
      </div>
    </div>

    <!-- ── HARMS MATRIX ── -->
    <div class="matrix-block">
      <div class="matrix-label">
        <span class="ml-badge harms">⚠ Assessing Harms</span>
        <span class="ml-sub">Potential negative social impacts of AI-assisted clinical guidance</span>
      </div>

      <div class="matrix-wrap">
        <table class="matrix-table hv-tbl" aria-label="HIV Guidelines Harms Matrix">
          <colgroup>
            <col class="col-row"/>
            <col class="col-cell"/>
            <col class="col-cell"/>
            <col class="col-cell"/>
          </colgroup>
          <thead>
            <tr>
              <th>Dimension</th>
              <th class="col-header">Individual</th>
              <th class="col-header">Collective</th>
              <th class="col-header">Societal</th>
            </tr>
          </thead>
          <tbody>

            <tr>
              <td class="row-label r-harm"><span class="row-label-inner">Type of Harm</span></td>
              <td>
                <span class="severity sev-high">● Critical Risk</span>
                <ul class="cell-list">
                  <li>Incorrect ART regimen guidance leading to treatment failure, drug resistance, or patient harm</li>
                  <li>Missed or incorrect PMTCT protocol resulting in mother-to-child HIV transmission</li>
                  <li>Patient self-medication based on misunderstood AI responses without clinician validation</li>
                  <li>Disclosure risk — sensitive HIV status information inferred from query patterns if platform data is compromised</li>
                  <li>Stigma amplification if AI responses inadvertently frame HIV in discriminatory language</li>
                </ul>
              </td>
              <td>
                <span class="severity sev-high">● Critical Risk</span>
                <ul class="cell-list">
                  <li>Health worker over-reliance reducing clinical reasoning skills over time, particularly in resource-limited rural facilities</li>
                  <li>Community health workers (CHWs) applying AI guidance outside their competency scope, causing collective treatment errors</li>
                  <li>Differential AI access between well-resourced urban hospitals and rural health posts exacerbating care inequity</li>
                </ul>
              </td>
              <td>
                <span class="severity sev-high">● Critical Risk</span>
                <ul class="cell-list">
                  <li>Erosion of clinician authority and trust in national HIV programme if AI contradicts official guidance</li>
                  <li>Undermining Rwanda's world-leading HIV treatment outcomes (≥95% viral suppression) through AI-introduced variance</li>
                  <li>Regulatory risk: no validated AI medical advice framework under Rwanda Medical and Dental Practitioners Council as of 2026</li>
                  <li>Stigmatisation of PLHIV communities if AI data is misused in profiling or insurance decisions</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-harm"><span class="row-label-inner">Source of Harm</span></td>
              <td>
                <ul class="cell-list">
                  <li>RAG retrieval failure — incorrect document chunks returned leading to contextually wrong clinical answers</li>
                  <li>Outdated guideline version: RBC Guidelines updated periodically but ChromaDB index may lag</li>
                  <li>Model hallucination: LLM synthesises plausible-sounding but fabricated drug dosage or interaction data</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Single knowledge source (RBC 2022) creates blind spots where local adaptation or WHO updates are not reflected</li>
                  <li>No paediatric weight-based dosing calculator in current MVP, increasing risk of CHW dosing errors for children</li>
                  <li>English-primary interface creates barriers for French or Kinyarwanda-speaking clinical staff</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Platform not yet subject to Rwanda FDA or MoH digital health technology review</li>
                  <li>Data residency: queries to OpenAI API may process sensitive health questions outside Rwandan jurisdiction</li>
                  <li>Lack of interoperability with Rwanda's national HMIS (e.g. DHIS2) limits clinical oversight of AI usage patterns</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-harm"><span class="row-label-inner">Measure of Harm</span></td>
              <td>
                <ul class="cell-list">
                  <li>Clinical accuracy rate per query type (ART selection, dosing, prophylaxis) vs. gold-standard clinical benchmark</li>
                  <li>Rate of AI responses flagged by clinical reviewers as potentially harmful per 100 queries</li>
                  <li>Number of patient safety incidents attributable to AI guidance errors (adverse event tracking)</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Proportion of facilities using AI without a clinical supervisor review layer in place</li>
                  <li>Rural-urban differential in AI guidance quality and accuracy scores</li>
                  <li>Survey-based clinician dependency index: reduced self-confidence in clinical decision-making over time</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Rwanda national HIV programme KPIs: viral load suppression rate, MTCT rate, treatment defaulter rate (monitored for AI-attributable variance)</li>
                  <li>Number of regulatory interventions or policy alerts issued by RBC / MoH regarding AI clinical tools</li>
                  <li>Volume of privacy complaints or data breach incidents linked to platform queries</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-harm"><span class="row-label-inner">Mitigation of Harm</span></td>
              <td>
                <ul class="cell-list">
                  <li>Mandatory clinical disclaimer on every response: <em>"Always apply clinical judgement. Consult RBC guidelines directly for prescribing decisions."</em></li>
                  <li>Source-grounded RAG: every response cites specific page and section of RBC Guidelines 2022</li>
                  <li>Strict 2 queries/day rate limit to prevent dependency and promote professional consultation</li>
                  <li>Automated guideline version monitoring — ChromaDB index re-indexed within 48 hours of RBC guideline updates</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Mandatory clinical supervisor review layer for community health worker deployments</li>
                  <li>Training module for all clinical users distinguishing AI as a reference tool vs. diagnostic system</li>
                  <li>Bilingual interface (English and Kinyarwanda) with validated clinical translation</li>
                  <li>Paediatric dosing calculator module as priority V2 feature to close critical gap</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Formal regulatory submission to Rwanda MoH Digital Health Unit and Rwanda FDA for AI clinical tool classification</li>
                  <li>Data processing agreement with OpenAI specifying Rwanda health data protection requirements</li>
                  <li>Quarterly independent clinical audit of AI response accuracy by RBC-appointed reviewers</li>
                  <li>DHIS2 API integration pilot to enable anonymous query-pattern monitoring at facility level</li>
                </ul>
              </td>
            </tr>

          </tbody>
        </table>
      </div>
    </div><!-- /harms -->

    <!-- ── BENEFITS MATRIX ── -->
    <div class="matrix-block">
      <div class="matrix-label">
        <span class="ml-badge benefits">✦ Amplifying Benefits</span>
        <span class="ml-sub">Positive social value of AI-assisted HIV clinical decision support</span>
      </div>

      <div class="matrix-wrap">
        <table class="matrix-table hv-tbl" aria-label="HIV Guidelines Benefits Matrix">
          <colgroup>
            <col class="col-row"/>
            <col class="col-cell"/>
            <col class="col-cell"/>
            <col class="col-cell"/>
          </colgroup>
          <thead>
            <tr>
              <th>Dimension</th>
              <th class="col-header">Individual</th>
              <th class="col-header">Collective</th>
              <th class="col-header">Societal</th>
            </tr>
          </thead>
          <tbody>

            <tr>
              <td class="row-label r-benefit"><span class="row-label-inner">Type of Benefit</span></td>
              <td>
                <span class="severity sev-pos">● High Value</span>
                <ul class="cell-list">
                  <li>Clinicians gain instant, verified access to ART regimen guidance without navigating 200+ page PDF documents</li>
                  <li>Nurses and midwives in rural health posts supported with PMTCT and paediatric protocols beyond their training scope</li>
                  <li>PLHIV individuals access plain-language explanations of their treatment regimen, improving adherence</li>
                  <li>Reduced cognitive burden on health workers managing complex co-morbidities (TB-HIV, PMTCT, OIs)</li>
                </ul>
              </td>
              <td>
                <span class="severity sev-pos">● High Value</span>
                <ul class="cell-list">
                  <li>Standardised protocol application across all facilities reduces geographic variation in HIV care quality</li>
                  <li>Community health workers equipped to provide accurate first-line counselling on HIV testing and treatment</li>
                  <li>Health facilities in under-staffed districts gain 24/7 decision support equivalent to specialist consultation</li>
                </ul>
              </td>
              <td>
                <span class="severity sev-pos">● High Value</span>
                <ul class="cell-list">
                  <li>Contribution to Rwanda achieving and sustaining UNAIDS 95-95-95 targets through improved treatment adherence</li>
                  <li>Reduced treatment failure rates lower downstream costs of second- and third-line ART regimens</li>
                  <li>Rwanda positioned as a global leader in responsible AI deployment in public health</li>
                  <li>Open-source knowledge that can be replicated for other disease-specific guidelines (TB, malaria, NCDs)</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-benefit"><span class="row-label-inner">Source of Benefit</span></td>
              <td>
                <ul class="cell-list">
                  <li>1,015-chunk ChromaDB vector index of full RBC HIV Guidelines 2022 enabling precise retrieval</li>
                  <li>Agentic document parsing via LandingAI ensuring high-fidelity extraction of clinical tables and dosing charts</li>
                  <li>Two-stage RAG pipeline (context creation + search prompt generation) maximising answer accuracy</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Scalable architecture — concurrent query handling enables national-level access without infrastructure bottleneck</li>
                  <li>FastAPI + SSE streaming provides real-time response for time-sensitive clinical queries</li>
                  <li>HuggingFace Spaces deployment ensures global accessibility from any device with internet</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Institutional partnership with Rwanda Biomedical Centre as authoritative knowledge source</li>
                  <li>Alignment with Africa CDC Digital Health Strategy and Smart Africa Health AI roadmap</li>
                  <li>Academic publication potential — documenting RAG-based clinical AI methodology for African health systems</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-benefit"><span class="row-label-inner">Measure of Benefit</span></td>
              <td>
                <ul class="cell-list">
                  <li>Clinical accuracy score per query category (ART, PMTCT, paediatric, OI) vs. specialist clinician review</li>
                  <li>Time-to-answer for clinical queries: AI (&lt;10 seconds) vs. manual guideline search (5–15 minutes)</li>
                  <li>Health worker satisfaction and perceived usefulness score (Likert scale, quarterly survey)</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Inter-facility variation in ART regimen adherence to national protocol (before/after AI introduction)</li>
                  <li>Geographic reach: proportion of Rwanda's 47 districts with active AI platform users</li>
                  <li>CHW training completion rates and post-training competency scores for AI-assisted protocols</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Rwanda's viral load suppression rate trends (annual MoH HIV programme report)</li>
                  <li>MTCT rate reduction in facilities where AI decision support is deployed vs. control group</li>
                  <li>Number of other African countries adopting the RAG-clinical AI model (replication index)</li>
                </ul>
              </td>
            </tr>

            <tr>
              <td class="row-label r-benefit"><span class="row-label-inner">Amplification of Benefit</span></td>
              <td>
                <ul class="cell-list">
                  <li>Integration with patient-facing health companion app (AI health companion as highest-priority AIoniser MVP per 2026 analysis)</li>
                  <li>Personalised treatment adherence support: AI answers patient questions about side effects, dosing schedules, and interactions</li>
                  <li>Expansion to French-language responses for PLHIV in francophone communities</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Pilot with Rwanda Community Health Worker programme (Binome programme) to embed AI in CHW referral workflows</li>
                  <li>Link to National HIV Programme data systems (HMIS, viral load database) to contextualise responses with facility-level data</li>
                  <li>Peer-learning networks of facility nurses sharing AI use cases across districts via WhatsApp/Telegram integration</li>
                </ul>
              </td>
              <td>
                <ul class="cell-list">
                  <li>Scale to full Rwanda MoH endorsement under the National eHealth Strategic Plan 2023–2028</li>
                  <li>Replicate knowledge base for WHO AFRO consolidated guidelines to serve 47 African Member States</li>
                  <li>Pre-Commercial Procurement (PCP) proposal to MINICT for RWF 89.5M sandbox financing under Ministerial Order No. 001/26/10/TC</li>
                  <li>Peer-reviewed publication documenting Rwanda as first African country with nationally-deployed RAG clinical AI for HIV</li>
                </ul>
              </td>
            </tr>

          </tbody>
        </table>
      </div>
    </div><!-- /benefits -->

  </section><!-- /HIV Guidelines -->

</main><!-- /main-content -->

<footer class="page-footer">
  <strong>AIoniser Platform — Social Impact Assessment Report</strong> &nbsp;|&nbsp;
  Evolve Ltd, Kigali, Rwanda &nbsp;|&nbsp;
  Prepared by Gacirane Patrick &nbsp;|&nbsp;
  © 2026 &nbsp;|&nbsp;
  Methodology: Social Impact Matrix (Assessing Harms &amp; Amplifying Benefits)
</footer>

</body>
</html>
