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
<title>Etymology of AIonifier</title>
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet"/>
<style>
:root {
  --bg:      #0b0f1a;
  --surface: #131929;
  --border:  rgba(255,255,255,0.07);
  --green:   #4ade80;
  --muted:   #8892a4;
  --text:    #eef2ff;
}
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }
body {
  background: var(--bg); color: var(--text);
  font-family: "Sora", sans-serif;
  -webkit-font-smoothing: antialiased;
  overflow-x: hidden;
  /* allow vertical scroll, prevent horizontal */
  overflow-y: auto;
}
body::before {
  content: ""; position: fixed; inset: 0; z-index: 0; pointer-events: none;
  background: radial-gradient(ellipse 80% 55% at 10% 0%, rgba(74,222,128,0.07) 0%, transparent 60%);
}

/* ── Page wrap — responsive padding, no fixed max-width clipping ── */
.page-wrap {
  position: relative; z-index: 1;
  width: 100%;
  max-width: 960px;
  margin: 0 auto;
  padding: clamp(20px,4vw,48px) clamp(12px,4vw,40px) 60px;
}

/* ── Header ── */
.ety-header {
  border-left: 3px solid rgba(74,222,128,0.5);
  padding-left: clamp(12px,3vw,20px);
  margin-bottom: clamp(20px,3vw,36px);
}
.ety-kicker {
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.50rem,1.2vw,0.58rem);
  letter-spacing: 0.16em; text-transform: uppercase;
  color: rgba(74,222,128,0.55); margin-bottom: 8px;
}
.ety-headword {
  font-size: clamp(1.8rem,6vw,3.6rem);
  font-weight: 800; letter-spacing: -0.03em;
  color: var(--green); line-height: 1.05; margin-bottom: 6px;
}
.ety-variants {
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.60rem,1.5vw,0.72rem);
  color: var(--muted); font-style: italic; margin-bottom: 12px;
}
.creator-badge {
  display: inline-flex; align-items: center; gap: 6px;
  background: rgba(74,222,128,0.07);
  border: 1px solid rgba(74,222,128,0.22);
  border-radius: 999px;
  padding: clamp(4px,1vw,6px) clamp(10px,2vw,16px);
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.55rem,1.2vw,0.65rem);
  letter-spacing: 0.08em; text-transform: uppercase;
  color: var(--green); flex-wrap: wrap;
}
.creator-badge::before {
  content: ''; width: 6px; height: 6px; border-radius: 50%; flex-shrink: 0;
  background: var(--green); box-shadow: 0 0 6px var(--green);
  animation: blink 2s ease-in-out infinite;
}
@keyframes blink { 0%,100%{opacity:1} 50%{opacity:.25} }

/* ── Disclaimer ── */
.disclaimer {
  background: rgba(255,255,255,0.03);
  border: 1px solid rgba(255,255,255,0.10);
  border-left: 3px solid rgba(255,200,92,0.6);
  border-radius: 10px;
  padding: clamp(10px,2vw,14px) clamp(12px,3vw,20px);
  margin-bottom: clamp(20px,3vw,32px);
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.60rem,1.4vw,0.72rem);
  line-height: 1.65; color: #8892a4;
}
.disclaimer .note-label {
  color: #ffc85c; font-weight: 600;
  letter-spacing: 0.08em; text-transform: uppercase;
}

/* ── Section divider ── */
.section-div {
  display: flex; align-items: center; gap: 10px;
  margin: clamp(20px,3vw,32px) 0 clamp(12px,2vw,18px);
}
.section-div span {
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.46rem,1vw,0.55rem);
  letter-spacing: 0.18em; text-transform: uppercase;
  color: var(--muted); white-space: nowrap;
}
.dl  { flex:1; height:1px; background: linear-gradient(to right, rgba(74,222,128,0.3), transparent); }
.dlr { flex:1; height:1px; background: linear-gradient(to left,  rgba(74,222,128,0.3), transparent); }

/* ── Phonetics ── */
.phonetics-grid { display: flex; flex-wrap: wrap; gap: 8px; }
.phon-card {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 8px;
  padding: clamp(8px,1.5vw,12px) clamp(10px,2vw,18px);
  display: flex; align-items: baseline; gap: 8px; flex-wrap: wrap;
}
.phon-label {
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.52rem,1vw,0.58rem);
  letter-spacing: 0.1em; text-transform: uppercase;
  color: var(--muted); flex-shrink: 0;
}
.phon-ipa {
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.85rem,2vw,1.1rem);
  color: var(--green); letter-spacing: 0.02em;
}

/* ── Two-column layout for forms + definitions on wide screens ── */
.two-col {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: clamp(14px,3vw,28px);
  align-items: start;
}
@media (max-width: 640px) {
  .two-col { grid-template-columns: 1fr; }
}

/* ── Word forms table ── */
.forms-table { width: 100%; border-collapse: collapse; }
.forms-table td {
  padding: clamp(5px,1vw,9px) 0;
  border-bottom: 1px solid var(--border);
  font-size: clamp(0.72rem,1.5vw,0.88rem);
}
.forms-table td:first-child {
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.50rem,1vw,0.62rem);
  letter-spacing: 0.06em; text-transform: uppercase;
  color: var(--muted); width: 44%; padding-right: 8px;
}
.forms-table td:last-child { font-style: italic; color: var(--green); }
.forms-table tr:last-child td { border-bottom: none; }

/* ── Definition block ── */
.def-block { display: flex; flex-direction: column; gap: 12px; }
.def-item { display: flex; gap: 10px; }
.def-num {
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.56rem,1vw,0.65rem);
  color: rgba(74,222,128,0.55);
  min-width: 20px; padding-top: 3px; flex-shrink: 0;
}
.def-text { font-size: clamp(0.76rem,1.6vw,0.96rem); color: var(--text); line-height: 1.65; }
.def-pos { font-style: italic; color: var(--muted); font-size: 0.85em; margin-right: 4px; }

/* ── Etymology box ── */
.ety-box {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 12px;
  padding: clamp(16px,3vw,28px) clamp(14px,3vw,30px);
}
.ety-prose {
  font-size: clamp(0.76rem,1.6vw,0.92rem);
  color: var(--text); line-height: 1.75;
  margin-bottom: clamp(14px,2vw,22px);
}
.morph-table { width: 100%; border-collapse: collapse; }
.morph-table thead th {
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.46rem,0.9vw,0.55rem);
  letter-spacing: 0.14em; text-transform: uppercase;
  color: rgba(74,222,128,0.5); padding: 0 0 8px 0;
  text-align: left; border-bottom: 1px solid var(--border);
}
.morph-table tbody td {
  padding: clamp(8px,1.5vw,12px) 0;
  border-bottom: 1px solid var(--border);
  vertical-align: top;
  font-size: clamp(0.72rem,1.4vw,0.88rem);
  line-height: 1.6;
}
.morph-table tbody tr:last-child td { border-bottom: none; }
.morph-table td.element {
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.80rem,1.6vw,1rem);
  color: var(--green); font-weight: 700;
  padding-right: 14px; width: clamp(60px,8vw,90px);
}
.morph-table td.meaning { color: var(--text); padding-right: 10px; }
.morph-table td.source  { color: var(--muted); font-size: clamp(0.65rem,1.2vw,0.82rem); }
/* On narrow screens hide source column */
@media (max-width: 520px) { .morph-table td.source, .morph-table th:nth-child(3) { display: none; } }

/* ── Example sentences ── */
.sentence-list { display: flex; flex-direction: column; gap: 12px; }
.sentence-item {
  border-left: 2px solid rgba(74,222,128,0.3);
  padding-left: clamp(10px,2vw,16px);
}
.sentence-item p {
  font-size: clamp(0.76rem,1.5vw,0.92rem);
  font-style: italic; color: var(--text); line-height: 1.65;
}
.sentence-item cite {
  display: block; margin-top: 3px;
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.48rem,0.9vw,0.58rem);
  letter-spacing: 0.08em; text-transform: uppercase;
  color: rgba(74,222,128,0.45); font-style: normal;
}

/* ── Derivatives ── */
.deriv-grid { display: flex; flex-wrap: wrap; gap: 6px; }
.deriv-pill {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 999px;
  padding: clamp(3px,0.8vw,5px) clamp(10px,2vw,14px);
  font-family: "IBM Plex Mono", monospace;
  font-style: italic;
  font-size: clamp(0.62rem,1.2vw,0.78rem);
  color: var(--green);
  transition: border-color .2s, background .2s;
}
.deriv-pill:hover { border-color: rgba(74,222,128,0.3); background: rgba(74,222,128,0.06); }

/* ── Usage note ── */
.usage-note {
  background: rgba(74,222,128,0.04);
  border: 1px solid rgba(74,222,128,0.12);
  border-radius: 10px;
  padding: clamp(12px,2vw,18px) clamp(14px,3vw,22px);
  font-size: clamp(0.72rem,1.5vw,0.88rem);
  color: var(--muted); line-height: 1.72;
}
.usage-note strong { color: var(--text); font-weight: 600; }

/* ── Creator card ── */
.creator-card {
  background: var(--surface);
  border: 1px solid rgba(74,222,128,0.2);
  border-radius: 12px;
  padding: clamp(16px,2.5vw,24px) clamp(14px,3vw,28px);
  display: flex; gap: clamp(12px,2vw,20px);
  align-items: flex-start; flex-wrap: wrap;
}
.creator-icon {
  width: clamp(38px,5vw,52px); height: clamp(38px,5vw,52px);
  border-radius: 10px;
  background: rgba(74,222,128,0.1);
  border: 1px solid rgba(74,222,128,0.2);
  display: flex; align-items: center; justify-content: center;
  font-size: clamp(18px,3vw,24px); flex-shrink: 0;
}
.creator-info { flex: 1; min-width: 180px; }
.creator-name {
  font-size: clamp(0.88rem,1.8vw,1rem);
  font-weight: 700; color: var(--green); margin-bottom: 3px;
}
.creator-title {
  font-family: "IBM Plex Mono", monospace;
  font-size: clamp(0.50rem,1vw,0.62rem);
  letter-spacing: 0.1em; text-transform: uppercase;
  color: var(--muted); margin-bottom: 8px;
}
.creator-desc {
  font-size: clamp(0.72rem,1.5vw,0.88rem);
  color: var(--muted); line-height: 1.65;
}
.creator-desc strong { color: var(--text); }


/* ── Part of speech line ── */
.pos-line {
  font-size: clamp(0.76rem,1.6vw,0.92rem);
  color: var(--text); line-height: 1.65;
}
</style>
</head>
<body>
<div class="page-wrap">

  <!-- HEADER -->
  <div class="ety-header">
    <div class="ety-kicker">Lexical Reference &nbsp;·&nbsp; 2026</div>
    <div class="ety-headword">AIonifier</div>
    <div class="ety-variants">also: <em>AI-onifier</em> &nbsp;·&nbsp; <em>Aionifier</em> &nbsp;·&nbsp; <em>aionifier</em> (informal)</div>
    <div class="creator-badge">Word first thought of by Gacirane Patrick &nbsp;·&nbsp; Etymology generated with AI &nbsp;·&nbsp; 2026</div>
  </div>

  <!-- DISCLAIMER -->
  <div class="disclaimer">
    <span class="note-label">&#9888;&nbsp; Note</span>
    &nbsp;&mdash;&nbsp;
    <strong style="color:#eef2ff;">AIonifier</strong> is not a word recognised, registered,
    or officially accepted by any known linguistic authority, dictionary institution,
    standards body, or legal organ. It has no formal standing in any language.
    It is used solely on this platform as a descriptive term to explain the concept
    and purpose of the AIonifier — the idea of transforming any domain into an
    AI-enabled one. Its etymology is presented for explanatory purposes only.
  </div>

  <!-- PRONUNCIATION -->
  <div class="section-div"><div class="dl"></div><span>Pronunciation</span><div class="dlr"></div></div>
  <div class="phonetics-grid">
    <div class="phon-card">
      <span class="phon-label">Brit.</span>
      <span class="phon-ipa">/ˌeɪ.aɪ.ˈɒn.ɪ.faɪ.ər/</span>
    </div>
    <div class="phon-card">
      <span class="phon-label">N. Amer.</span>
      <span class="phon-ipa">/ˌeɪ.aɪ.ˈɑː.nɪ.faɪ.ər/</span>
    </div>
    <div class="phon-card">
      <span class="phon-label">Stress</span>
      <span class="phon-ipa" style="font-size:clamp(0.72rem,1.5vw,0.85rem); color:var(--muted);">Primary stress on <strong style="color:var(--green);">-ON-</strong></span>
    </div>
  </div>

  <!-- WORD FORMS + DEFINITIONS side by side on wide screens -->
  <div class="section-div"><div class="dl"></div><span>Word Forms &amp; Definitions</span><div class="dlr"></div></div>
  <div class="two-col">
    <table class="forms-table">
      <tbody>
        <tr><td>noun (singular)</td><td>AIonifier</td></tr>
        <tr><td>noun (plural)</td><td>AIonifiers</td></tr>
        <tr><td>verb (base)</td><td>to AIonify</td></tr>
        <tr><td>verb (3rd sg. present)</td><td>AIonifies</td></tr>
        <tr><td>verb (past tense)</td><td>AIonified</td></tr>
        <tr><td>verb (present participle)</td><td>AIonifying</td></tr>
        <tr><td>verbal noun</td><td>AIonification</td></tr>
        <tr><td>adjective (past part.)</td><td>AIonified</td></tr>
        <tr><td>adjective (capable)</td><td>AIonifiable</td></tr>
        <tr><td>negative adjective</td><td>non-AIonified</td></tr>
        <tr><td>pre-state noun</td><td>pre-AIonification</td></tr>
      </tbody>
    </table>
    <div>
      <p class="pos-line" style="margin-bottom:clamp(10px,2vw,16px);">
        <em style="color:var(--green);">noun</em> (agent noun) &nbsp;·&nbsp;
        <em style="color:var(--muted);">also attributive</em>
      </p>
      <div class="def-block">
        <div class="def-item">
          <span class="def-num">1.</span>
          <p class="def-text">A platform, system, or agent that <em>AIonifies</em> — transforms any domain, process, or workflow into one that is AI-enabled. <span class="def-pos">[count noun]</span></p>
        </div>
        <div class="def-item">
          <span class="def-num">2.</span>
          <p class="def-text">A person who systematically applies AI to transform fields or services previously non-AI-enabled. <span class="def-pos">[count noun]</span></p>
        </div>
        <div class="def-item">
          <span class="def-num">3.</span>
          <p class="def-text"><span class="def-pos">attributive.</span> Designating a suite of AI-powered applications under a single platform identity.</p>
        </div>
      </div>
    </div>
  </div>

  <!-- ETYMOLOGY -->
  <div class="section-div"><div class="dl"></div><span>Etymology</span><div class="dlr"></div></div>
  <div class="ety-box">
    <p class="ety-prose">
      Formed in the early 21st century (first conceived 2026) as an <em>agent noun</em> derived from
      the neologism <em>to AIonify</em> — a portmanteau of <em>AI</em> (initialism of
      <em>Artificial Intelligence</em>) and the productive verbal suffix <em>‑ify</em>
      (from Latin <em>‑ificare</em>, &ldquo;to make, to cause to become&rdquo;),
      with <em>‑on‑</em> as a euphonic linking element. The agent-noun suffix <em>‑er</em>
      (Old English <em>‑ere</em>, Latin <em>‑ator</em>) produces the nominal form.
    </p>
    <table class="morph-table">
      <thead>
        <tr><th>Element</th><th>Meaning</th><th>Historical source</th></tr>
      </thead>
      <tbody>
        <tr>
          <td class="element">AI</td>
          <td class="meaning">Artificial Intelligence — the operative semantic root. Denotes the technology applied to transform the target domain.</td>
          <td class="source">Initialism coined mid-20th c. From Latin <em>artificialis</em> + <em>intelligentia</em>. First used in this sense by John McCarthy, 1956.</td>
        </tr>
        <tr>
          <td class="element">-on-</td>
          <td class="meaning">Euphonic linking element. Evokes <em>ion</em> (movement, transformation, charge) — an apt metaphor for technological activation.</td>
          <td class="source">Greek <em>ἰόν</em> (going). Entered English via scientific Latin <em>ion</em> (Faraday, 1834).</td>
        </tr>
        <tr>
          <td class="element">-ify</td>
          <td class="meaning">Verbal suffix: &ldquo;to make or cause to become&rdquo;. Here: to cause something to become AI-enabled.</td>
          <td class="source">Old French <em>‑ifier</em>, Latin <em>‑ificare</em>. Found in <em>amplify</em>, <em>unify</em>, <em>electrify</em>.</td>
        </tr>
        <tr>
          <td class="element">-er</td>
          <td class="meaning">Agent-noun suffix: the entity that performs the action of the base verb.</td>
          <td class="source">Old English <em>‑ere</em>, reinforced by Old French <em>‑eur</em>, Latin <em>‑ator</em>. Found in <em>amplifier</em>, <em>unifier</em>.</td>
        </tr>
      </tbody>
    </table>
  </div>

  <!-- EXAMPLE SENTENCES -->
  <div class="section-div"><div class="dl"></div><span>Example Sentences</span><div class="dlr"></div></div>
  <div class="sentence-list">
    <div class="sentence-item">
      <p>&ldquo;The <strong>AIonifier</strong> platform demonstrated how any domain — legal, clinical, or financial — could be AIonified within weeks of deployment.&rdquo;</p>
      <cite>First attested 2026</cite>
    </div>
    <div class="sentence-item">
      <p>&ldquo;He described himself not merely as a developer but as an <strong>AIonifier</strong> — one who systematically embeds intelligence into every process and service.&rdquo;</p>
      <cite>Technology sector usage, 2026</cite>
    </div>
    <div class="sentence-item">
      <p>&ldquo;The AIonification of the advisory workflow reduced response time by 60 per cent and eliminated manual error across multi-domain queries.&rdquo;</p>
      <cite>Case study, 2026</cite>
    </div>
    <div class="sentence-item">
      <p>&ldquo;We are looking for an <strong>AIonifier</strong> — someone who does not merely integrate AI tools but fundamentally reimagines each process as AI-native.&rdquo;</p>
      <cite>Technology sector usage, 2026</cite>
    </div>
  </div>

  <!-- DERIVATIVES -->
  <div class="section-div"><div class="dl"></div><span>Related Forms &amp; Derivatives</span><div class="dlr"></div></div>
  <div class="deriv-grid">
    <span class="deriv-pill">to AIonify</span>
    <span class="deriv-pill">AIonification</span>
    <span class="deriv-pill">AIonified</span>
    <span class="deriv-pill">AIonifiable</span>
    <span class="deriv-pill">AIonifiers</span>
    <span class="deriv-pill">AIonifying</span>
    <span class="deriv-pill">non-AIonified</span>
    <span class="deriv-pill">pre-AIonification</span>
    <span class="deriv-pill">post-AIonification</span>
    <span class="deriv-pill">AIonifier-ready</span>
  </div>

  <!-- USAGE NOTE -->
  <div class="section-div"><div class="dl"></div><span>Usage Note</span><div class="dlr"></div></div>
  <div class="usage-note">
    The term follows a well-established pattern of technology coinages, comparable to
    <strong>electrification</strong> (19th c.), <strong>computerisation</strong> (mid-20th c.),
    and <strong>digitisation</strong> (late 20th c.). The capitalisation of <em>AI</em> is
    conventional in technical writing; lower-case <em>aionifier</em> may appear in informal
    contexts. <strong>Note:</strong> The word was first conceived in 2026. Its etymology was generated using AI.
  </div>

  <!-- ORIGIN -->
  <div class="section-div"><div class="dl"></div><span>Origin</span><div class="dlr"></div></div>
  <div class="creator-card">
    <div class="creator-icon">✦</div>
    <div class="creator-info">
      <div class="creator-name">Gacirane Patrick</div>
      <div class="creator-title">First thought of the word &nbsp;·&nbsp; 2026</div>
      <div class="creator-desc">
        The word <strong>AIonifier</strong> was first conceived in 2026.
        Its etymology was subsequently generated using AI.
      </div>
    </div>
  </div>

</div>
</body>
</html>
