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
<title>Social Impact Assessment — AIonifier Platform</title>
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet"/>
<style>
:root {
  /* ── Dashboard-matched dark tokens ── */
  --bg:         #0b0f1a;
  --surface:    #131929;
  --surface2:   #0d1117;
  --border:     rgba(255,255,255,0.07);
  --border2:    rgba(255,255,255,0.10);
  --text:       #eef2ff;
  --text2:      #8892a4;
  --text3:      #545d75;
  --green:      #4ade80;

  /* page / white → surface */
  --page:       #0b0f1a;
  --white:      #131929;
  --rule:       rgba(255,255,255,0.10);
  --rule-light: rgba(255,255,255,0.06);
  --ink:        #eef2ff;
  --ink2:       #8892a4;
  --ink3:       #545d75;

  /* SmartAttorney table — cobalt → green-tinted dark */
  --sa-hdr:     #0d2a1a;
  --sa-hdr2:    #173d24;
  --sa-hdr-txt: #4ade80;
  --sa-row-a:   #0d2a1a;
  --sa-row-b:   #112d1e;
  --sa-row-txt: #c6f6d5;
  --sa-stripe:  rgba(74,222,128,0.04);
  --sa-accent:  #4ade80;

  /* HIV Guidelines table — teal → green-tinted dark */
  --hv-hdr:     #0a2218;
  --hv-hdr2:    #0f2e20;
  --hv-hdr-txt: #4ade80;
  --hv-row-a:   #0a2218;
  --hv-row-b:   #0d2a1d;
  --hv-row-txt: #c6f6d5;
  --hv-stripe:  rgba(74,222,128,0.04);
  --hv-accent:  #4ade80;

  --font-display: 'Sora', sans-serif;
  --font-body:    'Sora', sans-serif;
  --page-max:   1280px;
  --pad:        40px;
}
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }
body {
  background: var(--bg);
  color: var(--ink);
  font-family: var(--font-body);
  font-size: 14px;
  line-height: 1.55;
  -webkit-text-size-adjust: 100%;
}

/* ── Page header ── */
.page-header {
  background: linear-gradient(135deg, #0a1628 0%, #0a2463 60%, #1a4a9e 100%);
  color: #eef2ff;
  padding: 14px var(--pad) 12px;
  position: relative; overflow: hidden; width: 100%;
}
.page-header::after {
  content: '';
  position: absolute; bottom: 0; left: 0; right: 0; height: 2px;
  background: linear-gradient(90deg, #4ade80, rgba(74,222,128,0.15), transparent);
}
.ph-inner {
  width: 100%; max-width: var(--page-max); margin: 0 auto;
  display: grid;
  grid-template-columns: auto 1fr auto;
  align-items: center;
  gap: 0 clamp(16px,3vw,40px);
}
.ph-left { display: contents; }
.ph-kicker {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 10px; font-weight: 600;
  letter-spacing: .16em; text-transform: uppercase;
  color: rgba(74,222,128,0.7);
  white-space: nowrap; flex-shrink: 0;
}
.ph-title {
  font-family: 'Sora', sans-serif;
  font-size: clamp(14px,2vw,20px);
  font-weight: 700; line-height: 1.2; color: #eef2ff;
  white-space: nowrap;
}
.ph-subtitle {
  font-size: clamp(10px,1.2vw,12px);
  color: rgba(255,255,255,.60);
  line-height: 1.5; flex: 1;
}

/* ── Sticky nav tabs ── */
.nav-tabs {
  background: var(--white); border-bottom: 1px solid var(--rule);
  padding: 0 var(--pad); position: sticky; top: 0; z-index: 50;
  box-shadow: 0 2px 8px rgba(0,0,0,.06);
}
.nav-tabs-inner {
  max-width: var(--page-max); margin: 0 auto;
  display: flex; gap: 0; overflow-x: auto;
}
.nav-tab {
  display: inline-flex; align-items: center; gap: 7px;
  padding: 14px 20px; font-size: 13px; font-weight: 600;
  color: var(--ink3); text-decoration: none;
  border-bottom: 3px solid transparent;
  transition: color .15s, border-color .15s;
  white-space: nowrap; cursor: pointer;
}
.nav-tab:hover { color: var(--ink); }
.nav-tab.sa { border-bottom-color: var(--sa-accent); color: var(--sa-accent); }
.nav-tab.hv { border-bottom-color: var(--hv-accent); color: var(--hv-accent); }
.nav-tab .tab-icon { font-size: 15px; }

/* ── Main content ── */
.main-content {
  max-width: var(--page-max); margin: 0 auto;
  padding: 44px var(--pad) 64px;
  display: flex; flex-direction: column; gap: 64px;
}
.assessment-section { display: flex; flex-direction: column; gap: 40px; }

/* ── Section heading ── */
.section-heading {
  display: flex; align-items: flex-start; gap: 18px;
  padding-bottom: 20px; border-bottom: 2px solid var(--rule);
}
.section-heading .sh-icon {
  width: 52px; height: 52px; border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  font-size: 26px; flex-shrink: 0;
}
.section-heading.sa .sh-icon { background: linear-gradient(135deg, var(--sa-hdr), var(--sa-hdr2)); }
.section-heading.hv .sh-icon { background: linear-gradient(135deg, var(--hv-hdr), var(--hv-hdr2)); }
.sh-text { flex: 1; }
.sh-kicker { font-size: 11px; font-weight: 600; letter-spacing: .14em; text-transform: uppercase; margin-bottom: 5px; }
.section-heading.sa .sh-kicker { color: var(--sa-accent); }
.section-heading.hv .sh-kicker { color: var(--hv-accent); }
.sh-title { font-family: var(--font-display); font-size: clamp(18px,3vw,26px); font-weight: 700; color: var(--ink); line-height: 1.2; margin-bottom: 6px; }
.sh-desc { font-size: 13px; color: var(--ink3); max-width: 680px; line-height: 1.6; }

/* ── Matrix labels ── */
.matrix-block { display: flex; flex-direction: column; gap: 6px; }
.matrix-label { display: flex; align-items: center; gap: 10px; margin-bottom: 4px; }
.ml-badge {
  display: inline-flex; align-items: center; gap: 6px;
  padding: 4px 12px; border-radius: 20px;
  font-size: 11px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase; color: #131929;
}
.ml-badge.harms    { background: #e05252; }
.ml-badge.benefits { background: #22c55e; }
.ml-sub { font-size: 12px; color: var(--ink3); font-style: italic; }

/* ── Matrix table ── */
.matrix-wrap { overflow-x: auto; border-radius: 10px; box-shadow: 0 2px 16px rgba(0,0,0,.08); }
.matrix-table {
  width: 100%; border-collapse: separate; border-spacing: 0;
  font-size: 13px; min-width: 700px;
}
.matrix-table colgroup .col-row  { width: 13%; }
.matrix-table colgroup .col-cell { width: 29%; }
.matrix-table thead tr th {
  padding: 13px 16px;
  font-size: 12px; font-weight: 700; letter-spacing: .06em; text-transform: uppercase;
  text-align: left; border-bottom: 2px solid rgba(255,255,255,.2);
}
.matrix-table thead tr th:first-child { border-radius: 10px 0 0 0; width: 14%; }
.matrix-table thead tr th:last-child  { border-radius: 0 10px 0 0; }
.sa-tbl thead th            { background: var(--sa-hdr); color: var(--sa-hdr-txt); }
.sa-tbl thead th.col-header { background: var(--sa-hdr2); }
.hv-tbl thead th            { background: var(--hv-hdr); color: var(--hv-hdr-txt); }
.hv-tbl thead th.col-header { background: var(--hv-hdr2); }

/* ── Row labels ── */
.row-label {
  font-weight: 700; font-size: 12px;
  letter-spacing: .04em; text-transform: uppercase;
  padding: 16px 14px; vertical-align: top; white-space: nowrap;
  border-right: 2px solid rgba(255,255,255,.18);
}
.sa-tbl .row-label.r-harm    { background: var(--sa-row-a); color: var(--sa-row-txt); }
.sa-tbl .row-label.r-benefit { background: var(--sa-row-b); color: var(--sa-row-txt); }
.hv-tbl .row-label.r-harm    { background: var(--hv-row-a); color: var(--hv-row-txt); }
.hv-tbl .row-label.r-benefit { background: var(--hv-row-b); color: var(--hv-row-txt); }
.row-label-inner {
  writing-mode: vertical-rl; text-orientation: mixed; transform: rotate(180deg);
  display: flex; align-items: center; justify-content: center; min-height: 80px;
}

/* ── Data cells ── */
.matrix-table tbody td {
  padding: 14px 16px; vertical-align: top;
  border-bottom: 1px solid var(--rule-light);
  border-right: 1px solid var(--rule-light);
  line-height: 1.55; color: var(--ink2);
}
.matrix-table tbody td:last-child { border-right: none; }
.sa-tbl tbody tr:nth-child(even) td:not(.row-label) { background: var(--sa-stripe); }
.sa-tbl tbody tr:nth-child(odd)  td:not(.row-label) { background: var(--white); }
.hv-tbl tbody tr:nth-child(even) td:not(.row-label) { background: var(--hv-stripe); }
.hv-tbl tbody tr:nth-child(odd)  td:not(.row-label) { background: var(--white); }
.matrix-table tbody tr:last-child td:first-child { border-radius: 0 0 0 10px; }
.matrix-table tbody tr:last-child td:last-child  { border-radius: 0 0 10px 0; }

/* ── Cell lists ── */
.cell-list { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 6px; }
.cell-list li { display: flex; align-items: flex-start; gap: 7px; font-size: 12.5px; line-height: 1.5; color: var(--ink2); }
.cell-list li::before { content: ''; width: 6px; height: 6px; border-radius: 50%; margin-top: 5px; flex-shrink: 0; }
.sa-tbl .cell-list li::before { background: var(--sa-accent); }
.hv-tbl .cell-list li::before { background: var(--hv-accent); }

/* ── Severity badges ── */
.severity {
  display: inline-flex; align-items: center; gap: 4px;
  font-size: 10px; font-weight: 700; letter-spacing: .05em; text-transform: uppercase;
  padding: 2px 8px; border-radius: 10px; margin-bottom: 6px;
}
.sev-high   { background: rgba(248,113,113,0.12); color: #dc2626; }
.sev-medium { background: rgba(251,191,36,0.10); color: #92400e; }
.sev-low    { background: rgba(74,222,128,0.10); color: #059669; }
.sev-pos    { background: rgba(96,165,250,0.10); color: #4ade80; }

/* ── Divider ── */
.section-divider { border: none; border-top: 1px solid var(--rule); margin: 0; }

/* ── Print button ── */
.print-btn-wrap { display: flex; justify-content: flex-end; max-width: var(--page-max); margin: 0 auto; padding: 12px var(--pad) 0; }
.print-btn {
  display: inline-flex; align-items: center; gap: 8px;
  padding: 9px 20px; border-radius: 8px; background: var(--ink2); color: #131929;
  border: none; cursor: pointer; font-family: var(--font-body); font-size: 12px; font-weight: 600;
  letter-spacing: .03em; text-transform: uppercase; transition: background .15s, transform .1s;
}
.print-btn:hover  { background: var(--ink); }
.print-btn:active { transform: scale(.97); }


/* ── Responsive ── */
@media print {
  .nav-tabs, .print-btn-wrap { display: none !important; }
  body { background: var(--bg); font-size: 11px; }
  .main-content { padding: 10px 0; gap: 32px; }
  .page-header { padding: 20px 16px; }
  .matrix-wrap { box-shadow: none; }
  .matrix-table { min-width: 0 !important; font-size: 10px; }
  .matrix-table tbody td { padding: 9px 10px; }
  .cell-list li { font-size: 10px; }
}
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

<!-- ── PAGE HEADER ── -->
<div class="page-header">
  <div class="ph-inner">
    <div class="ph-kicker">Social Impact &nbsp;·&nbsp; 2026</div>
    <h1 class="ph-title">Social Impact Assessment Matrix Report</h1>
    <p class="ph-subtitle">
      Evaluation of social harms &amp; benefits for
      <strong>SmartAttorney AI</strong> and the <strong>AI Clinical Guidelines Assistant</strong>
      — Social Impact Matrix methodology.
    </p>
  </div>
</div>

<!-- ── STICKY NAV ── -->
<nav class="nav-tabs" aria-label="Jump to section">
  <div class="nav-tabs-inner">
    <a class="nav-tab sa" href="#smartattorney"><span class="tab-icon">⚖️</span> SmartAttorney AI</a>
    <a class="nav-tab hv" href="#clinicalguidelines"><span class="tab-icon">🏥</span> Clinical Guidelines Assistant</a>
  </div>
</nav>

<div class="print-btn-wrap">
  <button class="print-btn" onclick="window.print()">🖨 Print / Export PDF</button>
</div>

<main class="main-content">

<!-- ════════════════════════════════════════════════════════
     1. SMARTATTORNEY AI
════════════════════════════════════════════════════════ -->
<section id="smartattorney" class="assessment-section">

  <div class="section-heading sa">
    <div class="sh-icon">⚖️</div>
    <div class="sh-text">
      <div class="sh-kicker">Case 1 &nbsp;·&nbsp; Legal Technology</div>
      <h2 class="sh-title">SmartAttorney AI — Legal Compliance Assistant</h2>
      <p class="sh-desc">
        A multi-agent AI system providing legal guidance, regulatory compliance support, and
        jurisdiction-aware advice accessible by individuals, SMEs, civil society organisations,
        and public institutions across any legal system. Deployable as a natural-language
        interface in any language or jurisdiction worldwide.
      </p>
    </div>
  </div>

  <!-- HARMS -->
  <div class="matrix-block">
    <div class="matrix-label">
      <span class="ml-badge harms">⚠ Assessing Harms</span>
      <span class="ml-sub">Potential negative social impacts of AI-generated legal guidance</span>
    </div>
    <div class="matrix-wrap">
      <table class="matrix-table sa-tbl" aria-label="SmartAttorney Harms Matrix">
        <colgroup><col class="col-row"/><col class="col-cell"/><col class="col-cell"/><col class="col-cell"/></colgroup>
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
                <li>Over-reliance on AI legal advice without professional verification, leading to adverse outcomes in disputes, filings, or contracts</li>
                <li>Misapplication of jurisdiction-specific rules — AI may conflate legal systems, causing incorrect compliance decisions</li>
                <li>Denial or misunderstanding of individual rights through inaccurate guidance on labour, property, or criminal matters</li>
                <li>Gradual erosion of personal legal literacy as users substitute AI outputs for genuine understanding of the law</li>
              </ul>
            </td>
            <td>
              <span class="severity sev-medium">● Medium</span>
              <ul class="cell-list">
                <li>Groups adopting standardised but incorrect AI-generated templates amplify errors across entire communities or organisations</li>
                <li>Marginalised populations — including women, informal workers, and linguistic minorities — disproportionately harmed when AI is biased toward dominant legal frameworks</li>
                <li>Collective erosion of trust in digital public services if AI-generated guidance visibly leads to legal failures</li>
              </ul>
            </td>
            <td>
              <span class="severity sev-high">● High</span>
              <ul class="cell-list">
                <li>Inconsistent application of legal rules by AI undermines public understanding of the rule of law</li>
                <li>Displacement of qualified legal professionals over time, reducing access to nuanced human advocacy</li>
                <li>Entrenched inequalities if the tool remains inaccessible to populations without reliable internet or devices</li>
                <li>Risk that dominant-language training data inadvertently overrides local customary or indigenous law</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-harm"><span class="row-label-inner">Source of Harm</span></td>
            <td>
              <ul class="cell-list">
                <li>Hallucination of legal citations — AI fabricates case references, statutes, or regulatory articles that do not exist</li>
                <li>Training data lag — model knowledge does not reflect recent legislative amendments or court rulings</li>
                <li>Translation and interpretation errors for users querying in languages other than the model's primary training language</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Uniform advice generation producing collective legal errors across similarly-situated groups at scale</li>
                <li>Absence of cultural, customary, or indigenous law sensitivity in AI trained predominantly on formal legal corpora</li>
                <li>No community-level feedback mechanism to detect and correct systematic biases in AI outputs</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Regulatory gaps in many jurisdictions — no established framework governing AI-generated legal advice</li>
                <li>Limited accountability of commercial LLM providers under local consumer or professional liability law</li>
                <li>Concentration of access in urban or high-income contexts, widening existing justice gaps</li>
                <li>Absence of cross-jurisdictional AI auditing standards for legal technology</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-harm"><span class="row-label-inner">Measure of Harm</span></td>
            <td>
              <ul class="cell-list">
                <li>Rate of AI responses producing incorrect legal guidance as measured against verified legal benchmarks</li>
                <li>Frequency of user-reported adverse outcomes following AI legal advice (complaint tracking)</li>
                <li>Hallucination rate per 100 queries in domain-specific legal accuracy evaluations</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Volume of incorrectly-filed regulatory documents or contracts attributable to AI template errors</li>
                <li>Proportion of underrepresented communities reporting disproportionate adverse outcomes</li>
                <li>Digital trust index among target user groups measured through periodic surveys</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Reduction in formally-qualified legal professionals serving low-income populations over time</li>
                <li>Number of legislative, judicial, or regulatory challenges related to AI-generated legal documents</li>
                <li>Access gap metric: percentage of target population unable to use the tool due to connectivity or device barriers</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-harm"><span class="row-label-inner">Mitigation of Harm</span></td>
            <td>
              <ul class="cell-list">
                <li>Mandatory prominent disclaimer on every response: <em>"AI-generated guidance — always verify with a qualified attorney before acting"</em></li>
                <li>Source citation requirement: every response must reference the specific statute, regulation, or legal principle invoked</li>
                <li>Daily query limits to discourage sole reliance and encourage professional consultation</li>
                <li>Multi-language support with validated translations to reduce interpretation-induced errors</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Referral pathways to accredited legal aid organisations, bar associations, or ombudsman services for complex queries</li>
                <li>Periodic bulk-output audits by independent legal professionals to detect systematic error patterns</li>
                <li>Co-design testing with diverse user groups — including informal-economy workers, women, and rural communities — before deployment</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Proactive engagement with national bar associations, ministries of justice, and regulatory bodies to develop AI legal advice governance frameworks</li>
                <li>Publication of model cards, training data provenance, and quarterly bias audit reports under open-access policy</li>
                <li>Offline or low-bandwidth access modes to extend reach to underserved populations</li>
                <li>Human-in-the-loop escalation for high-stakes query categories (property rights, criminal matters, family law)</li>
              </ul>
            </td>
          </tr>

        </tbody>
      </table>
    </div>
  </div>

  <!-- BENEFITS -->
  <div class="matrix-block">
    <div class="matrix-label">
      <span class="ml-badge benefits">✦ Amplifying Benefits</span>
      <span class="ml-sub">Positive social value generated by AI-powered legal access</span>
    </div>
    <div class="matrix-wrap">
      <table class="matrix-table sa-tbl" aria-label="SmartAttorney Benefits Matrix">
        <colgroup><col class="col-row"/><col class="col-cell"/><col class="col-cell"/><col class="col-cell"/></colgroup>
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
                <li>Democratised access to legal information for individuals who cannot afford professional legal services</li>
                <li>Empowerment of entrepreneurs, employees, and tenants to understand and assert their rights</li>
                <li>Reduced time, cost, and anxiety for citizens navigating unfamiliar or complex legal processes</li>
                <li>Multi-language support enables speakers of minority or regional languages to access legal guidance in their own language</li>
              </ul>
            </td>
            <td>
              <span class="severity sev-pos">● High Value</span>
              <ul class="cell-list">
                <li>Strengthened SME and civil society ecosystem through accessible, consistent compliance guidance</li>
                <li>Community organisations better equipped to manage contractual and regulatory obligations</li>
                <li>Populations in geographically remote or underserved areas gain equivalent access to legal knowledge available in major cities</li>
              </ul>
            </td>
            <td>
              <span class="severity sev-pos">● High Value</span>
              <ul class="cell-list">
                <li>Contribution to national digital justice and access-to-law policy goals across any jurisdiction</li>
                <li>Potential reduction in court backlog as citizens resolve minor disputes or clarify rights without litigation</li>
                <li>Improved regulatory compliance and investor confidence through consistent, accessible guidance</li>
                <li>Positions deploying governments and organisations as leaders in responsible AI for public services</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-benefit"><span class="row-label-inner">Source of Benefit</span></td>
            <td>
              <ul class="cell-list">
                <li>24/7 availability with zero marginal cost per query, removing time and cost barriers to legal information</li>
                <li>Natural language interface lowering literacy and technical barriers compared to formal legal documentation</li>
                <li>Personalised, context-aware responses that adapt to the user's stated situation and jurisdiction</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Multi-jurisdictional knowledge base enabling cross-border compliance support for international businesses</li>
                <li>Scalable architecture allowing simultaneous service to large user populations without proportional cost increases</li>
                <li>Multi-agent CrewAI pipeline enabling cross-checking of retrieved legal information before response generation</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Alignment with global access-to-justice frameworks including UN SDG 16 (Peace, Justice, Strong Institutions)</li>
                <li>Aggregated, anonymised query data provides governments with real-time insight into legal needs and regulatory gaps</li>
                <li>Open-source deployment model enables government adaptation, localisation, and extension</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-benefit"><span class="row-label-inner">Measure of Benefit</span></td>
            <td>
              <ul class="cell-list">
                <li>Number of users successfully completing a compliance action or resolving a legal question following AI guidance</li>
                <li>User-reported legal confidence score before and after interaction (self-assessed legal literacy)</li>
                <li>Average time saved per user compared to seeking traditional legal consultation</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Number of SMEs and organisations achieving successful regulatory compliance attributable to AI guidance</li>
                <li>Geographic distribution of active users as a proxy for equity of access</li>
                <li>Query volume from non-dominant languages as a proxy for inclusion of linguistic minorities</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Measurable reduction in minor civil cases in jurisdictions where the platform is actively deployed</li>
                <li>Adoption of platform query insights by law reform bodies or ministries to prioritise legislative updates</li>
                <li>Recognition by international legal technology or access-to-justice organisations as a responsible AI model</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-benefit"><span class="row-label-inner">Amplification of Benefit</span></td>
            <td>
              <ul class="cell-list">
                <li>Integration with CV and career advisory AI tools to provide employment law and contract guidance to job seekers globally</li>
                <li>Session memory enabling multi-turn legal consultations for complex, evolving legal needs</li>
                <li>PDF export of AI-generated legal summaries for use in official correspondence or submissions</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Partnerships with legal aid NGOs, bar associations, and regulators to embed AI guidance in public onboarding workflows</li>
                <li>Paralegal and community advocate training programmes using SmartAttorney as a shared reference tool</li>
                <li>Integration with financial advisory AI (e.g. Bank CRM) to support businesses needing combined legal and financial compliance guidance</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Scalable to national public service deployments through government procurement and open-source licensing</li>
                <li>Cross-border harmonisation of AI legal guidance standards through regional trade bodies and international legal organisations</li>
                <li>Academic and policy research partnerships to continuously improve accuracy, fairness, and legal coverage</li>
                <li>Anonymised query pattern data contributed to law reform bodies to surface systemic gaps in public legal knowledge</li>
              </ul>
            </td>
          </tr>

        </tbody>
      </table>
    </div>
  </div>

</section>

<hr class="section-divider"/>

<!-- ════════════════════════════════════════════════════════
     2. CLINICAL GUIDELINES ASSISTANT
════════════════════════════════════════════════════════ -->
<section id="clinicalguidelines" class="assessment-section">

  <div class="section-heading hv">
    <div class="sh-icon">🏥</div>
    <div class="sh-text">
      <div class="sh-kicker">Case 2 &nbsp;·&nbsp; Clinical Health Technology</div>
      <h2 class="sh-title">AI Clinical Guidelines Assistant</h2>
      <p class="sh-desc">
        A RAG-powered multi-agent AI system providing clinicians, health workers, and patients with
        accurate, verifiable guidance drawn from authoritative clinical guidelines applicable to any
        disease area or health system. Deployable for ART, communicable disease, chronic condition,
        maternal health, or any protocol-driven clinical domain worldwide.
      </p>
    </div>
  </div>

  <!-- HARMS -->
  <div class="matrix-block">
    <div class="matrix-label">
      <span class="ml-badge harms">⚠ Assessing Harms</span>
      <span class="ml-sub">Potential negative social impacts of AI-assisted clinical guidance</span>
    </div>
    <div class="matrix-wrap">
      <table class="matrix-table hv-tbl" aria-label="Clinical Guidelines Harms Matrix">
        <colgroup><col class="col-row"/><col class="col-cell"/><col class="col-cell"/><col class="col-cell"/></colgroup>
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
                <li>Incorrect treatment protocol guidance leading to clinical failure, adverse drug reactions, or patient harm</li>
                <li>Patient self-medication or premature treatment changes based on AI responses without clinical validation</li>
                <li>Breach of patient confidentiality if query content reveals sensitive health status to third parties or through data compromise</li>
                <li>Stigma amplification if AI responses frame sensitive conditions (infectious disease, mental health, reproductive health) in discriminatory or stigmatising language</li>
              </ul>
            </td>
            <td>
              <span class="severity sev-high">● Critical Risk</span>
              <ul class="cell-list">
                <li>Health worker over-reliance leading to atrophy of clinical reasoning skills over time, particularly in resource-limited settings</li>
                <li>Community health workers applying AI guidance beyond their authorised competency scope, causing collective clinical errors</li>
                <li>Differential access between well-resourced and under-resourced facilities deepening inequities in care quality</li>
              </ul>
            </td>
            <td>
              <span class="severity sev-high">● Critical Risk</span>
              <ul class="cell-list">
                <li>Erosion of clinician authority and public trust in national health programmes if AI guidance contradicts official protocols</li>
                <li>Risk of undermining hard-won health outcome gains if AI-introduced variance reduces adherence to evidence-based treatment standards</li>
                <li>Absence of validated AI clinical tool frameworks under most national health regulatory bodies as of 2026</li>
                <li>Potential misuse of aggregated health query data for surveillance, profiling, or insurance discrimination</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-harm"><span class="row-label-inner">Source of Harm</span></td>
            <td>
              <ul class="cell-list">
                <li>RAG retrieval failure returning incorrect document chunks, producing contextually wrong clinical answers</li>
                <li>Guideline version lag — AI knowledge base not updated to reflect the most recent clinical protocol revisions</li>
                <li>Model hallucination producing plausible but fabricated drug dosages, contraindications, or interaction warnings</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Reliance on a single or limited knowledge source creating blind spots where local adaptation or updated international guidelines are not reflected</li>
                <li>Absence of weight-based or age-adjusted dosing calculators in MVP versions, increasing paediatric and geriatric dosing risk</li>
                <li>Language barriers when clinical staff query in a language not well-represented in the model's training data</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Most jurisdictions lack a regulatory pathway for classifying and approving AI clinical decision support tools</li>
                <li>Processing of sensitive health queries through third-party LLM APIs may violate national health data protection requirements</li>
                <li>Lack of interoperability with national health information management systems limiting clinical audit and oversight</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-harm"><span class="row-label-inner">Measure of Harm</span></td>
            <td>
              <ul class="cell-list">
                <li>Clinical accuracy rate per query type against gold-standard clinical benchmark assessments by domain specialists</li>
                <li>Rate of AI responses flagged by clinical reviewers as potentially harmful per 100 queries (adverse signal rate)</li>
                <li>Number of reported patient safety incidents plausibly attributable to AI guidance errors</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Proportion of facilities using AI clinical tools without a mandatory clinical supervisor review layer</li>
                <li>Access differential in AI guidance accuracy and availability between well-resourced and under-resourced facilities</li>
                <li>Clinician self-reported reduction in diagnostic confidence over time (dependency index)</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Trends in key national health programme KPIs in facilities where AI is deployed versus control facilities</li>
                <li>Number of regulatory alerts, suspensions, or interventions issued by health authorities regarding AI clinical tools</li>
                <li>Volume of data protection complaints or breaches linked to AI clinical query processing</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-harm"><span class="row-label-inner">Mitigation of Harm</span></td>
            <td>
              <ul class="cell-list">
                <li>Mandatory clinical disclaimer on every response: <em>"Always apply clinical judgement. Consult official guidelines directly before any prescribing or treatment decision."</em></li>
                <li>Source-grounded RAG — every response must cite the specific section, page, and version of the guideline document it draws from</li>
                <li>Daily query limits to prevent dependency and reinforce the tool's role as a reference, not a replacement for clinical judgment</li>
                <li>Automated guideline version monitoring with knowledge base updates aligned to official guideline publication cycles</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Mandatory clinical supervisor review layer for all community health worker and lay-provider deployments</li>
                <li>Pre-deployment training module clearly distinguishing AI as a reference tool versus a diagnostic or prescribing system</li>
                <li>Multi-language interface with clinically validated translations to remove language-based access barriers</li>
                <li>Weight-based and age-adjusted dosing calculation modules included in all clinical deployment versions</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Proactive engagement with national health ministries, medical councils, and digital health regulatory bodies for tool classification and approval</li>
                <li>Data processing agreements with LLM providers specifying health data residency, retention, and non-use for training</li>
                <li>Quarterly independent clinical audit of AI response accuracy by authority-appointed clinical reviewers</li>
                <li>API integration with national health information systems for anonymised query-pattern monitoring and clinical oversight</li>
              </ul>
            </td>
          </tr>

        </tbody>
      </table>
    </div>
  </div>

  <!-- BENEFITS -->
  <div class="matrix-block">
    <div class="matrix-label">
      <span class="ml-badge benefits">✦ Amplifying Benefits</span>
      <span class="ml-sub">Positive social value of AI-assisted clinical decision support</span>
    </div>
    <div class="matrix-wrap">
      <table class="matrix-table hv-tbl" aria-label="Clinical Guidelines Benefits Matrix">
        <colgroup><col class="col-row"/><col class="col-cell"/><col class="col-cell"/><col class="col-cell"/></colgroup>
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
                <li>Clinicians gain instant, verified access to protocol guidance without manually navigating lengthy guideline documents</li>
                <li>Nurses, midwives, and community health workers in remote facilities supported with protocol knowledge beyond their standard training scope</li>
                <li>Patients access plain-language explanations of their treatment plans, improving adherence and informed consent</li>
                <li>Reduced cognitive burden on health workers managing complex multi-morbidity cases under high-workload conditions</li>
              </ul>
            </td>
            <td>
              <span class="severity sev-pos">● High Value</span>
              <ul class="cell-list">
                <li>Standardised protocol application across all facility types reduces geographic and resource-based variation in care quality</li>
                <li>Community health workers equipped to deliver accurate first-line counselling aligned with current clinical standards</li>
                <li>Under-staffed facilities in remote or low-resource settings gain 24/7 decision support equivalent to specialist consultation</li>
              </ul>
            </td>
            <td>
              <span class="severity sev-pos">● High Value</span>
              <ul class="cell-list">
                <li>Contribution to national and global health targets (e.g. WHO Universal Health Coverage, disease-specific elimination goals) through improved protocol adherence</li>
                <li>Reduced rates of treatment failure lower downstream costs of second- and third-line interventions across health systems</li>
                <li>Positions deploying health systems as global leaders in responsible AI for clinical decision support</li>
                <li>Open, replicable model applicable to any disease area or clinical guideline set worldwide</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-benefit"><span class="row-label-inner">Source of Benefit</span></td>
            <td>
              <ul class="cell-list">
                <li>High-fidelity vector index of authoritative clinical guidelines enabling precise, citation-backed retrieval</li>
                <li>Agentic document parsing ensuring accurate extraction of clinical tables, dosing charts, and decision algorithms</li>
                <li>Two-stage RAG pipeline (context creation + search prompt generation) maximising clinical answer accuracy</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Scalable architecture enabling concurrent access by large numbers of health workers without infrastructure bottlenecks</li>
                <li>Real-time SSE streaming providing immediate responses for time-sensitive clinical queries</li>
                <li>Cloud-neutral deployment model enabling access from any device with internet connectivity globally</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Institutional partnership model with authoritative bodies (WHO, national health ministries, professional colleges) as knowledge source owners</li>
                <li>Alignment with global digital health strategies including WHO Global Strategy on Digital Health 2020–2025</li>
                <li>Academic publication potential — documenting RAG-based clinical AI methodology applicable to any health system</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-benefit"><span class="row-label-inner">Measure of Benefit</span></td>
            <td>
              <ul class="cell-list">
                <li>Clinical accuracy score per query category versus specialist clinician review benchmarks</li>
                <li>Time-to-answer for clinical queries: AI (under 10 seconds) versus manual guideline search (5–15 minutes)</li>
                <li>Health worker satisfaction and perceived usefulness scores measured through periodic surveys</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Reduction in inter-facility variation in protocol adherence before and after AI introduction</li>
                <li>Geographic reach: proportion of target facilities or health workers with active access to the platform</li>
                <li>Training completion rates and post-training competency scores for AI-assisted clinical protocols</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Trends in key clinical outcome indicators in facilities where AI decision support is deployed versus control groups</li>
                <li>Number of other health systems or countries adopting the RAG-clinical AI model (replication and scaling index)</li>
                <li>Formal endorsement or adoption by WHO, regional health bodies, or national health authorities</li>
              </ul>
            </td>
          </tr>

          <tr>
            <td class="row-label r-benefit"><span class="row-label-inner">Amplification of Benefit</span></td>
            <td>
              <ul class="cell-list">
                <li>Integration with patient-facing health companion applications for personalised treatment adherence support</li>
                <li>AI-assisted patient education on treatment plans, side effects, and follow-up schedules in the patient's own language</li>
                <li>Extension to additional disease areas and specialties using the same RAG infrastructure</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Embedding in community health worker training and referral workflows at scale</li>
                <li>Integration with national health information management systems to contextualise guidance with facility-level epidemiological data</li>
                <li>Peer-learning networks of health workers sharing AI use cases and best practices across facilities</li>
              </ul>
            </td>
            <td>
              <ul class="cell-list">
                <li>Scaling to national public health system deployment through ministry of health procurement and open-source licensing</li>
                <li>Replication of the knowledge base model across WHO AFRO, EMRO, SEARO, and other regional office guideline repositories</li>
                <li>Pre-commercial procurement and public innovation funding pathways to accelerate responsible deployment globally</li>
                <li>Peer-reviewed publication establishing the model as a reference architecture for AI clinical decision support in resource-limited settings</li>
              </ul>
            </td>
          </tr>

        </tbody>
      </table>
    </div>
  </div>

</section>

</main>


<!-- ── METHODOLOGY ATTRIBUTION ── -->
<div style="
  text-align: center;
  padding: 14px var(--pad) 20px;
  border-top: 1px solid rgba(255,255,255,0.06);
  font-family: 'IBM Plex Mono', monospace;
  font-size: 10px;
  letter-spacing: 0.10em;
  color: #545d75;
  line-height: 1.8;
">
  <span style="text-transform: uppercase; letter-spacing: 0.14em;">Social Impact Matrix Methodology:</span>
  &nbsp;
  <span style="color: #8892a4;">Human Sciences Research Council (HSRC)</span>
  &nbsp;&mdash;&nbsp;
  <span style="color: #8892a4;">Fair Forward GIZ, 2022</span>
</div>

</body>
</html>
