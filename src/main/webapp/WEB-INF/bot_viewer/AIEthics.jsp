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
<title>AI Ethics — AIonifier Platform</title>
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet"/>
<style>
/* ── Tokens ── */
:root {
  --bg:      #0b0f1a;
  --bg2:     #0d1117;
  --bg3:     #131929;
  --surface: #131929;
  --border:  rgba(255,255,255,0.07);
  --border2: rgba(255,255,255,0.10);
  --text:    #eef2ff;
  --text2:   #8892a4;
  --text3:   #545d75;
  --green:   #4ade80;
  --green2:  rgba(74,222,128,0.12);
  --green3:  rgba(74,222,128,0.06);
  --green4:  rgba(74,222,128,0.18);
  --font-d:  'Sora', sans-serif;
  --font-b:  'Sora', sans-serif;
  --font-m:  'IBM Plex Mono', monospace;
  --max:     1100px;
  --pad:     clamp(20px,5vw,60px);
}

*,*::before,*::after { box-sizing:border-box; margin:0; padding:0; }
html { scroll-behavior:smooth; }

body {
  background: var(--bg);
  color: var(--text);
  font-family: var(--font-b);
  font-size: 15px;
  line-height: 1.65;
  -webkit-font-smoothing: antialiased;
  overflow-x: hidden;
}

/* ── Grain overlay ── */
body::before {
  content:'';
  position:fixed; inset:0; z-index:0; pointer-events:none;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.035'/%3E%3C/svg%3E");
  background-size: 256px;
  opacity: 0.4;
}

/* ── Ambient glow ── */
.glow-orb {
  position:fixed; border-radius:50%; pointer-events:none; z-index:0;
  filter: blur(80px);
}
.glow-orb.g1 {
  width:500px; height:500px; top:-100px; right:-80px;
  background: radial-gradient(circle, rgba(74,222,128,0.07) 0%, transparent 70%);
}
.glow-orb.g2 {
  width:400px; height:400px; bottom:0; left:-100px;
  background: radial-gradient(circle, rgba(96,165,250,0.05) 0%, transparent 70%);
}

/* ── Layout ── */
.page { position:relative; z-index:1; }

/* ── Hero ── */
.hero {
  padding: 72px var(--pad) 56px;
  max-width: var(--max); margin: 0 auto;
  display: flex; flex-direction: column; gap: 20px;
}

.hero-eyebrow { display: none; }
.hero-eyebrow::before {
  content:'';
  width:6px; height:6px; border-radius:50%;
  background:var(--green);
  box-shadow: 0 0 8px var(--green);
  animation: pulse 2s ease infinite;
}
@keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.4;transform:scale(.6)} }

.hero-title {
  font-family: var(--font-d);
  font-size: clamp(20px,3vw,34px);
  font-weight: 700; line-height: 1.1;
  color: var(--text);
  letter-spacing: -.02em;
  white-space: nowrap;
}
.hero-title em {
  font-style: italic;
  color: var(--green);
}

.hero-sub {
  font-size: clamp(11px,1.2vw,13px);
  color: var(--text2);
  line-height: 1.5;
  flex: 1;
}

.hero-divider { display: none; }

/* ── Version badge ── */

/* ── Main grid ── */
.ethics-grid {
  max-width: var(--max); margin: 0 auto;
  padding: 0 var(--pad) 80px;
  display: flex; flex-direction: column; gap: 16px;
}

/* ── Principle card ── */
.card {
  position: relative; overflow: hidden;
  border-radius: 14px;
  border: 1px solid var(--border);
  background: var(--surface);
  padding: 32px 36px;
  display: grid;
  grid-template-columns: 56px 1fr;
  gap: 0 24px;
  transition: border-color .2s, transform .2s;
}
.card:hover {
  border-color: var(--border2);
  transform: translateY(-2px);
}
.card::before {
  content:'';
  position:absolute; top:0; left:0; right:0; height:2px;
}
.card.privacy::before  { background: linear-gradient(90deg, var(--green), transparent); }
.card.cookies::before  { background: linear-gradient(90deg, var(--green), transparent); }
.card.accuracy::before { background: linear-gradient(90deg, var(--green), transparent); }
.card.scope::before    { background: linear-gradient(90deg, var(--green), transparent); }
.card.purpose::before  { background: linear-gradient(90deg, var(--green), transparent); }
.card.open::before     { background: linear-gradient(90deg, var(--green), transparent); }

/* Icon column */
.card-icon {
  grid-row: 1 / 3;
  width: 48px; height: 48px; border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  font-size: 22px; flex-shrink: 0; margin-top: 2px;
}
.card.privacy  .card-icon { background: var(--green3); }
.card.cookies  .card-icon { background: var(--green3); }
.card.accuracy .card-icon { background: var(--green3); }
.card.scope    .card-icon { background: var(--green3); }
.card.purpose  .card-icon { background: var(--green3); }
.card.open     .card-icon { background: var(--green3); }

/* Card text */
.card-num {
  font-family: var(--font-m); font-size: 10px; font-weight: 500;
  letter-spacing: .18em; text-transform: uppercase;
  margin-bottom: 5px; display: block;
}
.card.privacy  .card-num { color: var(--green); }
.card.cookies  .card-num { color: var(--green); }
.card.accuracy .card-num { color: var(--green); }
.card.scope    .card-num { color: var(--green); }
.card.purpose  .card-num { color: var(--green); }
.card.open     .card-num { color: var(--green); }

.card-title {
  font-family: var(--font-d); font-size: clamp(17px,2.5vw,22px);
  font-weight: 400; color: var(--text); line-height: 1.2;
  margin-bottom: 4px;
}

.card-body {
  grid-column: 2;
  font-size: 14px; color: var(--text2); line-height: 1.7;
  margin-top: 10px;
}

/* Commitment chips inside cards */
.chips {
  display: flex; flex-wrap: wrap; gap: 6px;
  margin-top: 14px;
}
.chip {
  font-family: var(--font-m); font-size: 10px; font-weight: 500;
  letter-spacing: .08em; text-transform: uppercase;
  padding: 4px 10px; border-radius: 999px;
  border: 1px solid; display: inline-flex; align-items: center; gap: 5px;
}
.chip::before { content:'✓'; font-size: 9px; }
.chip.g, .chip.b, .chip.a, .chip.r, .chip.v {
  color: var(--green);
  border-color: rgba(74,222,128,0.25);
  background: var(--green3);
}

/* Warning banner inside accuracy card */
.warn-banner {
  margin-top: 14px;
  display: flex; align-items: flex-start; gap: 10px;
  background: rgba(74,222,128,0.05);
  border: 1px solid rgba(74,222,128,0.18);
  border-radius: 8px; padding: 12px 14px;
  font-size: 13px; line-height: 1.6; color: var(--green);
}
.warn-banner .wi { font-size: 16px; flex-shrink: 0; margin-top: 1px; }

/* Production notice banner */
.prod-banner {
  margin-top: 14px;
  display: flex; align-items: flex-start; gap: 10px;
  background: rgba(74,222,128,0.05);
  border: 1px solid rgba(74,222,128,0.18);
  border-radius: 8px; padding: 12px 14px;
  font-size: 13px; line-height: 1.6; color: var(--green);
}
.prod-banner .wi { font-size: 16px; flex-shrink: 0; margin-top: 1px; }

/* ── Commitment summary bar ── */
.summary-bar {
  max-width: var(--max); margin: 0 auto;
  padding: 0 var(--pad) 80px;
}
.summary-inner {
  border-radius: 14px;
  border: 1px solid rgba(74,222,128,0.2);
  background: linear-gradient(135deg, rgba(74,222,128,0.05) 0%, rgba(96,165,250,0.04) 100%);
  padding: 36px 40px;
  display: flex; flex-direction: column; gap: 20px;
}
.summary-title {
  font-family: var(--font-d); font-size: clamp(18px,3vw,26px);
  color: var(--text); font-weight: 400;
}
.summary-title span { color: var(--green); font-style: italic; }
.summary-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px,1fr));
  gap: 12px;
}
.summary-item {
  display: flex; align-items: center; gap: 10px;
  font-size: 13px; color: var(--text2);
}
.summary-item::before {
  content:'';
  width: 8px; height: 8px; border-radius: 50%;
  flex-shrink: 0; background: var(--green);
  box-shadow: 0 0 6px var(--green);
}

/* ── Footer ── */

/* ── Responsive ── */
@media (max-width: 600px) {
  :root { --pad: 18px; }
  .card { grid-template-columns: 1fr; padding: 24px 22px; }
  .card-icon { grid-row: auto; margin-bottom: 12px; }
  .card-body { grid-column: 1; }
  .summary-inner { padding: 24px 20px; }
}
@media print {
  body { background: var(--bg); color: var(--text); }
  .glow-orb, body::before { display: none; }
  .card { border-color: var(--border); background: var(--surface); break-inside: avoid; }
}
</style>
</head>
<body>

<div class="glow-orb g1"></div>
<div class="glow-orb g2"></div>

<div class="page">

  <!-- ── HERO ── -->
  <header class="hero">
    <h1 class="hero-title">AI Ethics &amp; <em>Responsible Use</em></h1>
    <p class="hero-sub">
      Six ethical principles governing every AI application on this platform —
      privacy, accuracy, scope, oversight, transparency, and responsible deployment.
    </p>
  </header>


  <!-- ── PRINCIPLES GRID ── -->
  <div class="ethics-grid">

    <!-- 1. Data Privacy -->
    <div class="card privacy">
      <div class="card-icon">🔒</div>
      <div>
        <span class="card-num">Principle 01 &nbsp;·&nbsp; Data Privacy</span>
        <h2 class="card-title">We do not collect your personal data</h2>
      </div>
      <div class="card-body">
        AIonifier does not collect, store, or process any personally identifiable information (PII)
        from users. No registration is required to access any AI application on this platform.
        Queries submitted to the AI agents are processed in real time and are not retained,
        logged to any user profile, or associated with any individual identity.
        <br/><br/>
        Any rate-limiting mechanisms (such as daily query counts) use browser-local storage only
        — this data lives entirely on your own device and is never transmitted to our servers.
        <div class="chips">
          <span class="chip g">No registration required</span>
          <span class="chip g">No query logging</span>
          <span class="chip g">No user profiles</span>
          <span class="chip g">Local-only rate limits</span>
        </div>
      </div>
    </div>

    <!-- 2. Cookies -->
    <div class="card cookies">
      <div class="card-icon">🍪</div>
      <div>
        <span class="card-num">Principle 02 &nbsp;·&nbsp; Cookie Policy</span>
        <h2 class="card-title">We do not use cookies</h2>
      </div>
      <div class="card-body">
        This platform does not set, read, or rely on browser cookies for any purpose —
        including session management, analytics, advertising, or user tracking.
        No third-party tracking scripts, advertising pixels, or analytics SDKs are embedded
        in any page on this platform.
        <br/><br/>
        The platform does not use Google Analytics, Facebook Pixel, or any equivalent
        behavioural tracking technology. Your browsing activity on AIonifier is entirely
        private and is not shared with any third party.
        <div class="chips">
          <span class="chip b">Zero tracking cookies</span>
          <span class="chip b">No analytics SDKs</span>
          <span class="chip b">No advertising pixels</span>
          <span class="chip b">No third-party tracking</span>
        </div>
      </div>
    </div>

    <!-- 3. AI Accuracy Warning -->
    <div class="card accuracy">
      <div class="card-icon">⚠️</div>
      <div>
        <span class="card-num">Principle 03 &nbsp;·&nbsp; AI Accuracy</span>
        <h2 class="card-title">AI can and does generate incorrect information</h2>
      </div>
      <div class="card-body">
        All AI applications on this platform are powered by large language models (LLMs)
        which are capable of producing responses that are plausible in form but factually
        incorrect, outdated, incomplete, or misleading — a phenomenon known as
        <em>hallucination</em>. This is an inherent limitation of current AI technology
        and is not unique to AIonifier.
        <br/><br/>
        Every response generated by any AI agent on this platform must be independently
        verified before being acted upon. This applies especially to legal, medical, financial,
        regulatory, and clinical guidance where incorrect information can have serious consequences.
        <div class="warn-banner">
          <span class="wi">⚠</span>
          <span>
            <strong>User responsibility:</strong> AI-generated outputs are provided for
            informational and exploratory purposes only. Always verify with a qualified
            professional — attorney, clinician, financial advisor, or regulatory expert —
            before taking any action based on AI responses.
          </span>
        </div>
        <div class="chips" style="margin-top:12px">
          <span class="chip a">Hallucination risk disclosed</span>
          <span class="chip a">Verification required</span>
          <span class="chip a">Professional advice recommended</span>
        </div>
      </div>
    </div>

    <!-- 4. Not for Production -->
    <div class="card scope">
      <div class="card-icon">🚧</div>
      <div>
        <span class="card-num">Principle 04 &nbsp;·&nbsp; Platform Scope</span>
        <h2 class="card-title">This platform is not for real production use</h2>
      </div>
      <div class="card-body">
        AIonifier is an AI MVP (Minimum Viable Product) portfolio and demonstration platform.
        Every application presented here — including the legal advisor, clinical guidelines
        assistant, bank CRM advisor, education platform, and CV chatbot — is a proof of
        concept built to showcase AI engineering capability.
        <br/><br/>
        None of these applications have undergone the regulatory review, clinical validation,
        legal certification, financial compliance audit, or security penetration testing
        required for deployment in production environments. They must not be used to make
        real decisions in legal proceedings, clinical care, financial transactions,
        regulatory filings, or any other consequential real-world context.
        <div class="prod-banner">
          <span class="wi">🚧</span>
          <span>
            <strong>MVP disclaimer:</strong> These applications are demonstrations only.
            They are not certified, regulated, or validated for professional or institutional
            use. Organisations interested in production deployment should contact
            GACIRANE Patrick to discuss a fully engineered, validated, and compliant solution.
          </span>
        </div>
        <div class="chips" style="margin-top:12px">
          <span class="chip r">Demo only — not production</span>
          <span class="chip r">No regulatory certification</span>
          <span class="chip r">No clinical validation</span>
          <span class="chip r">No legal certification</span>
        </div>
      </div>
    </div>

    <!-- 5. AI Purpose & Human Oversight -->
    <div class="card purpose">
      <div class="card-icon">🧭</div>
      <div>
        <span class="card-num">Principle 05 &nbsp;·&nbsp; Human Oversight</span>
        <h2 class="card-title">AI assists — it does not replace — human judgement</h2>
      </div>
      <div class="card-body">
        Every AI application on this platform is designed to augment human capability,
        not to substitute for human expertise, authority, or accountability. The platform
        explicitly positions AI as a research and reference tool — a starting point for
        inquiry, not a final authority.
        <br/><br/>
        Decisions in legal, medical, financial, and regulatory domains require human
        professionals who carry professional liability, contextual understanding, ethical
        responsibility, and accountability that no AI system can provide. AIonifier is
        committed to making this boundary clear in every user interaction through
        mandatory disclaimers on every AI response.
        <div class="chips">
          <span class="chip v">AI as reference tool</span>
          <span class="chip v">Human accountability preserved</span>
          <span class="chip v">Mandatory disclaimers on all responses</span>
          <span class="chip v">No autonomous decision-making</span>
        </div>
      </div>
    </div>

    <!-- 6. Openness & Accountability -->
    <div class="card open">
      <div class="card-icon">📖</div>
      <div>
        <span class="card-num">Principle 06 &nbsp;·&nbsp; Transparency</span>
        <h2 class="card-title">We are transparent about what this platform is and is not</h2>
      </div>
      <div class="card-body">
        AIonifier is openly described as a personal AI portfolio built by a single developer
        to demonstrate production-grade AI engineering skills. It is not a commercial product,
        a regulated service, or an institutional platform.
        <br/><br/>
        The platform identifies the AI models, frameworks, and knowledge sources powering each
        application — including the specific guideline documents used in RAG pipelines, the
        LLM providers behind agent reasoning, and the architectural decisions that shape
        each system's capabilities and limitations. Users are never misled about the nature,
        source, or reliability of any AI-generated content.
        <div class="chips">
          <span class="chip g">Technology stack disclosed</span>
          <span class="chip g">Knowledge sources cited</span>
          <span class="chip g">Limitations openly stated</span>
          <span class="chip b">Developer identity disclosed</span>
        </div>
      </div>
    </div>

  </div><!-- /ethics-grid -->

  <!-- ── COMMITMENT SUMMARY ── -->
  <div class="summary-bar">
    <div class="summary-inner">
      <h2 class="summary-title">Our commitments <span>in brief</span></h2>
      <div class="summary-grid">
        <div class="summary-item">No personal data collected</div>
        <div class="summary-item">No cookies or tracking of any kind</div>
        <div class="summary-item">AI accuracy warnings on every response</div>
        <div class="summary-item">Platform clearly labelled as MVP — not production</div>
        <div class="summary-item">Human oversight always required</div>
        <div class="summary-item">Full transparency on technology and limitations</div>
        <div class="summary-item">Professional consultation always recommended</div>
        <div class="summary-item">No autonomous or consequential decision-making</div>
      </div>
    </div>
  </div>


</div><!-- /page -->

</body>
</html>
