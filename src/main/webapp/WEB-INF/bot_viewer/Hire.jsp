<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Hire GACIRANE Patrick — AI Solutions Builder</title>
  <meta name="description" content="Hire GACIRANE Patrick — AI Solutions Builder building production multi-agent systems, RAG pipelines, and MCP servers. Available for consulting, part-time, and remote roles across East Africa and internationally." />
  <meta name="author" content="GACIRANE Patrick" />
  <meta name="robots" content="index, follow" />
  <meta property="og:type"        content="profile" />
  <meta property="og:title"       content="Hire GACIRANE Patrick — AI Solution Builder" />
  <meta property="og:description" content="Building production multi-agent AI systems. Open to consulting, part-time, and remote roles across East Africa and internationally." />
  <meta property="og:image"       content="<%= ctx %>/images/aionifier-og.png" />
  <meta property="og:url"         content="https://aionifier.ai/hire" />
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Person",
    "name": "GACIRANE Patrick",
    "jobTitle": "AI Solutions Builder",
    "url": "https://aionifier.ai",
    "sameAs": ["https://www.linkedin.com/in/patricus/","https://github.com/pgacirane"],
    "knowsAbout": ["Multi-Agent AI Systems","CrewAI","RAG Pipelines","MCP Servers","LLMOps","FastAPI","Java EE","PostgreSQL","ChromaDB","FAISS","AI Ethics","Regulatory AI","Clinical AI","Fintech AI"]
  }
  </script>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet" />
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --bg:      #0b0f1a;
      --surface: #131929;
      --border:  rgba(255,255,255,0.07);
      --green:   #4ade80;
      --muted:   #8892a4;
      --text:    #eef2ff;
    }
    html, body { background: var(--bg); color: var(--text); font-family: "Sora", sans-serif; -webkit-font-smoothing: antialiased; }
    body::before {
      content: ""; position: fixed; inset: 0; z-index: 0; pointer-events: none;
      background: radial-gradient(ellipse 80% 55% at 10% 0%, rgba(74,222,128,0.07) 0%, transparent 60%);
    }
    .page-wrap {
      position: relative; z-index: 1;
      max-width: 1200px; margin: 0 auto;
      padding: clamp(24px,3vw,40px) clamp(16px,4vw,48px) 72px;
    }

    /* ══ HERO ══ */
    .hire-hero {
      display: grid; grid-template-columns: auto 1fr; grid-template-rows: auto auto auto;
      column-gap: clamp(20px,3vw,36px); align-items: start;
      padding-bottom: clamp(18px,2.5vw,28px);
      border-bottom: 1px solid rgba(74,222,128,0.1);
    }
    .hero-photo-wrap { grid-row: 1 / 4; grid-column: 1; display: flex; align-items: flex-start; padding-top: 6px; }
    .hero-photo {
      width: clamp(72px,10vw,128px); height: auto; border-radius: 12px; display: block;
      border: 2px solid rgba(74,222,128,0.5);
      box-shadow: 0 0 0 4px rgba(74,222,128,0.07), 0 10px 32px rgba(0,0,0,0.55);
    }
    .hero-identity { grid-row: 1; grid-column: 2; display: flex; align-items: baseline; gap: clamp(6px,1.5vw,16px); flex-wrap: wrap; padding-top: 6px; }
    .hero-name { font-size: clamp(0.78rem,1.5vw,1rem); font-weight: 700; color: var(--green); text-decoration: none; letter-spacing: 0.03em; border-bottom: 1px solid rgba(74,222,128,0.3); transition: color .2s; white-space: nowrap; }
    .hero-name:hover { color: #86efac; }
    .hero-role { font-family: "IBM Plex Mono", monospace; font-size: clamp(0.50rem,1vw,0.65rem); letter-spacing: 0.14em; text-transform: uppercase; color: var(--muted); }
    .hire-headline { grid-row: 2; grid-column: 2; padding: 8px 0 0; }
    .hire-headline h1 { font-size: clamp(1.3rem,4.5vw,3.0rem); font-weight: 800; line-height: 1.08; letter-spacing: -0.03em; color: var(--text); }
    .hire-headline h1 .hl { background: linear-gradient(110deg, var(--green) 0%, #86efac 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
    .hire-sub { grid-row: 3; grid-column: 2; padding-top: 10px; }
    .hire-sub p { font-size: clamp(0.72rem,1.1vw,0.82rem); color: var(--muted); line-height: 1.7; max-width: 660px; }
    .hire-sub strong { color: #c8d4e8; font-weight: 600; }
    @media (max-width: 560px) { .hire-hero { column-gap: clamp(10px,3vw,16px); } .hero-photo { width: clamp(58px,18vw,82px); } .hire-headline h1 { font-size: clamp(1.1rem,6vw,1.5rem); } }

    /* ══ AVAILABILITY BANNER ══ */
    .avail-banner { display: flex; align-items: center; gap: 12px; background: rgba(74,222,128,0.05); border: 1px solid rgba(74,222,128,0.18); border-left: 3px solid var(--green); border-radius: 10px; padding: 12px 18px; margin: 20px 0 0; flex-wrap: wrap; }
    @keyframes pulse-dot { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.3;transform:scale(.6)} }
    .avail-dot { width: 8px; height: 8px; border-radius: 50%; background: var(--green); flex-shrink: 0; animation: pulse-dot 2s ease-in-out infinite; }
    .avail-text { font-family: "IBM Plex Mono", monospace; font-size: 0.62rem; letter-spacing: 0.14em; text-transform: uppercase; color: var(--green); }
    .avail-tags { display: flex; gap: 6px; flex-wrap: wrap; margin-left: auto; }
    .avail-tag { font-family: "IBM Plex Mono", monospace; font-size: 0.50rem; letter-spacing: 0.12em; text-transform: uppercase; color: rgba(74,222,128,0.75); border: 1px solid rgba(74,222,128,0.22); background: rgba(74,222,128,0.06); padding: 3px 10px; border-radius: 20px; }

    /* ══ DIVIDER ══ */
    .divider { display: flex; align-items: center; gap: 14px; margin: 28px 0 22px; }
    .divider span { font-family: "IBM Plex Mono", monospace; font-size: 0.57rem; letter-spacing: 0.2em; text-transform: uppercase; color: var(--muted); white-space: nowrap; }
    .dl  { flex: 1; height: 1px; background: linear-gradient(to right,  rgba(255,255,255,0.07), transparent); }
    .dlr { flex: 1; height: 1px; background: linear-gradient(to left,   rgba(255,255,255,0.07), transparent); }

    /* ══ ENGAGEMENT GRID ══ */
    .engage-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: clamp(10px,2vw,18px); }
    @media (max-width: 760px) { .engage-grid { grid-template-columns: 1fr 1fr; } }
    @media (max-width: 460px) { .engage-grid { grid-template-columns: 1fr; } }
    .ecard { background: var(--surface); border: 1px solid var(--border); border-radius: 14px; padding: 20px 18px 18px; display: flex; flex-direction: column; gap: 10px; position: relative; overflow: hidden; transition: border-color .25s, transform .25s; }
    .ecard::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 2px; background: linear-gradient(90deg, rgba(74,222,128,0.6), rgba(74,222,128,0.08)); }
    .ecard:hover { border-color: rgba(74,222,128,0.28); transform: translateY(-3px); }
    .ecard-icon { width: 42px; height: 42px; border-radius: 10px; display: flex; align-items: center; justify-content: center; background: rgba(74,222,128,0.08); border: 1px solid rgba(74,222,128,0.18); flex-shrink: 0; }
    .ecard-icon svg { width: 20px; height: 20px; stroke: var(--green); fill: none; stroke-width: 1.8; stroke-linecap: round; stroke-linejoin: round; }
    .ecard-label { font-family: "IBM Plex Mono", monospace; font-size: 0.48rem; letter-spacing: 0.2em; text-transform: uppercase; color: rgba(74,222,128,0.65); }
    .ecard-title { font-size: 0.9rem; font-weight: 700; color: var(--text); line-height: 1.2; }
    .ecard-body { font-size: 0.70rem; color: var(--muted); line-height: 1.65; flex: 1; }
    .ecard-body strong { color: #c8d4e8; font-weight: 600; }
    .ecard-footer { margin-top: auto; padding-top: 10px; border-top: 1px solid rgba(255,255,255,0.05); }
    .ecard-footer a { font-family: "IBM Plex Mono", monospace; font-size: 0.58rem; letter-spacing: 0.12em; text-transform: uppercase; color: var(--green); text-decoration: none; display: inline-flex; align-items: center; gap: 6px; transition: color .2s; }
    .ecard-footer a:hover { color: #86efac; }
    .ecard-footer a svg { width: 12px; height: 12px; stroke: currentColor; fill: none; stroke-width: 2.2; stroke-linecap: round; stroke-linejoin: round; }

    /* ══ METRICS ══ */
    .metrics-strip { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; }
    @media (max-width: 640px) { .metrics-strip { grid-template-columns: repeat(2,1fr); } }
    .mcard { background: rgba(19,25,41,0.85); border: 1px solid rgba(74,222,128,0.12); border-radius: 11px; padding: 14px 15px; text-align: center; position: relative; overflow: hidden; }
    .mcard::before { content:''; position:absolute; top:0; left:0; right:0; height:2px; background: linear-gradient(90deg, rgba(74,222,128,0.45), rgba(74,222,128,0.06)); }
    .mcard-num { font-size: 1.7rem; font-weight: 800; color: var(--green); letter-spacing: -0.03em; line-height: 1; }
    .mcard-label { font-family: "IBM Plex Mono", monospace; font-size: 0.50rem; letter-spacing: 0.14em; text-transform: uppercase; color: var(--muted); margin-top: 6px; }

    /* ══ SKILLS ══ */
    .skills-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
    @media (max-width: 560px) { .skills-grid { grid-template-columns: 1fr; } }
    .skill-block { background: rgba(19,25,41,0.7); border: 1px solid rgba(74,222,128,0.12); border-radius: 11px; padding: 14px 16px; }
    .skill-block-label { font-family: "IBM Plex Mono", monospace; font-size: 0.48rem; letter-spacing: 0.18em; text-transform: uppercase; color: rgba(74,222,128,0.55); margin-bottom: 8px; }
    .pill-row { display: flex; flex-wrap: wrap; gap: 4px; }
    .pill { font-family: "IBM Plex Mono", monospace; font-size: 0.47rem; letter-spacing: .10em; text-transform: uppercase; color: rgba(74,222,128,0.72); border: 1px solid rgba(74,222,128,0.20); background: rgba(74,222,128,0.05); padding: 2px 8px; border-radius: 20px; }

    /* ══ DOMAIN CARDS ══ */
    .domain-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 10px; }
    @media (max-width: 640px) { .domain-grid { grid-template-columns: repeat(2,1fr); } }
    .domain-card { background: rgba(19,25,41,0.7); border: 1px solid rgba(74,222,128,0.10); border-radius: 10px; padding: 14px 14px 12px; display: flex; flex-direction: column; gap: 6px; }
    .domain-icon { width: 34px; height: 34px; border-radius: 8px; background: rgba(74,222,128,0.07); border: 1px solid rgba(74,222,128,0.15); display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
    .domain-icon svg { width: 16px; height: 16px; stroke: var(--green); fill: none; stroke-width: 1.8; stroke-linecap: round; stroke-linejoin: round; }
    .domain-name { font-size: 0.72rem; font-weight: 700; color: var(--text); }
    .domain-sub { font-family: "IBM Plex Mono", monospace; font-size: 0.48rem; letter-spacing: 0.10em; text-transform: uppercase; color: var(--muted); }

    /* ══ POSITIONING QUOTE ══ */
    .positioning-wrap { background: rgba(19,25,41,0.7); border: 1px solid rgba(74,222,128,0.15); border-left: 3px solid var(--green); border-radius: 0 10px 10px 0; padding: 16px 20px; }
    .positioning-wrap p { font-size: clamp(0.72rem,1.1vw,0.82rem); color: #c8d4e8; line-height: 1.65; font-style: italic; }
    .positioning-wrap p strong { color: var(--green); font-style: normal; font-weight: 700; }
    .positioning-source { font-family: "IBM Plex Mono", monospace; font-size: 0.50rem; letter-spacing: 0.16em; text-transform: uppercase; color: var(--muted); margin-top: 8px; }

    /* ══ CTA STRIP ══ */
    .cta-strip { display: flex; align-items: center; justify-content: center; gap: clamp(10px,2vw,18px); flex-wrap: wrap; padding: clamp(22px,3vw,36px) 0; border-top: 1px solid rgba(74,222,128,0.08); margin-top: 28px; }
    .cta-btn { font-family: "IBM Plex Mono", monospace; font-size: 0.65rem; letter-spacing: 0.14em; text-transform: uppercase; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; padding: 10px 22px; border-radius: 8px; transition: background .2s, border-color .2s, transform .2s; }
    .cta-btn svg { width: 14px; height: 14px; stroke: currentColor; fill: none; stroke-width: 2; stroke-linecap: round; stroke-linejoin: round; }
    .cta-btn:active { transform: scale(0.97); }
    .cta-primary { background: rgba(74,222,128,0.12); border: 1px solid rgba(74,222,128,0.45); color: var(--green); }
    .cta-primary:hover { background: rgba(74,222,128,0.20); border-color: rgba(74,222,128,0.7); }
    .cta-secondary { background: rgba(19,25,41,0.9); border: 1px solid var(--border); color: var(--muted); }
    .cta-secondary:hover { border-color: rgba(255,255,255,0.2); color: var(--text); }

    /* ══ COPY TOAST ══ */
    .toast { position: fixed; bottom: 24px; left: 50%; transform: translateX(-50%) translateY(12px); background: rgba(74,222,128,0.12); border: 1px solid rgba(74,222,128,0.3); color: var(--green); padding: 8px 20px; border-radius: 8px; font-family: "IBM Plex Mono", monospace; font-size: 0.60rem; letter-spacing: 0.12em; text-transform: uppercase; opacity: 0; pointer-events: none; transition: opacity .3s, transform .3s; z-index: 200; }
    .toast.show { opacity: 1; transform: translateX(-50%) translateY(0); }
  </style>
</head>
<body>
  <div class="page-wrap">

    <section class="hire-hero" aria-label="Hire introduction">
      <div class="hero-photo-wrap">
        <img class="hero-photo" src="<%= ctx %>/images/20250424_170544.png" alt="GACIRANE Patrick — AI Solutions Builder" />
      </div>
      <div class="hero-identity">
        <a class="hero-name" href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer">GACIRANE Patrick</a>
        <span class="hero-role">AI Solutions Builder &amp; Digital Systems Developer</span>
      </div>
      <div class="hire-headline">
        <h1><span class="hl">Available</span> for AI&nbsp;roles &mdash;<br/>worldwide.</h1>
      </div>
      <div class="hire-sub">
        <p>AI Solutions Builder building <strong>production multi-agent systems</strong> grounded in regulatory, clinical, and financial contexts — with <strong>5 live demos</strong> you can interact with right now. Open to consulting engagements, part-time positions, and remote contracts across East Africa and internationally.</p>
      </div>
    </section>

    <div class="avail-banner" role="status" aria-live="polite">
      <span class="avail-dot" aria-hidden="true"></span>
      <span class="avail-text">Available now</span>
      <div class="avail-tags">
        <span class="avail-tag">East Africa &amp; International</span>
        <span class="avail-tag">Remote</span>
        <span class="avail-tag">Part-time</span>
        <span class="avail-tag">Consulting</span>
      </div>
    </div>

    <div class="divider"><div class="dl"></div><span>Value Proposition</span><div class="dlr"></div></div>
    <div class="positioning-wrap">
      <p>"I build <strong>end-to-end AI platforms</strong> — from multi-agent backends and hybrid RAG pipelines to production frontends with real-time streaming. Every system I build is grounded in real domain documentation and validated on production-grade data. I don't just prototype — I architect systems designed to scale."</p>
      <p class="positioning-source">— GACIRANE Patrick &mdash; 2026</p>
    </div>

    <div class="divider"><div class="dl"></div><span>By the numbers</span><div class="dlr"></div></div>
    <div class="metrics-strip" role="region" aria-label="Platform metrics">
      <div class="mcard"><div class="mcard-num">5</div><div class="mcard-label">Live AI Apps</div></div>
      <div class="mcard"><div class="mcard-num">9</div><div class="mcard-label">Max agents per crew</div></div>
      <div class="mcard"><div class="mcard-num">4</div><div class="mcard-label">MCP RAG servers</div></div>
      <div class="mcard"><div class="mcard-num">3</div><div class="mcard-label">Apps in development</div></div>
    </div>

    <div class="divider"><div class="dl"></div><span>How I can help you</span><div class="dlr"></div></div>
    <div class="engage-grid">
      <div class="ecard">
        <div class="ecard-icon"><svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg></div>
        <span class="ecard-label">Full-time / Long-term</span>
        <div class="ecard-title">AI Solutions Builder</div>
        <div class="ecard-body">Join your team as an <strong>AI/ML Engineer or Solutions Architect</strong>. I design and build production AI systems end-to-end — multi-agent backends, RAG pipelines, streaming frontends, and vector datastores.</div>
        <div class="ecard-footer"><a href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer">Connect on LinkedIn <svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a></div>
      </div>
      <div class="ecard">
        <div class="ecard-icon"><svg viewBox="0 0 24 24"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/><line x1="12" y1="12" x2="12" y2="12.01"/></svg></div>
        <span class="ecard-label">Consulting / Contract</span>
        <div class="ecard-title">AI Platform Consulting</div>
        <div class="ecard-body">Fractional AI architect for your organisation. Scope includes: <strong>RAG system design</strong>, multi-agent pipeline architecture, LLMOps, AI ethics assessments, or scaling a prototype to production. Government, NGO, and enterprise.</div>
        <div class="ecard-footer"><a href="mailto:pgacirane@gmail.com">Discuss your project <svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a></div>
      </div>
      <div class="ecard">
        <div class="ecard-icon"><svg viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg></div>
        <span class="ecard-label">Partnerships / Investors</span>
        <div class="ecard-title">Scale an MVP</div>
        <div class="ecard-body">All five live MVPs are <strong>ready to scale</strong> with production investment. Each is architecturally validated, domain-grounded, and designed to grow into a national or regional platform.</div>
        <div class="ecard-footer"><a href="mailto:pgacirane@gmail.com">Start the conversation <svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a></div>
      </div>
    </div>

    <div class="divider"><div class="dl"></div><span>Domain expertise</span><div class="dlr"></div></div>
    <div class="domain-grid">
      <div class="domain-card"><div class="domain-icon"><svg viewBox="0 0 24 24"><line x1="12" y1="3" x2="12" y2="21"/><line x1="4" y1="6" x2="20" y2="6"/><path d="M4 6 L2 11 Q4 13 6 11 Z"/><path d="M20 6 L18 11 Q20 13 22 11 Z"/></svg></div><div class="domain-name">Legal Tech</div><div class="domain-sub">Multi-jurisdiction · RAG grounded</div></div>
      <div class="domain-card"><div class="domain-icon"><svg viewBox="0 0 24 24"><rect x="3" y="10" width="2.5" height="9" rx="0.5"/><rect x="7.5" y="10" width="2.5" height="9" rx="0.5"/><polyline points="1 10 12 3 23 10"/><line x1="1" y1="19" x2="23" y2="19"/></svg></div><div class="domain-name">Banking / Fintech</div><div class="domain-sub">CRM · advisory · financial RAG</div></div>
      <div class="domain-card"><div class="domain-icon"><svg viewBox="0 0 24 24"><rect x="9" y="3" width="6" height="18" rx="1.5"/><rect x="3" y="9" width="18" height="6" rx="1.5"/></svg></div><div class="domain-name">Clinical Health</div><div class="domain-sub">Clinical guidelines · decision support</div></div>
      <div class="domain-card"><div class="domain-icon"><svg viewBox="0 0 24 24"><polygon points="12 3 22 8 12 13 2 8"/><path d="M6 10.5 v5 Q12 18.5 18 15.5 v-5"/></svg></div><div class="domain-name">EdTech</div><div class="domain-sub">Student advisory · agentic career tools</div></div>
      <div class="domain-card"><div class="domain-icon"><svg viewBox="0 0 24 24"><rect x="2" y="3" width="5" height="4" rx="1"/><rect x="17" y="3" width="5" height="4" rx="1"/><rect x="9" y="17" width="6" height="4" rx="1"/><line x1="4.5" y1="7" x2="4.5" y2="14"/><line x1="19.5" y1="7" x2="19.5" y2="14"/><line x1="4.5" y1="14" x2="12" y2="19"/><line x1="19.5" y1="14" x2="12" y2="19"/></svg></div><div class="domain-name">RegTech</div><div class="domain-sub">Compliance intelligence · multi-regulator AI</div></div>
      <div class="domain-card"><div class="domain-icon"><svg viewBox="0 0 24 24"><path d="M12 2L3 7v5c0 5.25 3.75 10.15 9 11.25C17.25 22.15 21 17.25 21 12V7z"/><polyline points="9 12 11 14 15 10"/></svg></div><div class="domain-name">AI Ethics</div><div class="domain-sub">Social impact assessment · responsible AI</div></div>
    </div>

    <div class="divider"><div class="dl"></div><span>Technical skills</span><div class="dlr"></div></div>
    <div class="skills-grid">
      <div class="skill-block">
        <div class="skill-block-label">AI / ML Engineering</div>
        <div class="pill-row"><span class="pill">CrewAI multi-agent</span><span class="pill">RAG pipelines</span><span class="pill">MCP servers</span><span class="pill">Hybrid BM25 + semantic search</span><span class="pill">RRF re-ranking</span><span class="pill">ChromaDB</span><span class="pill">FAISS</span><span class="pill">LangChain</span><span class="pill">SSE streaming</span><span class="pill">LLMOps</span></div>
      </div>
      <div class="skill-block">
        <div class="skill-block-label">Backend / Infrastructure</div>
        <div class="pill-row"><span class="pill">Python · FastAPI</span><span class="pill">Java EE · JSP · Tomcat 9</span><span class="pill">PostgreSQL</span><span class="pill">Redis · RQ</span><span class="pill">HuggingFace Spaces</span><span class="pill">Cloud deployment</span><span class="pill">Maven · NetBeans</span><span class="pill">Git</span></div>
      </div>
      <div class="skill-block">
        <div class="skill-block-label">Domain &amp; Context</div>
        <div class="pill-row"><span class="pill">Regulatory frameworks</span><span class="pill">Clinical guidelines</span><span class="pill">Financial compliance</span><span class="pill">Public procurement</span><span class="pill">East Africa context</span><span class="pill">Social Impact Matrix</span></div>
      </div>
      <div class="skill-block">
        <div class="skill-block-label">Architecture patterns</div>
        <div class="pill-row"><span class="pill">Multi-agent orchestration</span><span class="pill">Hybrid retrieval</span><span class="pill">Map-reduce summarisation</span><span class="pill">Complexity-based routing</span><span class="pill">Reverse proxy</span><span class="pill">MSc Computer Science</span><span class="pill">Published research</span></div>
      </div>
    </div>

    <div class="cta-strip" role="region" aria-label="Contact actions">
      <a class="cta-btn cta-primary" href="mailto:pgacirane@gmail.com">
        <svg viewBox="0 0 24 24"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
        Email me directly
      </a>
      <a class="cta-btn cta-primary" href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer">
        <svg viewBox="0 0 24 24"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/><rect x="2" y="9" width="4" height="12"/><circle cx="4" cy="4" r="2"/></svg>
        LinkedIn profile
      </a>
      <a class="cta-btn cta-primary" href="<%= ctx %>/AiBotsDashboard#apps">
        <svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="7"/><line x1="16.5" y1="16.5" x2="21" y2="21"/></svg>
        View live demos
      </a>
      <button class="cta-btn cta-secondary" onclick="copyEmail()">
        <svg viewBox="0 0 24 24"><rect x="9" y="9" width="13" height="13" rx="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>
        Copy email
      </button>
    </div>

  </div><!-- /page-wrap -->

  <div class="toast" id="toast" role="status" aria-live="polite">Email copied!</div>
  <script>
    function copyEmail() {
      navigator.clipboard.writeText("pgacirane@gmail.com").then(() => {
        const t = document.getElementById("toast");
        t.classList.add("show");
        setTimeout(() => t.classList.remove("show"), 2400);
      });
    }
  </script>
</body>
</html>
