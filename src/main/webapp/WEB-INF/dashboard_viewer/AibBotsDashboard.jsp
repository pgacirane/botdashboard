<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>AIonifier — AI MVP Showcase</title>
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
      --nav-h:   52px;
    }
    html { scroll-behavior: smooth; scroll-padding-top: var(--nav-h); }
    body {
      background: var(--bg); color: var(--text);
      font-family: "Sora", sans-serif;
      -webkit-font-smoothing: antialiased;
    }
    body::before {
      content: ""; position: fixed; inset: 0; z-index: 0; pointer-events: none;
      background: radial-gradient(ellipse 80% 55% at 10% 0%,
        rgba(74,222,128,0.07) 0%, transparent 60%);
    }

    /* ══ NAV ══ */
    .site-nav {
      position: fixed; top: 0; left: 0; right: 0; z-index: 100;
      height: var(--nav-h);
      background: rgba(11,15,26,0.94);
      backdrop-filter: blur(14px);
      border-bottom: 1px solid var(--border);
      display: flex; align-items: center;
      padding: 0 clamp(16px,4vw,48px);
    }
    .nav-inner {
      width: 100%; max-width: 1200px; margin: 0 auto;
      display: flex; align-items: center; justify-content: space-between; gap: 12px;
    }
    .nav-brand {
      font-family: "IBM Plex Mono", monospace;
      font-size: 0.7rem; letter-spacing: 0.22em; text-transform: uppercase;
      color: var(--green); text-decoration: none;
      display: flex; align-items: center; gap: 7px; flex-shrink: 0;
    }
    .nav-dot {
      width: 6px; height: 6px; border-radius: 50%;
      background: var(--green); box-shadow: 0 0 7px var(--green);
      animation: blink 2.4s ease-in-out infinite;
    }
    @keyframes blink { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.3;transform:scale(.65)} }
    .nav-links { display: flex; align-items: center; gap: 2px; list-style: none; }
    .nav-links a {
      font-family: "IBM Plex Mono", monospace;
      font-size: 0.62rem; letter-spacing: 0.12em; text-transform: uppercase;
      color: var(--muted); text-decoration: none;
      padding: 5px 11px; border-radius: 5px;
      transition: color .2s, background .2s; white-space: nowrap;
    }
    .nav-links a:hover, .nav-links a.active { color: var(--green); background: rgba(74,222,128,0.08); }
    .nav-pip { width: 3px; height: 3px; border-radius: 50%; background: rgba(255,255,255,0.12); margin: 0 2px; }
    .nav-ctas { display: flex; align-items: center; gap: 8px; flex-shrink: 0; }
    .nav-cta {
      font-family: "IBM Plex Mono", monospace;
      font-size: 0.62rem; letter-spacing: 0.12em; text-transform: uppercase;
      color: var(--green); text-decoration: none;
      border: 1px solid rgba(74,222,128,0.35);
      padding: 4px 12px; border-radius: 5px;
      display: flex; align-items: center; gap: 6px;
      transition: background .2s, border-color .2s;
      white-space: nowrap;
    }
    .nav-cta:hover { background: rgba(74,222,128,0.10); border-color: rgba(74,222,128,0.6); }
    .nav-cta svg { width: 13px; height: 13px; stroke: var(--green); fill: none; stroke-width: 2; stroke-linecap: round; stroke-linejoin: round; flex-shrink: 0; }
    .nav-burger {
      display: none; flex-direction: column; justify-content: center; gap: 5px;
      width: 32px; height: 32px; cursor: pointer; background: none; border: none; padding: 4px;
    }
    .nav-burger span {
      display: block; height: 1.5px; border-radius: 2px; background: var(--muted);
      transition: transform .3s, opacity .3s;
    }
    .nav-burger span:nth-child(2) { width: 70%; }
    .nav-burger.open span:nth-child(1) { transform: translateY(6.5px) rotate(45deg); }
    .nav-burger.open span:nth-child(2) { opacity: 0; }
    .nav-burger.open span:nth-child(3) { transform: translateY(-6.5px) rotate(-45deg); }
    .nav-drawer {
      display: none; position: fixed;
      top: var(--nav-h); left: 0; right: 0; z-index: 99;
      background: rgba(13,17,30,0.98); backdrop-filter: blur(16px);
      border-bottom: 1px solid var(--border);
      padding: 14px clamp(16px,5vw,48px) 18px;
      flex-direction: column; gap: 3px;
    }
    .nav-drawer.open { display: flex; }
    .nav-drawer a {
      font-family: "IBM Plex Mono", monospace;
      font-size: 0.68rem; letter-spacing: 0.14em; text-transform: uppercase;
      color: var(--muted); text-decoration: none;
      padding: 9px 11px; border-radius: 5px;
      transition: color .2s, background .2s;
    }
    .nav-drawer a:hover { color: var(--green); background: rgba(74,222,128,0.08); }
    .drawer-sep { height: 1px; background: rgba(255,255,255,0.05); margin: 5px 0; }
    .drawer-cta { color: var(--green) !important; border: 1px solid rgba(74,222,128,0.28); text-align: center; margin-top: 2px; }
    @media (max-width: 760px) {
      .nav-links, .nav-ctas { display: none; }
      .nav-burger { display: flex; }
    }

    /* ══ PAGE WRAP ══ */
    .page-wrap {
      position: relative; z-index: 1;
      padding-top: var(--nav-h);
      padding-bottom: 72px;
      max-width: 1200px; margin: 0 auto;
      padding-left: clamp(16px, 4vw, 48px);
      padding-right: clamp(16px, 4vw, 48px);
    }

    /* ══ HERO STRIP ══ */
    .hero {
      display: grid;
      grid-template-columns: auto 1fr;
      grid-template-rows: auto auto;
      column-gap: clamp(20px, 3vw, 36px);
      align-items: center;
      width: 100%;
      padding: clamp(20px, 3vw, 32px) 0 0;
      border-bottom: 1px solid rgba(74,222,128,0.1);
      margin-bottom: 0;
    }

    /* Photo — spans both rows on left, ALL screen sizes */
    .hero-photo-wrap {
      grid-row: 1 / 3;
      grid-column: 1;
      flex-shrink: 0;
      align-self: stretch;
      display: flex; align-items: center;
    }
    .hero-photo {
      width: clamp(68px, 9vw, 118px); /* clamp keeps photo proportional on all widths */
      height: auto;
      border-radius: 10px;
      display: block;
      border: 2px solid rgba(74,222,128,0.50);
      box-shadow:
        0 0 0 4px rgba(74,222,128,0.07),
        0 8px 28px rgba(0,0,0,0.55);
    }

    /* Top row: identity line */
    .hero-identity {
      grid-row: 1; grid-column: 2;
      display: flex; align-items: baseline; gap: clamp(6px, 1.5vw, 16px);
      flex-wrap: wrap;
      padding-top: 6px;
    }
    .hero-name {
      font-size: clamp(0.78rem, 1.5vw, 1rem);
      font-weight: 700; color: var(--green);
      text-decoration: none; letter-spacing: 0.03em;
      border-bottom: 1px solid rgba(74,222,128,0.3);
      transition: color .2s; white-space: nowrap;
    }
    .hero-name:hover { color: #86efac; }
    .hero-role {
      font-family: "IBM Plex Mono", monospace;
      font-size: clamp(0.50rem, 1vw, 0.65rem);
      letter-spacing: 0.14em; text-transform: uppercase;
      color: var(--muted);
    }

    /* Bottom row: big title */
    .hero-title-wrap {
      grid-row: 2; grid-column: 2;
      padding-bottom: clamp(14px, 2vw, 22px);
    }
    .hero-title {
      font-size: clamp(1.3rem, 4.5vw, 3.2rem);
      font-weight: 800; line-height: 1.08;
      letter-spacing: -0.03em;
      color: var(--text);
      width: 100%;
      /* Always wrap — never force single line at small sizes */
      white-space: normal;
    }
    .hero-title .hl {
      background: linear-gradient(110deg, var(--green) 0%, #86efac 100%);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }

    /*
     * ── MOBILE HERO — photo ALWAYS stays beside text ──────────────────
     * We deliberately do NOT switch to a single-column grid on small
     * screens. Instead we only shrink the photo and tighten the gap.
     * The grid stays: [photo col] [text col] at every viewport width.
     * ─────────────────────────────────────────────────────────────────
     */
    @media (max-width: 560px) {
      .hero { column-gap: clamp(10px, 3vw, 16px); }
      .hero-photo { width: clamp(58px, 18vw, 82px); }
      .hero-title { font-size: clamp(1.05rem, 6vw, 1.5rem); }
    }

    /* ── Subtitle ── */
    .hero-sub {
      font-size: clamp(0.78rem, 1.4vw, 0.9rem);
      color: var(--muted); line-height: 1.7; font-weight: 300;
      width: 100%; max-width: 860px;
      padding: 14px 0 0;
    }
    .hero-sub strong { color: var(--text); font-weight: 600; }

    /* ── Disclaimer bar ── */
    .disclaimer {
      display: flex; align-items: flex-start; gap: 10px;
      background: rgba(74,222,128,0.04);
      border: 1px solid rgba(74,222,128,0.16);
      border-left: 3px solid rgba(74,222,128,0.5);
      border-radius: 8px; padding: 11px 16px;
      margin: 16px 0 0; width: 100%;
    }
    .disclaimer-icon { font-size: 0.8rem; flex-shrink: 0; margin-top: 2px; }
    .disclaimer p {
      font-family: "IBM Plex Mono", monospace;
      font-size: clamp(0.54rem, 0.9vw, 0.62rem);
      letter-spacing: 0.09em; text-transform: uppercase;
      color: var(--muted); line-height: 1.75;
    }
    .disclaimer p strong { color: var(--green); font-weight: 500; }
    .disclaimer a { color: var(--green); text-decoration: none; border-bottom: 1px solid rgba(74,222,128,0.28); }

    /* ══ SECTION DIVIDER ══ */
    .divider {
      display: flex; align-items: center; gap: 14px;
      margin: 28px 0 22px;
    }
    .divider span {
      font-family: "IBM Plex Mono", monospace;
      font-size: 0.57rem; letter-spacing: 0.2em; text-transform: uppercase;
      color: var(--muted); white-space: nowrap;
    }
    .dl  { flex: 1; height: 1px; background: linear-gradient(to right,  rgba(255,255,255,0.07), transparent); }
    .dlr { flex: 1; height: 1px; background: linear-gradient(to left,   rgba(255,255,255,0.07), transparent); }

    /* ══ GRID ══ */
    .bots-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: clamp(12px, 2vw, 22px);
      width: 100%;
    }
    @media (max-width: 860px) {
      .bots-grid { grid-template-columns: repeat(2, 1fr); }
      .bots-grid .bot-card:nth-child(5) { grid-column: auto; }
    }
    @media (max-width: 480px) { .bots-grid { grid-template-columns: 1fr; } }

    /* ══════════════════════════════════════════════════════════════════
       COMING-SOON CARDS — green palette, same as live cards.
       Visual distinction:
         • Dashed border (vs solid on live cards)
         • Green top accent stripe
         • Slightly dimmed background
         • "Upcoming MVP" badge with pulsing dot
         • No hover lift — not clickable
         • Fit into the normal 3-column grid row (no full-width span)
    ══════════════════════════════════════════════════════════════════ */

    .bot-card.coming-soon {
      /* sits in the normal 3-col grid — no grid-column override */
      flex-direction: column;   /* same column layout as live cards  */
      cursor: default;
      border-style: dashed;
      border-color: rgba(74,222,128,0.28);
      border-top: 3px solid rgba(74,222,128,0.55); /* top accent stripe */
      background: rgba(13,17,28,0.7);
      opacity: 0.9;
    }
    .bot-card.coming-soon:hover {
      transform: none;
      box-shadow: none;
      border-color: rgba(74,222,128,0.42);
    }
    .bot-card.coming-soon:hover::before { opacity: 0.3; }

    /* icon same size as live cards */
    .bot-card.coming-soon .bot-icon {
      width: clamp(44px,6vw,54px);
      height: clamp(44px,6vw,54px);
    }

    /* "Upcoming MVP" badge — green */
    .soon-badge {
      display: inline-flex; align-items: center; gap: 6px;
      font-family: "IBM Plex Mono", monospace;
      font-size: clamp(0.54rem, 0.9vw, 0.62rem);
      letter-spacing: 0.18em; text-transform: uppercase;
      color: var(--green);
      border: 1px dashed rgba(74,222,128,0.45);
      background: rgba(74,222,128,0.06);
      padding: 3px 10px; border-radius: 20px;
      margin-bottom: 8px; width: fit-content;
    }
    .soon-badge::before {
      content: ''; width: 6px; height: 6px; border-radius: 50%;
      background: var(--green); opacity: .75;
      animation: blink 1.8s ease-in-out infinite;
    }

    /* footer row inside coming-soon: label + eta stacked */
    .cs-footer {
      display: flex; align-items: center; justify-content: space-between;
      margin-top: auto; padding-top: 12px;
      border-top: 1px solid rgba(255,255,255,0.05);
    }
    .cs-eta {
      font-family: "IBM Plex Mono", monospace;
      font-size: clamp(0.52rem, 0.85vw, 0.60rem);
      letter-spacing: 0.12em; text-transform: uppercase;
      color: var(--muted); opacity: .6; white-space: nowrap;
    }

    /* ── Card ── */
    .bot-card {
      position: relative; border-radius: 16px;
      padding: clamp(18px,2.5vw,26px) clamp(16px,2vw,22px) clamp(16px,2vw,22px);
      text-decoration: none; cursor: pointer;
      display: flex; flex-direction: column; gap: 12px;
      background: var(--surface); border: 1px solid var(--border); overflow: hidden;
      transition: transform .3s cubic-bezier(.22,.68,0,1.2), box-shadow .3s, border-color .3s;
    }
    .bot-card::before {
      content: ""; position: absolute; inset: 0; border-radius: 16px;
      background: radial-gradient(ellipse at top left, rgba(74,222,128,0.09) 0%, transparent 65%);
      opacity: 0; transition: opacity .3s; pointer-events: none;
    }
    .bot-card:hover {
      transform: translateY(-5px) scale(1.01);
      border-color: rgba(74,222,128,0.3);
      box-shadow: 0 18px 40px rgba(74,222,128,0.11);
    }
    .bot-card:hover::before { opacity: 1; }
    .mvp-tag {
      position: absolute; top: 11px; right: 0;
      font-family: "IBM Plex Mono", monospace;
      font-size: 0.48rem; letter-spacing: 0.18em; text-transform: uppercase;
      padding: 3px 8px 3px 6px; border-radius: 4px 0 0 4px;
      background: rgba(74,222,128,0.07);
      border: 1px solid rgba(74,222,128,0.16); border-right: none;
      color: rgba(74,222,128,0.6);
    }
    .corner-glow {
      position: absolute; top: -16px; right: -16px;
      width: 72px; height: 72px; border-radius: 50%;
      background: radial-gradient(circle, rgba(74,222,128,0.11) 0%, transparent 70%);
      pointer-events: none;
    }
    .bot-icon {
      width: clamp(44px,6vw,54px); height: clamp(44px,6vw,54px);
      border-radius: 12px; display: flex; align-items: center; justify-content: center;
      background: rgba(74,222,128,0.09); border: 1px solid rgba(74,222,128,0.2);
      flex-shrink: 0; transition: background .3s, transform .3s;
    }
    .bot-icon svg {
      width: clamp(22px,3vw,26px); height: clamp(22px,3vw,26px);
      stroke: var(--green); fill: none; stroke-width: 1.8;
      stroke-linecap: round; stroke-linejoin: round;
    }
    .bot-card:hover .bot-icon { background: rgba(74,222,128,0.17); transform: rotate(-4deg) scale(1.08); }
    .bot-field {
      font-family: "IBM Plex Mono", monospace;
      font-size: clamp(0.52rem, 0.85vw, 0.60rem);
      letter-spacing: 0.17em; text-transform: uppercase;
      color: var(--green); opacity: .72; margin-bottom: 3px; display: block;
    }
    .bot-name {
      font-size: clamp(0.9rem, 1.5vw, 1.04rem); font-weight: 700;
      color: var(--text); margin: 0 0 7px; line-height: 1.22;
    }
    .bot-desc {
      font-size: clamp(0.70rem, 1.1vw, 0.77rem);
      color: var(--muted); line-height: 1.65; margin: 0; font-weight: 300;
    }
    .bot-scale {
      font-family: "IBM Plex Mono", monospace;
      font-size: 0.52rem; letter-spacing: 0.11em; text-transform: uppercase;
      color: var(--green); opacity: .45; margin-top: 3px;
      display: flex; align-items: center; gap: 4px;
    }
    .bot-scale::before {
      content: ""; display: inline-block;
      width: 4px; height: 4px; border-radius: 50%; background: var(--green);
    }
    .bot-footer {
      display: flex; align-items: center; justify-content: space-between;
      margin-top: auto; padding-top: 12px;
      border-top: 1px solid rgba(255,255,255,0.05);
    }
    .launch-label {
      font-family: "IBM Plex Mono", monospace;
      font-size: clamp(0.54rem, 0.88vw, 0.62rem); letter-spacing: 0.1em;
      text-transform: uppercase; color: var(--green); opacity: .58;
      transition: opacity .2s;
    }
    .bot-card:hover .launch-label { opacity: 1; }
    .arrow-circle {
      width: 28px; height: 28px; border-radius: 50%; flex-shrink: 0;
      background: rgba(74,222,128,0.09); border: 1px solid rgba(74,222,128,0.26);
      display: flex; align-items: center; justify-content: center;
      transition: background .25s, transform .25s;
    }
    .arrow-circle svg { width: 12px; height: 12px; stroke: var(--green); fill: none; stroke-width: 2.2; stroke-linecap: round; stroke-linejoin: round; transition: stroke .25s; }
    .bot-card:hover .arrow-circle { background: var(--green); transform: translateX(3px); }
    .bot-card:hover .arrow-circle svg { stroke: var(--bg); }

    /* ══ FOOTER ══ */
    .page-footer {
      text-align: center; margin-top: clamp(36px,5vw,56px);
      padding-top: 20px; border-top: 1px solid var(--border);
    }
    .page-footer p {
      font-family: "IBM Plex Mono", monospace; font-size: 0.58rem;
      letter-spacing: 0.14em; text-transform: uppercase; color: var(--muted);
    }
    .page-footer a { color: var(--green); text-decoration: none; border-bottom: 1px solid rgba(74,222,128,0.26); }
    .page-footer a:hover { color: #86efac; }
  </style>
</head>
<body>

  <!-- NAV -->
  <nav class="site-nav" role="navigation" aria-label="Main navigation">
    <div class="nav-inner">
      <a class="nav-brand" href="#top"><span class="nav-dot"></span>AIonifier</a>
      <ul class="nav-links" role="list">
        <li><a href="#top">Home</a></li>
        <li><span class="nav-pip"></span></li>
        <li><a href="#apps">AI MVPs</a></li>
        <li><span class="nav-pip"></span></li>
        <li><a href="<%= ctx %>/BotViewer?bot=arch">Architecture</a></li>
      </ul>
      <div class="nav-ctas">
        <a class="nav-cta" href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer">
          <svg viewBox="0 0 24 24"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/><rect x="2" y="9" width="4" height="12"/><circle cx="4" cy="4" r="2"/></svg>
          LinkedIn
        </a>
        <a class="nav-cta" href="https://github.com/pgacirane" target="_blank" rel="noopener noreferrer">
          <svg viewBox="0 0 24 24"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"/></svg>
          GitHub
        </a>
      </div>
      <button class="nav-burger" id="burger" aria-label="Toggle menu" aria-expanded="false">
        <span></span><span></span><span></span>
      </button>
    </div>
  </nav>

  <div class="nav-drawer" id="drawer" role="menu">
    <a href="#top" role="menuitem">Home</a>
    <a href="#apps" role="menuitem">AI MVPs</a>
    <div class="drawer-sep"></div>
    <a href="<%= ctx %>/BotViewer?bot=arch" role="menuitem">Architecture</a>
    <div class="drawer-sep"></div>
    <a href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer" class="drawer-cta">&#128100; LinkedIn</a>
    <a href="https://github.com/pgacirane" target="_blank" rel="noopener noreferrer" class="drawer-cta" style="margin-top:6px;">&#128187; GitHub</a>
  </div>

  <!-- PAGE -->
  <div id="top" class="page-wrap">

    <!-- ══ FULL-WIDTH HERO ══ -->
    <section class="hero">

      <!-- Photo (spans both rows — all screen sizes) -->
      <div class="hero-photo-wrap">
        <img class="hero-photo"
             src="<%= ctx %>/images/20250424_170544.png"
             alt="GACIRANE Patrick — AI Solutions Architect" />
      </div>

      <!-- Row 1: Name + Role -->
      <div class="hero-identity">
        <a class="hero-name"
           href="https://www.linkedin.com/in/patricus/"
           target="_blank" rel="noopener noreferrer">GACIRANE Patrick</a>
        <span class="hero-role">AI Solutions Architect</span>
      </div>

      <!-- Row 2: Title -->
      <div class="hero-title-wrap">
        <h1 class="hero-title">
          <span class="hl">AIonifier</span> &mdash; AI&nbsp;MVP&nbsp;Portfolio
        </h1>
      </div>

    </section>

    <!-- Subtitle -->
    <p class="hero-sub">
      Six applied AI systems spanning <strong>Healthcare, Legal, Banking, Education, Talent,Human Resource,</strong> and <strong>Infrastructure</strong> —
      plus <strong>3 AI applications in development</strong> (FundTech &amp; Voice AI &amp; RegTech) —
      each a <strong>Minimum Viable Product</strong> built and designed to scale into enterprise-grade products.
    </p>

    <!-- Disclaimer -->
    <div class="disclaimer" role="note">
      <span class="disclaimer-icon">&#9888;</span>
      <p>
        <strong>Showcase &amp; Demo Platform Only.</strong>
        AIonifier is a personal AI portfolio by GACIRANE Patrick.
        All applications are <strong>Minimum Viable Products (MVPs)</strong> built to demonstrate agentic AI engineering across real-world domains.
        They are <strong>not intended for production use</strong> in clinical, legal, financial, or any critical decision-making context.
        <strong>You can hire Me</strong> to design and build similar agentic systems or <strong>investors or partners</strong> interested in scaling any MVP into a full product are welcome to
        <a href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer">reach out on LinkedIn</a>.
      </p>
    </div>

    <!-- Divider -->
    <div class="divider" id="apps">
      <div class="dl"></div>
      <span>AI MVP Applications &mdash; Select a Specialist</span>
      <div class="dlr"></div>
    </div>

    <!-- GRID -->
    <div class="bots-grid">

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=legal">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon">
          <svg viewBox="0 0 24 24"><line x1="12" y1="3" x2="12" y2="21"/><line x1="4" y1="6" x2="20" y2="6"/><path d="M4 6 L2 11 Q4 13 6 11 Z"/><path d="M20 6 L18 11 Q20 13 22 11 Z"/><line x1="8" y1="21" x2="16" y2="21"/></svg>
        </div>
        <div>
          <span class="bot-field">Legal Tech &middot; Compliance Automation</span>
          <h2 class="bot-name">Global Legal Advisor</h2>
          <p class="bot-desc">Navigate international regulations, draft legal briefs, and get jurisdiction-aware guidance across 180+ countries via multi-agent legal reasoning.</p>
          <p class="bot-scale">Scalable &rarr; Enterprise Legal Intelligence Platform</p>
        </div>
        <div class="bot-footer">
          <span class="launch-label">Launch advisor</span>
          <span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span>
        </div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=bank">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon">
          <svg viewBox="0 0 24 24"><rect x="3" y="10" width="2.5" height="9" rx="0.5"/><rect x="7.5" y="10" width="2.5" height="9" rx="0.5"/><rect x="14" y="10" width="2.5" height="9" rx="0.5"/><rect x="18.5" y="10" width="2.5" height="9" rx="0.5"/><polyline points="1 10 12 3 23 10"/><line x1="1" y1="19" x2="23" y2="19"/><polyline points="7.5 16 10 13.5 14 15 18.5 11.5" stroke-width="1.4"/></svg>
        </div>
        <div>
          <span class="bot-field">Banking &middot; CRM &middot; Financial Services</span>
          <h2 class="bot-name">Bank CRM Advisor</h2>
          <p class="bot-desc">Deepen client relationships, automate follow-ups, and surface actionable insights from banking CRM data — powered by a 9-agent CrewAI system.</p>
          <p class="bot-scale">Scalable &rarr; Retail Banking Intelligence Suite</p>
        </div>
        <div class="bot-footer">
          <span class="launch-label">Launch advisor</span>
          <span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span>
        </div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=hiv">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon">
          <svg viewBox="0 0 24 24"><rect x="9" y="3" width="6" height="18" rx="1.5"/><rect x="3" y="9" width="18" height="6" rx="1.5"/><polyline points="3 12 6 12 8 8 10 16 12 10 14 14 16 12 21 12" stroke-width="1.3" stroke="#0b0f1a" fill="none"/></svg>
        </div>
        <div>
          <span class="bot-field">Healthcare &middot; Clinical Guidelines &middot; HIV/AIDS</span>
          <h2 class="bot-name">HIV Guidelines Assistant</h2>
          <p class="bot-desc">Retrieve verified ART regimens, PMTCT protocols, and paediatric dosing from Rwanda HIV Guidelines 2022 via RAG over RBC clinical documentation.</p>
          <p class="bot-scale">Scalable &rarr; National Clinical Decision Support System</p>
        </div>
        <div class="bot-footer">
          <span class="launch-label">Launch advisor</span>
          <span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span>
        </div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=grad">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon">
          <svg viewBox="0 0 24 24"><polygon points="12 3 22 8 12 13 2 8"/><path d="M6 10.5 v5 Q12 18.5 18 15.5 v-5"/><line x1="22" y1="8" x2="22" y2="14"/><circle cx="22" cy="15" r="1" fill="#4ade80" stroke="none"/></svg>
        </div>
        <div>
          <span class="bot-field">EdTech &middot; Career Advisory &middot; Education</span>
          <h2 class="bot-name">Smart Grad</h2>
          <p class="bot-desc">Agentic university scouting, financial roadmapping, visa navigation and cultural landing — built for any students pursuing global education.</p>
          <p class="bot-scale">Scalable &rarr; Global Student Advisory Platform</p>
        </div>
        <div class="bot-footer">
          <span class="launch-label">Launch advisor</span>
          <span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span>
        </div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=cv">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon">
          <svg viewBox="0 0 24 24"><rect x="2" y="5" width="15" height="14" rx="2"/><circle cx="7" cy="11" r="2.5"/><line x1="11" y1="9.5" x2="14.5" y2="9.5"/><line x1="11" y1="12" x2="14.5" y2="12"/><path d="M17 4 h4 a1 1 0 0 1 1 1 v5 a1 1 0 0 1 -1 1 h-2 l-2 2 v-2 a1 1 0 0 1 -1 -1 v-5 a1 1 0 0 1 1 -1 z"/><circle cx="19" cy="7" r="0.6" fill="#4ade80" stroke="none"/><circle cx="21" cy="7" r="0.6" fill="#4ade80" stroke="none"/></svg>
        </div>
        <div>
          <span class="bot-field">HRTech &middot; Talent Intelligence &middot; Recruitment</span>
          <h2 class="bot-name">Talk to My CV</h2>
          <p class="bot-desc">Chat directly with Patrick's CV — skills, projects, and experience all conversationally accessible via RAG-powered talent profiling.</p>
          <p class="bot-scale">Scalable &rarr; AI-Powered Recruitment Screening Tool</p>
        </div>
        <div class="bot-footer">
          <span class="launch-label">Start a conversation</span>
          <span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span>
        </div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=arch">
        <div class="corner-glow"></div><span class="mvp-tag">DOCS</span>
        <div class="bot-icon">
          <svg viewBox="0 0 24 24">
            <circle cx="12" cy="5" r="2"/><circle cx="4" cy="19" r="2"/>
            <circle cx="20" cy="19" r="2"/><circle cx="12" cy="19" r="2"/>
            <line x1="12" y1="7" x2="12" y2="17"/>
            <line x1="12" y1="17" x2="4" y2="17"/><line x1="12" y1="17" x2="20" y2="17"/>
            <line x1="4" y1="17" x2="4" y2="19"/><line x1="20" y1="17" x2="20" y2="19"/>
            <line x1="12" y1="17" x2="12" y2="19"/>
          </svg>
        </div>
        <div>
          <span class="bot-field">Platform &middot; AI Infrastructure &middot; Tech Stack</span>
          <h2 class="bot-name">Platform Architecture</h2>
          <p class="bot-desc">Explore multi-agent pipelines, RAG MCP servers, Java EE frontends, HuggingFace deployments and PostgreSQL datastores behind all five domain MVPs.</p>
          <p class="bot-scale">Underpins &rarr; All 5 AI domain MVPs above</p>
        </div>
        <div class="bot-footer">
          <span class="launch-label">View architecture</span>
          <span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span>
        </div>
      </a>

      <!-- ══ AI VOICE AVATAR — Coming Soon ══ -->
      <div class="bot-card coming-soon" role="article" aria-label="AI Voice Avatar — Coming Soon">
        <div class="corner-glow"></div>
        <div class="bot-icon">
          <svg viewBox="0 0 24 24">
            <rect x="9" y="2" width="6" height="11" rx="3"/>
            <path d="M5 10a7 7 0 0 0 14 0"/>
            <line x1="12" y1="17" x2="12" y2="21"/>
            <line x1="8"  y1="21" x2="16" y2="21"/>
            <circle cx="12" cy="7" r="1.2" fill="#4ade80" stroke="none"/>
          </svg>
        </div>
        <div>
          <div class="soon-badge">Upcoming MVP</div>
          <span class="bot-field">Voice AI &middot; Career Intelligence &middot; Digital Twin</span>
          <h2 class="bot-name">AI Voice Avatar</h2>
          <p class="bot-desc">A voice-first chatbot powered by a cloned voice of GACIRANE Patrick — letting visitors have a natural spoken conversation about his professional career, projects, skills, and experience. Built on voice synthesis, RAG over career data, and real-time audio streaming.</p>
          <p class="bot-scale">Scalable &rarr; AI-Powered Professional Digital Twin</p>
        </div>
        <div class="cs-footer">
          <span class="launch-label" style="opacity:.4;">Coming soon</span>
          <span class="cs-eta">&#128336;&nbsp; In Development</span>
        </div>
      </div>

      <!-- ══ REGULATORY NAVIGATOR AI — Coming Soon ══ -->
      <div class="bot-card coming-soon" role="article" aria-label="Regulatory Navigator AI — Coming Soon">
        <div class="corner-glow"></div>
        <div class="bot-icon">
          <svg viewBox="0 0 24 24">
            <rect x="2"  y="3"  width="5" height="4" rx="1"/>
            <rect x="17" y="3"  width="5" height="4" rx="1"/>
            <rect x="9"  y="17" width="6" height="4" rx="1"/>
            <line x1="4.5"  y1="7"  x2="4.5"  y2="14"/>
            <line x1="19.5" y1="7"  x2="19.5" y2="14"/>
            <line x1="4.5"  y1="14" x2="12"   y2="19"/>
            <line x1="19.5" y1="14" x2="12"   y2="19"/>
            <circle cx="4.5"  cy="14" r="1.2" fill="#4ade80" stroke="none"/>
            <circle cx="19.5" cy="14" r="1.2" fill="#4ade80" stroke="none"/>
          </svg>
        </div>
        <div>
          <div class="soon-badge">Upcoming MVP</div>
          <span class="bot-field">RegTech &middot; Compliance Intelligence &middot; Business Licensing</span>
          <h2 class="bot-name">Regulatory Navigator AI</h2>
          <p class="bot-desc">Navigate fragmented multi-regulator compliance landscapes with ease. A 6-agent CrewAI system that classifies your business activity, maps cross-regulatory obligations across multiple government institutions, sequences the correct order of approvals, and generates a structured <strong>Regulatory License Proposal</strong> — all grounded in official regulatory texts via a RAG knowledge base.</p>
          <p class="bot-scale">Scalable &rarr; National Smart Regulation (RegTech) Platform</p>
        </div>
        <div class="cs-footer">
          <span class="launch-label" style="opacity:.4;">Coming soon</span>
          <span class="cs-eta">&#128336;&nbsp; In Development</span>
        </div>
      </div>

      <!-- ══ GLOBAL FUNDING SCOUT AI — Coming Soon ══ -->
      <div class="bot-card coming-soon" role="article" aria-label="Global Funding Scout AI — Coming Soon">
        <div class="corner-glow"></div>
        <div class="bot-icon">
          <svg viewBox="0 0 24 24">
            <circle cx="11" cy="11" r="7"/>
            <line  x1="16.5" y1="16.5" x2="21" y2="21"/>
            <line  x1="8"    y1="11"   x2="14"  y2="11"/>
            <line  x1="11"   y1="8"    x2="11"  y2="14"/>
            <circle cx="11" cy="11" r="2.5" fill="#4ade80" stroke="none" opacity="0.35"/>
          </svg>
        </div>
        <div>
          <div class="soon-badge">Upcoming MVP</div>
          <span class="bot-field">FundTech &middot; Grant Intelligence &middot; International Finance</span>
          <h2 class="bot-name">Global Funding Scout AI</h2>
          <p class="bot-desc">A 4-agent CrewAI system that autonomously searches international funding databases, scrapes full eligibility criteria and deadlines, verifies geographic eligibility for your target country, and generates <strong>sector-specific outreach messaging templates</strong> — delivering a compiled funding intelligence report with an interactive dashboard covering grants, investments, and sponsorships across Education, Youth, Women Empowerment, and Climate Resilience sectors.</p>
          <p class="bot-scale">Scalable &rarr; International Development Finance Intelligence Platform</p>
        </div>
        <div class="cs-footer">
          <span class="launch-label" style="opacity:.4;">Coming soon</span>
          <span class="cs-eta">&#128336;&nbsp; In Development</span>
        </div>
      </div>

    </div><!-- /bots-grid -->

    <footer class="page-footer">
      <p>
        &copy; 2025
        <a href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer">GACIRANE Patrick</a>
        &mdash; AIonifier AI Suite &mdash; MVP Showcase Portfolio &mdash; Not for production use.
      </p>
    </footer>
  </div><!-- /page-wrap -->

  <script>
    const burger = document.getElementById("burger");
    const drawer = document.getElementById("drawer");
    burger.addEventListener("click", () => {
      const open = drawer.classList.toggle("open");
      burger.classList.toggle("open", open);
      burger.setAttribute("aria-expanded", open);
    });
    drawer.querySelectorAll("a").forEach(l => l.addEventListener("click", () => {
      drawer.classList.remove("open");
      burger.classList.remove("open");
      burger.setAttribute("aria-expanded", false);
    }));
    const navAs = document.querySelectorAll(".nav-links a");
    const obs = new IntersectionObserver(entries => {
      entries.forEach(e => {
        if (e.isIntersecting) {
          navAs.forEach(a => a.classList.remove("active"));
          const m = document.querySelector(`.nav-links a[href="#${e.target.id}"]`);
          if (m) m.classList.add("active");
        }
      });
    }, { rootMargin: "-40% 0px -55% 0px" });
    ["top","apps"].forEach(id => { const el = document.getElementById(id); if (el) obs.observe(el); });
  </script>
</body>
</html>
