<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>PagaDromeda — AI MVP Showcase</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700;800&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet" />
  <style>
    /* ── 3-colour palette ──────────────────
       #0b0f1a  dark bg / surfaces
       #4ade80  green — brand / accent
       #8892a4  muted — body / labels
    ──────────────────────────────────────── */
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

    /* ══ HERO STRIP — full width, photo + identity + title ══ */
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

    /* Photo — spans both rows on left */
    .hero-photo-wrap {
      grid-row: 1 / 3;
      grid-column: 1;
      flex-shrink: 0;
      align-self: stretch;
      display: flex; align-items: center;
    }
    .hero-photo {
      /* Natural ratio 1362:1825 ≈ 0.746 — let width drive, height auto = no distortion */
      width: clamp(80px, 9vw, 118px);
      height: auto;
      border-radius: 10px;
      display: block;
      border: 2px solid rgba(74,222,128,0.50);
      box-shadow:
        0 0 0 4px rgba(74,222,128,0.07),
        0 8px 28px rgba(0,0,0,0.55);
    }

    /* Top row: identity line (name + role) */
    .hero-identity {
      grid-row: 1; grid-column: 2;
      display: flex; align-items: baseline; gap: 16px; flex-wrap: wrap;
      padding-top: 6px;
    }
    .hero-name {
      font-size: clamp(0.85rem, 1.5vw, 1rem);
      font-weight: 700; color: var(--green);
      text-decoration: none; letter-spacing: 0.03em;
      border-bottom: 1px solid rgba(74,222,128,0.3);
      transition: color .2s; white-space: nowrap;
    }
    .hero-name:hover { color: #86efac; }
    .hero-role {
      font-family: "IBM Plex Mono", monospace;
      font-size: clamp(0.56rem, 1vw, 0.65rem);
      letter-spacing: 0.14em; text-transform: uppercase;
      color: var(--muted);
    }

    /* Bottom row: big title fills the width */
    .hero-title-wrap {
      grid-row: 2; grid-column: 2;
      padding-bottom: clamp(14px, 2vw, 22px);
    }
    .hero-title {
      font-size: clamp(1.6rem, 4.5vw, 3.2rem);
      font-weight: 800; line-height: 1.08;
      letter-spacing: -0.03em;
      color: var(--text);
      /* stretch to fill column */
      width: 100%;
      /* fluid scaling so it always fills one line on desktop */
      white-space: nowrap;
    }
    /* shrink font if it overflows on medium screens */
    @media (max-width: 900px) {
      .hero-title { font-size: clamp(1.3rem, 5vw, 2.2rem); white-space: normal; }
    }
    @media (max-width: 500px) {
      .hero-title { font-size: clamp(1.1rem, 6.5vw, 1.6rem); white-space: normal; }
    }
    .hero-title .hl {
      background: linear-gradient(110deg, var(--green) 0%, #86efac 100%);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }

    /* Mobile: stack photo above title */
    @media (max-width: 560px) {
      .hero {
        grid-template-columns: 1fr;
        grid-template-rows: auto auto auto;
      }
      .hero-photo-wrap { grid-row: 1; grid-column: 1; margin-bottom: 14px; }
      .hero-identity   { grid-row: 2; grid-column: 1; }
      .hero-title-wrap { grid-row: 3; grid-column: 1; }
    }

    /* ── Subtitle ── */
    .hero-sub {
      font-size: clamp(0.78rem, 1.4vw, 0.9rem);
      color: var(--muted); line-height: 1.7; font-weight: 300;
      width: 100%; max-width: 860px;
      padding: 14px 0 0;
    }
    .hero-sub strong { color: var(--text); font-weight: 600; }

    /* ── ONE disclaimer bar ── */
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

    /* ── Coming-soon card — spans full row ── */
    .bot-card.coming-soon {
      grid-column: 1 / -1;
      flex-direction: row;
      align-items: center;
      gap: clamp(20px, 3vw, 36px);
      cursor: default;
      border-style: dashed;
      border-color: rgba(74,222,128,0.22);
      background: rgba(19,25,41,0.6);
      opacity: 0.88;
    }
    .bot-card.coming-soon:hover {
      transform: none;
      box-shadow: none;
      border-color: rgba(74,222,128,0.35);
    }
    .bot-card.coming-soon:hover::before { opacity: 0.5; }
    .bot-card.coming-soon .bot-icon {
      width: clamp(56px,8vw,72px); height: clamp(56px,8vw,72px);
      flex-shrink: 0;
    }
    .bot-card.coming-soon .bot-icon svg {
      width: clamp(28px,4vw,36px); height: clamp(28px,4vw,36px);
    }
    .bot-card.coming-soon .cs-body { flex: 1; min-width: 0; }
    .soon-badge {
      display: inline-flex; align-items: center; gap: 6px;
      font-family: "IBM Plex Mono", monospace;
      font-size: clamp(0.54rem, 0.9vw, 0.62rem);
      letter-spacing: 0.18em; text-transform: uppercase;
      color: var(--green); opacity: .65;
      border: 1px dashed rgba(74,222,128,0.4);
      padding: 3px 10px; border-radius: 20px;
      margin-bottom: 10px; width: fit-content;
    }
    .soon-badge::before {
      content: ''; width: 6px; height: 6px; border-radius: 50%;
      background: var(--green); opacity: .7;
      animation: blink 1.8s ease-in-out infinite;
    }
    .bot-card.coming-soon .bot-name { margin-bottom: 6px; }
    .bot-card.coming-soon .bot-desc { max-width: 680px; }
    .cs-right {
      flex-shrink: 0; display: flex; flex-direction: column;
      align-items: flex-end; gap: 8px;
    }
    .cs-eta {
      font-family: "IBM Plex Mono", monospace;
      font-size: clamp(0.55rem, 0.85vw, 0.62rem);
      letter-spacing: 0.14em; text-transform: uppercase;
      color: var(--muted); opacity: .6; white-space: nowrap;
    }
    @media (max-width: 600px) {
      .bot-card.coming-soon { flex-direction: column; align-items: flex-start; }
      .cs-right { align-items: flex-start; }
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
      <a class="nav-brand" href="#top"><span class="nav-dot"></span>PagaDromeda</a>
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

      <!-- Photo (spans both rows) -->
      <div class="hero-photo-wrap">
        <img class="hero-photo"
             src="data:image/jpeg;base64,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"
             alt="GACIRANE Patrick — AI Solutions Architect" />
      </div>

      <!-- Row 1: Name + Role -->
      <div class="hero-identity">
        <a class="hero-name"
           href="https://www.linkedin.com/in/patricus/"
           target="_blank" rel="noopener noreferrer">GACIRANE Patrick</a>
        <span class="hero-role">AI Solutions Architect</span>
      </div>

      <!-- Row 2: Title (fills remaining width) -->
      <div class="hero-title-wrap">
        <h1 class="hero-title">
          <span class="hl">PagaDromeda</span> &mdash; AI&nbsp;MVP&nbsp;Portfolio
        </h1>
      </div>

    </section>

    <!-- Subtitle (full width below hero) -->
    <p class="hero-sub">
      Six applied AI systems spanning <strong>Healthcare, Legal, Banking, Education, Talent,</strong> and <strong>Infrastructure</strong> —
      each a <strong>Minimum Viable Product</strong> built and designed to scale into enterprise-grade products.
    </p>

    <!-- ONE disclaimer -->
    <div class="disclaimer" role="note">
      <span class="disclaimer-icon">&#9888;</span>
      <p>
        <strong>Showcase &amp; Demo Platform Only.</strong>
        PagaDromeda is a personal AI portfolio by GACIRANE Patrick.
        All applications are <strong>Minimum Viable Products (MVPs)</strong> built to demonstrate agentic AI engineering across real-world domains.
        They are <strong>not intended for production use</strong> in clinical, legal, financial, or any critical decision-making context.
        You can hire Me to design and build similar agentic systems or investors or partners interested in scaling any MVP into a full product are welcome to
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
          <p class="bot-desc">Agentic university scouting, financial roadmapping, visaa navigation and cultural landing — built for any students pursuing global education.</p>
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

        <!-- Microphone / voice icon -->
        <div class="bot-icon">
          <svg viewBox="0 0 24 24">
            <rect x="9" y="2" width="6" height="11" rx="3"/>
            <path d="M5 10a7 7 0 0 0 14 0"/>
            <line x1="12" y1="17" x2="12" y2="21"/>
            <line x1="8"  y1="21" x2="16" y2="21"/>
            <circle cx="12" cy="7" r="1.2" fill="#4ade80" stroke="none"/>
          </svg>
        </div>

        <!-- Body -->
        <div class="cs-body">
          <div class="soon-badge">Upcoming MVP</div>
          <span class="bot-field">Voice AI &middot; Career Intelligence &middot; Digital Twin</span>
          <h2 class="bot-name">AI Voice Avatar</h2>
          <p class="bot-desc">
            A voice-first chatbot powered by a cloned voice of GACIRANE Patrick — letting visitors
            have a natural spoken conversation about his professional career, projects, skills, and
            experience. Built on voice synthesis, RAG over career data, and real-time audio streaming.
          </p>
          <p class="bot-scale">Scalable &rarr; AI-Powered Professional Digital Twin</p>
        </div>

        <!-- Right side -->
        <div class="cs-right">
          <span class="cs-eta">&#128336;&nbsp; In Development</span>
          <span class="launch-label" style="opacity:.4;">Coming soon</span>
        </div>
      </div>

    </div><!-- /bots-grid -->

    <footer class="page-footer">
      <p>
        &copy; 2025
        <a href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer">GACIRANE Patrick</a>
        &mdash; PagaDromeda AI Suite &mdash; MVP Showcase Portfolio &mdash; Not for production use.
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