<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>AIonifier.ai — AI MVP Portfolio</title>
  <meta property="og:type"        content="website" />
  <meta property="og:site_name"   content="AIonifier.ai" />
  <meta property="og:title"       content="AIonifier.ai — AI MVP Portfolio" />
  <meta property="og:description" content="13 live AI agentic applications spanning legal, clinical, banking,environment, education, and HR— built end-to-end by GACIRANE Patrick." />
  <meta property="og:image"       content="<%= request.getContextPath() %>/images/aionifier-og.png" />
  <meta property="og:image:width"  content="1200" />
  <meta property="og:image:height" content="630" />
  <meta property="og:url"         content="https://aionifier.ai" />
  <meta name="twitter:card"        content="summary_large_image" />
  <meta name="twitter:title"       content="AIonifier.ai — AI MVP Portfolio" />
  <meta name="twitter:description" content="13 live AI agentic applications spanning legal, clinical, banking,environment,environment, education, and HR — built end-to-end by GACIRANE Patrick." />
  <meta name="twitter:image"       content="<%= request.getContextPath() %>/images/aionifier-og.png" />
  <meta name="description" content="AIonifier.ai — 13 live AI agentic applications spanning legal, clinical, banking, education, and HR — built end-to-end by GACIRANE Patrick." />
  <meta name="author"      content="GACIRANE Patrick" />
  <meta name="robots"      content="index, follow" />
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
    body { background: var(--bg); color: var(--text); font-family: "Sora", sans-serif; -webkit-font-smoothing: antialiased; }
    body::before {
      content: ""; position: fixed; inset: 0; z-index: 0; pointer-events: none;
      background: radial-gradient(ellipse 80% 55% at 10% 0%, rgba(74,222,128,0.07) 0%, transparent 60%);
    }
    /* NAV */
    .site-nav {
      position: fixed; top: 0; left: 0; right: 0; z-index: 100;
      height: var(--nav-h); background: rgba(11,15,26,0.94); backdrop-filter: blur(14px);
      border-bottom: 1px solid var(--border); display: flex; align-items: center;
      padding: 0 clamp(16px,4vw,48px);
    }
    .nav-inner { width: 100%; max-width: 1200px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between; gap: 0; }
    .nav-brand {
      font-family: "IBM Plex Mono", monospace; font-size: 0.7rem; letter-spacing: 0.22em; text-transform: uppercase;
      color: var(--green); text-decoration: none; display: flex; align-items: center; gap: 7px; flex-shrink: 0;
    }
    @keyframes blink { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.3;transform:scale(.65)} }
    .nav-links { display: flex; align-items: center; gap: 2px; list-style: none; }
    .nav-links a {
      font-family: "IBM Plex Mono", monospace; font-size: 0.62rem; letter-spacing: 0.12em; text-transform: uppercase;
      color: var(--muted); text-decoration: none; padding: 5px 11px; border-radius: 5px;
      transition: color .2s, background .2s; white-space: nowrap;
    }
    .nav-links a:hover, .nav-links a.active { color: var(--green); background: rgba(74,222,128,0.08); }
    .nav-pip { width: 3px; height: 3px; border-radius: 50%; background: rgba(255,255,255,0.12); margin: 0 2px; }
    .nav-ctas { display: flex; align-items: center; gap: 8px; flex-shrink: 0; }
    .nav-cta {
      font-family: "IBM Plex Mono", monospace; font-size: 0.62rem; letter-spacing: 0.12em; text-transform: uppercase;
      color: var(--green); text-decoration: none; border: 1px solid rgba(74,222,128,0.35);
      padding: 4px 12px; border-radius: 5px; display: flex; align-items: center; gap: 6px;
      transition: background .2s, border-color .2s; white-space: nowrap;
    }
    .nav-cta:hover { background: rgba(74,222,128,0.10); border-color: rgba(74,222,128,0.6); }
    .nav-cta svg { width: 13px; height: 13px; stroke: var(--green); fill: none; stroke-width: 2; stroke-linecap: round; stroke-linejoin: round; flex-shrink: 0; }
    .nav-burger { display: none; flex-direction: column; justify-content: center; gap: 5px; width: 32px; height: 32px; cursor: pointer; background: none; border: none; padding: 4px; }
    .nav-burger span { display: block; height: 1.5px; border-radius: 2px; background: var(--muted); transition: transform .3s, opacity .3s; }
    .nav-burger span:nth-child(2) { width: 70%; }
    .nav-burger.open span:nth-child(1) { transform: translateY(6.5px) rotate(45deg); }
    .nav-burger.open span:nth-child(2) { opacity: 0; }
    .nav-burger.open span:nth-child(3) { transform: translateY(-6.5px) rotate(-45deg); }
    .nav-drawer {
      display: none; position: fixed; top: var(--nav-h); left: 0; right: 0; z-index: 99;
      background: rgba(13,17,30,0.98); backdrop-filter: blur(16px);
      border-bottom: 1px solid var(--border); padding: 14px clamp(16px,5vw,48px) 18px;
      flex-direction: column; gap: 3px;
    }
    .nav-drawer.open { display: flex; }
    .nav-drawer a {
      font-family: "IBM Plex Mono", monospace; font-size: 0.68rem; letter-spacing: 0.14em; text-transform: uppercase;
      color: var(--muted); text-decoration: none; padding: 9px 11px; border-radius: 5px; transition: color .2s, background .2s;
    }
    .nav-drawer a:hover { color: var(--green); background: rgba(74,222,128,0.08); }
    .drawer-sep { height: 1px; background: rgba(255,255,255,0.05); margin: 5px 0; }
    .drawer-cta { color: var(--green) !important; border: 1px solid rgba(74,222,128,0.28); text-align: center; margin-top: 2px; }
    @media (max-width: 760px) { .nav-links, .nav-ctas { display: none; } .nav-burger { display: flex; } }
    /* PAGE */
    .page-wrap {
      position: relative; z-index: 1; padding-top: var(--nav-h); padding-bottom: 72px;
      max-width: 1200px; margin: 0 auto;
      padding-left: clamp(16px, 4vw, 48px); padding-right: clamp(16px, 4vw, 48px);
    }
    /* HERO */
    .hero {
      display: grid; grid-template-columns: auto 1fr; grid-template-rows: auto auto;
      column-gap: clamp(20px, 3vw, 36px); align-items: center; width: 100%;
      padding: clamp(20px, 3vw, 32px) 0 0; border-bottom: 1px solid rgba(74,222,128,0.1); margin-bottom: 0;
    }
    .hero-photo-wrap { grid-row: 1 / 3; grid-column: 1; flex-shrink: 0; align-self: stretch; display: flex; align-items: center; }
    .hero-photo {
      width: clamp(68px, 9vw, 118px); height: auto; border-radius: 10px; display: block;
      border: 2px solid rgba(74,222,128,0.50); box-shadow: 0 0 0 4px rgba(74,222,128,0.07), 0 8px 28px rgba(0,0,0,0.55);
    }
    .hero-identity { grid-row: 1; grid-column: 2; display: flex; align-items: baseline; gap: clamp(6px,1.5vw,16px); flex-wrap: wrap; padding-top: 6px; }
    .hero-name {
      font-size: clamp(0.78rem, 1.5vw, 1rem); font-weight: 700; color: var(--green);
      text-decoration: none; letter-spacing: 0.03em; border-bottom: 1px solid rgba(74,222,128,0.3);
      transition: color .2s; white-space: nowrap;
    }
    .hero-name:hover { color: #86efac; }
    .hero-role { font-family: "IBM Plex Mono", monospace; font-size: clamp(0.50rem, 1vw, 0.65rem); letter-spacing: 0.14em; text-transform: uppercase; color: var(--muted); }
    .hero-title-wrap { grid-row: 2; grid-column: 2; padding-bottom: clamp(14px, 2vw, 22px); }
    .hero-title { font-size: clamp(1.3rem, 4.5vw, 3.2rem); font-weight: 800; line-height: 1.08; letter-spacing: -0.03em; color: var(--text); width: 100%; white-space: normal; }
    .hero-title .hl { background: linear-gradient(110deg, var(--green) 0%, #86efac 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
    @media (max-width: 560px) { .hero { column-gap: clamp(10px, 3vw, 16px); } .hero-photo { width: clamp(58px, 18vw, 82px); } .hero-title { font-size: clamp(1.05rem, 6vw, 1.5rem); } }
    /* INFO STRIP */
    .info-strip { display: grid; grid-template-columns: 1.4fr 1.4fr 0.7fr 1.5fr; gap: 10px; width: 100%; margin: 18px 0 0; }
    @media (max-width: 860px) { .info-strip { grid-template-columns: 1fr 1fr; } }
    .icard {
      background: rgba(19,25,41,0.85); border: 1px solid rgba(74,222,128,0.15);
      border-radius: 11px; padding: 14px 15px 13px; display: flex; flex-direction: column; gap: 8px;
      position: relative; overflow: hidden; min-width: 0;
    }
    .icard::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 2px; background: linear-gradient(90deg, rgba(74,222,128,0.55), rgba(74,222,128,0.12)); }
    .icard.engage-card { border-color: rgba(74,222,128,0.25); }
    .icard.engage-card::before { background: linear-gradient(90deg, rgba(74,222,128,0.55), rgba(74,222,128,0.12)); }
    .icard-label { font-family: "IBM Plex Mono", monospace; font-size: 0.50rem; letter-spacing: .20em; text-transform: uppercase; color: rgba(74,222,128,0.65); }
    .icard.engage-card .icard-label { color: rgba(74,222,128,0.65); }
    .icard-body { flex: 1; min-width: 0; }
    .icard-body p { font-size: 0.68rem; color: var(--muted); line-height: 1.65; margin: 0; overflow-wrap: anywhere; word-break: break-word; }
    .icard-body p strong { color: #c8d4e8; font-weight: 600; }
    .icard-body a { color: var(--green); text-decoration: none; border-bottom: 1px solid rgba(74,222,128,0.30); }
    .icard-body a:hover { color: #86efac; }
    .icard.engage-card .icard-body a { color: var(--green); border-bottom-color: rgba(74,222,128,0.30); }
    .icard.engage-card .icard-body a:hover { color: #86efac; }
    .icard.stat-card { align-items: center; text-align: center; justify-content: center; }
    .stat-num { font-size: 2rem; font-weight: 800; color: var(--green); line-height: 1; letter-spacing: -0.03em; }
    .stat-sub { font-family: "IBM Plex Mono", monospace; font-size: 0.56rem; letter-spacing: .12em; text-transform: uppercase; color: var(--muted); margin-top: 5px; }
    .pill-row { display: flex; flex-wrap: wrap; gap: 4px; margin-top: 4px; }
    .pill { font-family: "IBM Plex Mono", monospace; font-size: 0.47rem; letter-spacing: .10em; text-transform: uppercase; color: rgba(74,222,128,0.72); border: 1px solid rgba(74,222,128,0.22); background: rgba(74,222,128,0.05); padding: 2px 7px; border-radius: 20px; }
    /* DIVIDER */
    .divider { display: flex; align-items: center; gap: 14px; margin: 28px 0 22px; }
    .divider span { font-family: "IBM Plex Mono", monospace; font-size: 0.57rem; letter-spacing: 0.2em; text-transform: uppercase; color: var(--muted); white-space: nowrap; }
    .dl  { flex: 1; height: 1px; background: linear-gradient(to right,  rgba(255,255,255,0.07), transparent); }
    .dlr { flex: 1; height: 1px; background: linear-gradient(to left,   rgba(255,255,255,0.07), transparent); }
    /* ============ RADIAL WHEEL ============ */
    .wheel-section { display: grid; grid-template-columns: minmax(0, 1.6fr) minmax(0, 1fr); gap: clamp(14px, 3vw, 34px); align-items: start; }
    @media (max-width: 900px) { .wheel-section { grid-template-columns: 1fr; } }
    .wheel-stage { position: relative; width: 100%; max-width: 960px; margin: 0 auto; }
    .wheel-stage svg { width: 100%; height: auto; display: block; }
    .wheel-hint { text-align: center; font-family: "IBM Plex Mono", monospace; font-size: 0.55rem; letter-spacing: 0.18em; text-transform: uppercase; color: var(--muted); opacity: .65; margin-top: 8px; }
    /* wedges */
    .wedge { fill: rgba(19,25,41,0.92); stroke: rgba(74,222,128,0.22); stroke-width: 1; cursor: pointer; transition: fill .25s; outline: none; }
    .wedge:hover, .wedge:focus-visible { fill: rgba(74,222,128,0.12); }
    .wedge:focus-visible { stroke: var(--green); stroke-width: 1.6; }
    .wedge.selected { fill: rgba(74,222,128,0.18); stroke: var(--green); stroke-width: 1.6; }
    .wedge.soon { fill: rgba(13,17,28,0.75); stroke-dasharray: 5 4; }
    .wedge-label { font-family: "IBM Plex Mono", monospace; font-size: 13.5px; letter-spacing: 0.06em; text-transform: uppercase; fill: #c8d4e8; pointer-events: none; }
    .wedge-label .sub { font-size: 9.5px; fill: rgba(74,222,128,0.75); letter-spacing: 0.14em; }
    .wedge-label .sub-soon { font-size: 10px; fill: var(--green); letter-spacing: 0.14em; }
    .subgroup-arc-label { font-family: "IBM Plex Mono", monospace; font-size: 10.5px; letter-spacing: 0.20em; text-transform: uppercase; fill: rgba(74,222,128,0.8); }
    .subgroup-arc-line { fill: none; stroke: rgba(74,222,128,0.45); stroke-width: 1.2; stroke-dasharray: 4 4; }
    /* hub */
    .hub-circle { fill: rgba(11,15,26,0.95); stroke: rgba(74,222,128,0.55); stroke-width: 1.6; cursor: pointer; transition: fill .25s, stroke .25s; outline: none; }
    .hub-group:hover .hub-circle, .hub-circle:focus-visible { fill: rgba(74,222,128,0.12); stroke: var(--green); }
    .hub-group.selected .hub-circle { fill: rgba(74,222,128,0.18); stroke: var(--green); }
    .hub-text { font-family: "IBM Plex Mono", monospace; font-size: 13px; letter-spacing: 0.2em; text-transform: uppercase; fill: var(--green); pointer-events: none; }
    .hub-sub { font-family: "IBM Plex Mono", monospace; font-size: 8.5px; letter-spacing: 0.16em; text-transform: uppercase; fill: var(--muted); pointer-events: none; }
    /* section arcs */
    .section-ring { fill: none; stroke: rgba(74,222,128,0.16); stroke-width: 1; }
    .section-arc-label { font-family: "IBM Plex Mono", monospace; font-size: 12px; letter-spacing: 0.24em; text-transform: uppercase; fill: var(--green); opacity: .85; }
    .section-divider-line { stroke: rgba(74,222,128,0.45); stroke-width: 1.4; }
    /* DETAIL PANEL */
    .wheel-detail {
      position: sticky; top: calc(var(--nav-h) + 16px);
      background: var(--surface); border: 1px solid rgba(74,222,128,0.25); border-radius: 16px;
      padding: clamp(18px,2.5vw,26px) clamp(16px,2vw,24px); overflow: hidden; min-height: 300px;
      display: flex; flex-direction: column; gap: 12px;
    }
    .wheel-detail::before { content: ""; position: absolute; inset: 0; border-radius: 16px; background: radial-gradient(ellipse at top left, rgba(74,222,128,0.09) 0%, transparent 65%); pointer-events: none; }
    @media (max-width: 900px) { .wheel-detail { position: static; } }
    .d-head { display: flex; align-items: center; justify-content: space-between; gap: 10px; }
    .d-tag { font-family: "IBM Plex Mono", monospace; font-size: 0.48rem; letter-spacing: 0.18em; text-transform: uppercase; padding: 3px 8px; border-radius: 4px; background: rgba(74,222,128,0.07); border: 1px solid rgba(74,222,128,0.16); color: rgba(74,222,128,0.7); white-space: nowrap; }
    .d-section { font-family: "IBM Plex Mono", monospace; font-size: 0.50rem; letter-spacing: 0.16em; text-transform: uppercase; color: var(--muted); opacity: .7; }
    .bot-field { font-family: "IBM Plex Mono", monospace; font-size: clamp(0.52rem, 0.85vw, 0.60rem); letter-spacing: 0.17em; text-transform: uppercase; color: var(--green); opacity: .72; margin-bottom: 3px; display: block; }
    .bot-name { font-size: clamp(0.98rem, 1.7vw, 1.18rem); font-weight: 700; color: var(--text); margin: 0 0 7px; line-height: 1.22; }
    .bot-desc { font-size: clamp(0.70rem, 1.1vw, 0.78rem); color: var(--muted); line-height: 1.7; margin: 0; font-weight: 300; }
    .bot-desc strong { color: #c8d4e8; }
    .bot-scale { font-family: "IBM Plex Mono", monospace; font-size: 0.52rem; letter-spacing: 0.11em; text-transform: uppercase; color: var(--green); opacity: .55; margin-top: 10px; display: flex; align-items: center; gap: 4px; }
    .bot-scale::before { content: ""; display: inline-block; width: 4px; height: 4px; border-radius: 50%; background: var(--green); flex-shrink: 0; }
    .d-footer { margin-top: auto; padding-top: 14px; border-top: 1px solid rgba(255,255,255,0.05); display: flex; align-items: center; justify-content: space-between; gap: 10px; }
    .d-launch {
      font-family: "IBM Plex Mono", monospace; font-size: 0.62rem; letter-spacing: 0.12em; text-transform: uppercase;
      color: var(--bg); background: var(--green); text-decoration: none; padding: 8px 18px; border-radius: 7px;
      display: inline-flex; align-items: center; gap: 8px; transition: background .2s, transform .2s; font-weight: 500;
    }
    .d-launch:hover { background: #86efac; transform: translateX(2px); }
    .d-launch svg { width: 12px; height: 12px; stroke: var(--bg); fill: none; stroke-width: 2.2; stroke-linecap: round; stroke-linejoin: round; }
    .soon-badge { display: inline-flex; align-items: center; gap: 6px; font-family: "IBM Plex Mono", monospace; font-size: clamp(0.54rem, 0.9vw, 0.62rem); letter-spacing: 0.18em; text-transform: uppercase; color: var(--green); border: 1px dashed rgba(74,222,128,0.45); background: rgba(74,222,128,0.06); padding: 3px 10px; border-radius: 20px; width: fit-content; }
    .soon-badge::before { content: ''; width: 6px; height: 6px; border-radius: 50%; background: var(--green); opacity: .75; animation: blink 1.8s ease-in-out infinite; }
    .cs-eta { font-family: "IBM Plex Mono", monospace; font-size: clamp(0.52rem, 0.85vw, 0.60rem); letter-spacing: 0.12em; text-transform: uppercase; color: var(--muted); opacity: .6; white-space: nowrap; }
    @media (prefers-reduced-motion: reduce) {
      html { scroll-behavior: auto; }
      .wedge, .hub-circle, .d-launch { transition: none; }
      .soon-badge::before { animation: none; }
    }
    /* FOOTER */
    .page-footer { text-align: center; margin-top: clamp(36px,5vw,56px); padding-top: 20px; border-top: 1px solid var(--border); }
    .page-footer p { font-family: "IBM Plex Mono", monospace; font-size: 0.58rem; letter-spacing: 0.14em; text-transform: uppercase; color: var(--muted); }
    .page-footer a { color: var(--green); text-decoration: none; border-bottom: 1px solid rgba(74,222,128,0.26); }
    .page-footer a:hover { color: #86efac; }
  </style>
</head>
<body>

  <nav class="site-nav" role="navigation" aria-label="Main navigation">
    <div class="nav-inner">
      <a class="nav-brand" href="#top">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" width="22" height="22" fill="none" aria-hidden="true" style="flex-shrink:0;display:block;">
          <ellipse cx="16" cy="16" rx="13" ry="5.5" stroke="rgba(74,222,128,0.22)" stroke-width="1" transform="rotate(-30 16 16)"/>
          <line x1="16" y1="16" x2="8"  y2="9"  stroke="rgba(74,222,128,0.35)" stroke-width="0.9"/>
          <line x1="16" y1="16" x2="24" y2="9"  stroke="rgba(74,222,128,0.35)" stroke-width="0.9"/>
          <line x1="16" y1="16" x2="26" y2="19" stroke="rgba(74,222,128,0.35)" stroke-width="0.9"/>
          <line x1="16" y1="16" x2="10" y2="24" stroke="rgba(74,222,128,0.35)" stroke-width="0.9"/>
          <line x1="16" y1="16" x2="22" y2="25" stroke="rgba(74,222,128,0.35)" stroke-width="0.9"/>
          <line x1="8"  y1="9"  x2="24" y2="9"  stroke="rgba(74,222,128,0.18)" stroke-width="0.7"/>
          <line x1="10" y1="24" x2="22" y2="25" stroke="rgba(74,222,128,0.18)" stroke-width="0.7"/>
          <line x1="24" y1="9"  x2="26" y2="19" stroke="rgba(74,222,128,0.18)" stroke-width="0.7"/>
          <circle cx="16" cy="16" r="5" fill="#4ade80"/>
          <circle cx="8"  cy="9"  r="2.2" fill="#86efac" opacity="0.9"/>
          <circle cx="24" cy="9"  r="1.8" fill="#86efac" opacity="0.8"/>
          <circle cx="26" cy="19" r="2"   fill="#86efac" opacity="0.85"/>
          <circle cx="10" cy="24" r="1.8" fill="#86efac" opacity="0.8"/>
          <circle cx="22" cy="25" r="2.2" fill="#86efac" opacity="0.9"/>
          <circle cx="16" cy="16" r="1.5" fill="#d1fae5" opacity="0.75"/>
        </svg>
        AIonifier
      </a>
      <ul class="nav-links" role="list">
        <li><a href="#top">Home</a></li>
        <li><span class="nav-pip"></span></li>
        <li><a href="#apps"><abbr title="Artificial Intelligence">AI</abbr> <abbr title="Minimum Viable Product">MVP</abbr>s</a></li>
        <li><span class="nav-pip"></span></li>
        <li><a href="#impact">Social Impact &amp; Ethics</a></li>
        <li><span class="nav-pip"></span></li>
        <li><a href="<%= ctx %>/BotViewer?bot=arch">Architecture</a></li>
        <li><span class="nav-pip"></span></li>
        <li><a href="#etymology">Etymology</a></li>
      </ul>
      <div class="nav-ctas">
        <a class="nav-cta" href="<%= ctx %>/BotViewer?bot=hire">
          <svg viewBox="0 0 24 24"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/><line x1="12" y1="12" x2="12" y2="16"/><line x1="10" y1="14" x2="14" y2="14"/></svg>
          Hire me
        </a>
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
    <a href="#apps" role="menuitem"><abbr title="Artificial Intelligence">AI</abbr> <abbr title="Minimum Viable Product">MVP</abbr>s</a>
    <a href="#impact" role="menuitem">Social Impact &amp; Ethics</a>
    <div class="drawer-sep"></div>
    <a href="<%= ctx %>/BotViewer?bot=arch" role="menuitem">Architecture</a>
    <a href="#etymology" role="menuitem">Etymology</a>
    <div class="drawer-sep"></div>
    <a href="<%= ctx %>/BotViewer?bot=hire" role="menuitem" class="drawer-cta">&#128188; Hire me</a>
    <a href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer" class="drawer-cta" style="margin-top:6px;">&#128100; LinkedIn</a>
    <a href="https://github.com/pgacirane" target="_blank" rel="noopener noreferrer" class="drawer-cta" style="margin-top:6px;">&#128187; GitHub</a>
  </div>

  <div id="top" class="page-wrap">

    <section class="hero">
      <div class="hero-photo-wrap">
        <img class="hero-photo" src="<%= ctx %>/images/20250424_170544.png" alt="GACIRANE Patrick — AI Solution builder" />
      </div>
      <div class="hero-identity">
        <a class="hero-name" href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer">GACIRANE Patrick</a>
        <span class="hero-role">AI Solutions Builder</span>
      </div>
      <div class="hero-title-wrap">
        <h1 class="hero-title"><span class="hl">AIonifier</span> &mdash; AI&nbsp;MVP&nbsp;Portfolio</h1>
      </div>
    </section>

    <div class="info-strip" role="region" aria-label="Platform overview">
      <div class="icard">
        <div class="icard-label">Platform</div>
        <div class="icard-body">
          <p><strong>AIonifier</strong> &mdash; AI (Artificial Intelligence) MVP (Minimum Viable Product) Portfolio &mdash; is a personal AI MVP portfolio by GACIRANE Patrick &mdash; 13 live agentic applications and 3 in development, each built end-to-end to demonstrate production-grade AI engineering across real-world domains.</p>
        </div>
      </div>
      <div class="icard engage-card">
        <div class="icard-label">Engage &amp; Scale</div>
        <div class="icard-body">
          <p>Each app is an <strong>engineering MVP</strong> — validated on real domain documentation and architecturally ready to scale with a production team. <strong>Open to consulting, full-time roles</strong>, and <strong>investors or partners</strong> interested in taking any MVP to national scale. <a href="<%= ctx %>/BotViewer?bot=hire">View hire page &rarr;</a></p>
        </div>
      </div>
      <div class="icard stat-card">
        <div class="icard-label">AI Apps</div>
        <div class="stat-num">13+</div>
        <div class="stat-sub">13 Live &middot; 3 In Dev</div>
      </div>
      <div class="icard">
        <div class="icard-label">Technology Stack</div>
        <div class="icard-body">
          <div class="pill-row">
            <span class="pill">CrewAI Agents</span>
            <span class="pill">A2A Protocol</span>
            <span class="pill">BeeAI Framework</span>
            <span class="pill">RAG Pipelines</span>
            <span class="pill">MCP Servers</span>
            <span class="pill">Hybrid Search</span>
            <span class="pill">Semantic Search</span>
            <span class="pill">Keyword Search</span>
            <span class="pill">ChromaDB / FAISS</span>
            <span class="pill">Deep Learning</span>
            <span class="pill">Python</span>
            <span class="pill">Java EE / JSP</span>
            <span class="pill">FastAPI</span>
            <span class="pill">Heroku</span>
            <span class="pill">PostgreSQL</span>
            <span class="pill">Git</span>
            <span class="pill">SSE Streaming</span>
          </div>
        </div>
      </div>
    </div>

    <div class="divider" id="apps">
      <span id="impact" style="position:absolute;"></span>
      <span id="etymology" style="position:absolute;"></span>
      <div class="dl"></div><span>The AIonifier Wheel &mdash; Select a Specialist</span><div class="dlr"></div>
    </div>

    <section class="wheel-section" aria-label="AIonifier application wheel">
      <div class="wheel-stage">
        <svg id="wheel" viewBox="0 0 760 760" role="group" aria-label="Radial menu of AIonifier applications"></svg>
        <p class="wheel-hint">Tap a segment for details &middot; Centre hub &rarr; Platform Architecture</p>
      </div>
      <aside class="wheel-detail" id="detailPanel" aria-live="polite">
        <!-- filled by JS -->
      </aside>
    </section>

    <footer class="page-footer">
      <p>&copy; 2026 <a href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer">GACIRANE Patrick</a> &mdash; AIonifier AI Suite</p>
    </footer>
  </div>

  <script>
    var CTX = "<%= ctx %>";

    /* ---------- burger nav (unchanged behaviour) ---------- */
    var burger = document.getElementById("burger");
    var drawer = document.getElementById("drawer");
    burger.addEventListener("click", function () {
      var open = drawer.classList.toggle("open");
      burger.classList.toggle("open", open);
      burger.setAttribute("aria-expanded", open);
    });
    drawer.querySelectorAll("a").forEach(function (l) {
      l.addEventListener("click", function () {
        drawer.classList.remove("open");
        burger.classList.remove("open");
        burger.setAttribute("aria-expanded", false);
      });
    });

    /* ---------- data: all original descriptions preserved verbatim ---------- */
    var SECTIONS = {
      apps:      "AI MVP Applications \u2014 Select a Specialist",
      impact:    "Social Impact Assessments \u2014 AIonifier AI Ethics",
      etymology: "AIonifier Etymology \u2014 Origin of the Word"
    };

    /* shorter fallbacks, used only when a section's arc is too narrow for the full title */
    var SECTIONS_SHORT = {
      apps:      "AI MVP Applications",
      impact:    "Social Impact \u0026 Ethics",
      etymology: "Etymology"
    };

    var ITEMS = [
      { id: "coreg", section: "apps", tag: "MVP", href: CTX + "/BotViewer?bot=corego",
        label: ["Regulatory", "Navigator AI"],
        field: "RegTech \u00B7 Cross-Regulatory Intelligence \u00B7 Compliance Advisory",
        name: "Regulatory Navigator AI",
        desc: "Simplify multi-regulator compliance using a coordinated network of AI specialists",
        scale: "Scalable \u2192 National Smart Regulation (RegTech) Platform",
        launch: "Test Navigator upon request" },
      { id: "legal", section: "apps", tag: "MVP", href: CTX + "/BotViewer?bot=legal",
        label: ["Global Legal", "Advisor"],
        field: "Legal Tech \u00B7 Compliance Automation",
        name: "Global Legal Advisor",
        desc: "Navigate international regulations, draft legal briefs, and get jurisdiction-aware guidance across 180+ countries via multi-agent legal reasoning.",
        scale: "Scalable \u2192 Enterprise Legal Intelligence Platform",
        launch: "Launch advisor" },
      { id: "bank", section: "apps", tag: "MVP", href: CTX + "/BotViewer?bot=bank",
        label: ["Bank CRM", "Advisor"],
        field: "Banking \u00B7 CRM \u00B7 Financial Services",
        name: "Bank CRM Advisor",
        desc: "Deepen client relationships, automate follow-ups, and surface actionable insights from banking CRM data \u2014 powered by a 9-agent CrewAI system.",
        scale: "Scalable \u2192 Retail Banking Intelligence Suite",
        launch: "Launch advisor" },
      { id: "hiv", section: "apps", tag: "MVP", href: CTX + "/BotViewer?bot=hiv",
        label: ["HIV Guidelines", "Assistant"],
        field: "Healthcare \u00B7 Clinical Guidelines \u00B7 HIV/AIDS",
        name: "HIV Guidelines Assistant",
        desc: "Retrieve verified ART regimens, PMTCT protocols, and paediatric dosing from Rwanda HIV Guidelines 2022 via RAG over RBC clinical documentation.",
        scale: "Scalable \u2192 National Clinical Decision Support System",
        launch: "Launch advisor" },
      { id: "grad", section: "apps", tag: "MVP", href: CTX + "/BotViewer?bot=grad",
        label: ["Smart Grad"],
        field: "EdTech \u00B7 Career Advisory \u00B7 Education",
        name: "Smart Grad",
        desc: "Agentic university scouting, financial roadmapping, visa navigation and cultural landing \u2014 built for any students pursuing global education.",
        scale: "Scalable \u2192 Global Student Advisory Platform",
        launch: "Launch advisor" },
      { id: "cv", section: "apps", tag: "MVP", href: CTX + "/BotViewer?bot=cv",
        label: ["Talk to", "My CV"],
        field: "HRTech \u00B7 Talent Intelligence \u00B7 Recruitment",
        name: "Talk to My CV",
        desc: "Chat directly with Patrick's CV \u2014 skills, projects, and experience all conversationally accessible via RAG-powered talent profiling.",
        scale: "Scalable \u2192 AI-Powered Recruitment Screening Tool",
        launch: "Start a conversation" },
      { id: "voice", section: "apps", tag: "UPCOMING", soon: true,
        label: ["AI Voice", "Avatar"],
        field: "Voice AI \u00B7 Career Intelligence \u00B7 Digital Twin",
        name: "AI Voice Avatar",
        desc: "A voice-first chatbot powered by a cloned voice of GACIRANE Patrick \u2014 letting visitors have a natural spoken conversation about his professional career, projects, skills, and experience. Built on voice synthesis, RAG over career data, and real-time audio streaming.",
        scale: "Scalable \u2192 AI-Powered Professional Digital Twin" },
      { id: "funding", section: "apps", tag: "UPCOMING", soon: true,
        label: ["Global Funding", "Scout AI"],
        field: "FundTech \u00B7 Grant Intelligence \u00B7 International Finance",
        name: "Global Funding Scout AI",
        desc: "A 4-agent CrewAI system that autonomously searches international funding databases, scrapes full eligibility criteria and deadlines, verifies geographic eligibility for your target country, and generates <strong>sector-specific outreach messaging templates</strong> \u2014 delivering a compiled funding intelligence report with an interactive dashboard covering grants, investments, and sponsorships across Education, Youth, Women Empowerment, and Climate Resilience sectors.",
        scale: "Scalable \u2192 International Development Finance Intelligence Platform" },
      { id: "climate", section: "apps", tag: "UPCOMING", soon: true,
        label: ["Climate Resilience", "Advisor AI"],
        field: "ClimateTech \u00B7 Multi-Agent A2A \u00B7 Climate Science",
        name: "Climate Resilience Advisor AI",
        desc: "An <strong>A2A (Agent-to-Agent) protocol</strong> system where an orchestrator agent routes climate questions to three autonomous specialist agents \u2014 <strong>Agriculture &amp; Food Systems</strong>, <strong>Earth &amp; Atmospheric Sciences</strong>, and <strong>Ecology &amp; Biology</strong> \u2014 each an independent CrewAI crew with real-time web search, discoverable via published agent cards. Answers questions like drought-resilient crops for East Africa, heat impact on coffee, and flooding effects on rice production.",
        scale: "Scalable \u2192 National Climate Adaptation Intelligence Platform" },
      { id: "sia", section: "impact", tag: "REPORT", href: CTX + "/BotViewer?bot=sia",
        label: ["Social Impact", "Assessment"],
        field: "AI Ethics \u00B7 Responsible AI \u00B7 Policy",
        name: "Social Impact Assessment",
        desc: "A structured Social Impact Matrix evaluation of two AIonifier MVPs \u2014 <strong style=\"color:#c8d4e8;\">SmartAttorney AI</strong> and the <strong style=\"color:#c8d4e8;\">Rwanda HIV Guidelines Assistant</strong>. Each is assessed across Individual, Collective, and Societal dimensions for both <em>harms</em> and <em>benefits</em> \u2014 following the Social Impact Matrix methodology adopted across East Africa. Essential reading for investors, regulators, and implementation partners.",
        scale: "Framework \u2192 Social Impact Matrix (Assessing Harms &amp; Amplifying Benefits)",
        launch: "View full assessment" },
      { id: "ethics", section: "impact", tag: "ETHICS", href: CTX + "/BotViewer?bot=ethics",
        label: ["AIonifier", "AI Ethics"],
        field: "AI Ethics \u00B7 Responsible AI \u00B7 Platform Principles",
        name: "AIonifier AI Ethics",
        desc: "The ethical framework governing every AI application on this platform. We do not collect personal data, we do not use cookies or tracking, we warn that AI can generate incorrect information, and we clearly state that this platform is not for real production use. Six principles covering privacy, transparency, human oversight, accuracy, scope, and accountability.",
        scale: "Framework \u2192 Responsible AI &amp; Ethical Deployment Principles",
        launch: "Read AI Ethics" },
      { id: "etymology", section: "etymology", tag: "LEXICON", href: CTX + "/BotViewer?bot=etymology",
        label: ["Etymology"],
        field: "Linguistics \u00B7 Word Origin \u00B7 Lexicology",
        name: "AIonifier \u2014 Etymology",
        desc: "An AI-generated exploration of the word <strong style=\"color:#86efac;\">AIonifier</strong>, first thought of by Gacirane Patrick in 2026. Traces the morphological roots of <em>AI</em> + <em>-on-</em> + <em>-ify</em> + <em>-er</em> back to Latin, Greek, and Old French sources. Includes IPA pronunciation, word forms, and definitions. <em>Note: this word is not recognised by any official linguistic authority and is used solely on this platform.</em>",
        scale: "AI-generated etymology \u2192 For platform use only \u00B7 2026",
        launch: "Read etymology" }
    ];

    var ARCH = {
      id: "arch", section: "hub", tag: "DOCS", href: CTX + "/BotViewer?bot=arch",
      field: "Platform \u00B7 AI Infrastructure \u00B7 Tech Stack",
      name: "Platform Architecture",
      desc: "Explore multi-agent pipelines, RAG MCP servers, Java EE frontends, Heroku deployments and PostgreSQL datastores behind all six domain MVPs.",
      scale: "Underpins \u2192 All 6 AI domain MVPs above",
      launch: "View architecture"
    };

    /* ---------- geometry helpers (angles: degrees clockwise from 12 o'clock) ---------- */
    var CX = 380, CY = 380;
    var R_LABEL = 348;   /* section label arc */
    var R_OUT   = 312;   /* wedge outer radius */
    var R_IN    = 132;   /* wedge inner radius */
    var R_HUB   = 110;   /* centre hub */
    var R_TEXT  = 224;   /* wedge label radius */
    var SVG_NS  = "http://www.w3.org/2000/svg";

    /* Wheel start angle. The 6 implemented apps are the first 6 items and span
       6 x 30 = 180 degrees, so starting at 270 (9 o'clock) places them across the
       WHOLE UPPER SEMICIRCLE (270 -> 0 -> 90). Everything else falls below. */
    var ROT = 270;
    function norm(a) { a %= 360; return a < 0 ? a + 360 : a; }

    function pt(aDeg, r) {
      var a = (aDeg * Math.PI) / 180;
      return [CX + r * Math.sin(a), CY - r * Math.cos(a)];
    }
    function wedgePath(a0, a1, rIn, rOut) {
      var p1 = pt(a0, rIn), p2 = pt(a0, rOut), p3 = pt(a1, rOut), p4 = pt(a1, rIn);
      var large = (a1 - a0) > 180 ? 1 : 0;
      return "M" + p1[0] + " " + p1[1] +
             " L" + p2[0] + " " + p2[1] +
             " A" + rOut + " " + rOut + " 0 " + large + " 1 " + p3[0] + " " + p3[1] +
             " L" + p4[0] + " " + p4[1] +
             " A" + rIn + " " + rIn + " 0 " + large + " 0 " + p1[0] + " " + p1[1] + " Z";
    }
    function arcPath(a0, a1, r, reverse) {
      var s = reverse ? pt(a1, r) : pt(a0, r);
      var e = reverse ? pt(a0, r) : pt(a1, r);
      var large = (a1 - a0) > 180 ? 1 : 0;
      var sweep = reverse ? 0 : 1;
      return "M" + s[0] + " " + s[1] + " A" + r + " " + r + " 0 " + large + " " + sweep + " " + e[0] + " " + e[1];
    }
    function arcLength(a0, a1, r) { return 2 * Math.PI * r * ((a1 - a0) / 360); }
    function el(name, attrs, parent) {
      var e = document.createElementNS(SVG_NS, name);
      for (var k in attrs) e.setAttribute(k, attrs[k]);
      if (parent) parent.appendChild(e);
      return e;
    }

    /* ---------- build the wheel ---------- */
    var svg = document.getElementById("wheel");
    var STEP = 360 / ITEMS.length;           /* 12 equal wedges of 30\u00B0 */
    var selectedId = null;

    /* outer decorative rings */
    el("circle", { cx: CX, cy: CY, r: R_OUT + 6,  "class": "section-ring" }, svg);
    el("circle", { cx: CX, cy: CY, r: R_LABEL + 14, "class": "section-ring" }, svg);

    /* section spans (contiguous items share a section), offset by ROT */
    var spans = [];
    ITEMS.forEach(function (it, i) {
      var a0 = ROT + i * STEP, a1 = ROT + (i + 1) * STEP;
      var last = spans[spans.length - 1];
      if (last && last.section === it.section) { last.a1 = a1; }
      else { spans.push({ section: it.section, a0: a0, a1: a1 }); }
    });

    /* arc-riding labels are auto-fitted so a narrow section never clips its text */
    var arcLabels = [];
    function fitArcLabels() {
      arcLabels.forEach(function (L) {
        var budget = L.len * 0.94;
        var variants = (L.short && L.short !== L.full) ? [L.full, L.short] : [L.full];
        for (var v = 0; v < variants.length; v++) {
          L.tp.textContent = variants[v];
          for (var fs = L.base; fs >= 7; fs -= 0.5) {
            L.text.style.fontSize = fs + "px";
            L.text.style.letterSpacing = (fs >= L.base - 1 ? "" : "0.10em");
            var w = 0;
            try { w = L.text.getComputedTextLength(); } catch (e) { return; }
            if (w <= budget) return;
          }
        }
      });
    }

    /* section arc labels + boundary lines */
    spans.forEach(function (sp, idx) {
      var mid = norm((sp.a0 + sp.a1) / 2);
      var reverse = mid > 90 && mid < 270; /* keep text upright on the bottom half */
      var pathId = "secArc" + idx;
      el("path", { id: pathId, d: arcPath(sp.a0 + 2, sp.a1 - 2, R_LABEL, reverse), fill: "none" }, svg);
      var t = el("text", { "class": "section-arc-label" }, svg);
      var tp = el("textPath", { startOffset: "50%", "text-anchor": "middle" }, t);
      tp.setAttributeNS("http://www.w3.org/1999/xlink", "xlink:href", "#" + pathId);
      tp.setAttribute("href", "#" + pathId);
      tp.textContent = SECTIONS[sp.section];
      arcLabels.push({ text: t, tp: tp, len: arcLength(sp.a0 + 2, sp.a1 - 2, R_LABEL),
                       full: SECTIONS[sp.section], short: SECTIONS_SHORT[sp.section], base: 12 });
      var b0 = pt(sp.a0, R_IN), b1 = pt(sp.a0, R_LABEL + 14);
      el("line", { x1: b0[0], y1: b0[1], x2: b1[0], y2: b1[1], "class": "section-divider-line" }, svg);
    });

    /* subgroup arc: upcoming MVPs, labelled but kept inside the AI MVP Applications group */
    var soonIdx = [];
    ITEMS.forEach(function (it, i) { if (it.soon) soonIdx.push(i); });
    if (soonIdx.length) {
      var sg0 = ROT + soonIdx[0] * STEP;
      var sg1 = ROT + (soonIdx[soonIdx.length - 1] + 1) * STEP;
      var sgRev = (function () { var m = norm((sg0 + sg1) / 2); return m > 90 && m < 270; })();
      el("path", { d: arcPath(sg0 + 1.5, sg1 - 1.5, R_OUT + 6), "class": "subgroup-arc-line" }, svg);
      el("path", { id: "sgArc", d: arcPath(sg0 + 2, sg1 - 2, R_OUT + 22, sgRev), fill: "none" }, svg);
      var sgt = el("text", { "class": "subgroup-arc-label" }, svg);
      var sgtp = el("textPath", { startOffset: "50%", "text-anchor": "middle" }, sgt);
      sgtp.setAttributeNS("http://www.w3.org/1999/xlink", "xlink:href", "#sgArc");
      sgtp.setAttribute("href", "#sgArc");
      sgtp.textContent = "Upcoming MVPs \u2014 In Development";
      arcLabels.push({ text: sgt, tp: sgtp, len: arcLength(sg0 + 2, sg1 - 2, R_OUT + 22),
                       full: "Upcoming MVPs \u2014 In Development", short: "Upcoming MVPs", base: 10.5 });
    }

    /* wedges + labels */
    ITEMS.forEach(function (it, i) {
      var a0 = ROT + i * STEP, a1 = ROT + (i + 1) * STEP;
      var midN = norm((a0 + a1) / 2);
      var w = el("path", {
        d: wedgePath(a0 + 0.6, a1 - 0.6, R_IN, R_OUT),
        "class": "wedge" + (it.soon ? " soon" : ""),
        tabindex: "0", role: "button",
        "aria-label": it.name + (it.soon ? " (coming soon)" : "")
      }, svg);
      w.dataset.id = it.id;
      w.addEventListener("click", function () { select(it.id, true); });
      w.addEventListener("keydown", function (ev) {
        if (ev.key === "Enter" || ev.key === " ") { ev.preventDefault(); select(it.id, true); }
      });

      var rot = midN - 90;
      if (midN > 180 && midN < 360) rot += 180;   /* keep left-side labels readable */
      var p = pt(midN, R_TEXT);
      var txt = el("text", {
        x: p[0], y: p[1], "text-anchor": "middle",
        transform: "rotate(" + rot + " " + p[0] + " " + p[1] + ")",
        "class": "wedge-label"
      }, svg);
      var lines = it.label.slice();
      if (it.soon) lines.push("\u23F3 SOON");
      var lh = 15, y0 = p[1] - ((lines.length - 1) * lh) / 2;
      lines.forEach(function (ln, li) {
        var ts = el("tspan", { x: p[0], y: y0 + li * lh }, txt);
        if (it.soon && li === lines.length - 1) ts.setAttribute("class", "sub-soon");
        ts.textContent = ln;
      });
    });

    /* centre hub = Platform Architecture */
    var hub = el("g", { "class": "hub-group", role: "button", tabindex: "0", "aria-label": "Platform Architecture" }, svg);
    el("circle", { cx: CX, cy: CY, r: R_HUB, "class": "hub-circle" }, hub);
    el("circle", { cx: CX, cy: CY, r: R_HUB - 10, fill: "none", stroke: "rgba(74,222,128,0.18)", "stroke-dasharray": "3 5" }, hub);
    var ht = el("text", { x: CX, y: CY - 4, "text-anchor": "middle", "class": "hub-text" }, hub);
    ht.textContent = "ARCHITECTURE";
    var hs = el("text", { x: CX, y: CY + 16, "text-anchor": "middle", "class": "hub-sub" }, hub);
    hs.textContent = "PLATFORM CORE \u00B7 DOCS";
    hub.addEventListener("click", function () { select("arch", true); });
    hub.addEventListener("keydown", function (ev) {
      if (ev.key === "Enter" || ev.key === " ") { ev.preventDefault(); select("arch", true); }
    });

    /* ---------- detail panel ---------- */
    var panel = document.getElementById("detailPanel");

    function findItem(id) {
      if (id === "arch") return ARCH;
      for (var i = 0; i < ITEMS.length; i++) if (ITEMS[i].id === id) return ITEMS[i];
      return null;
    }

    function render(it) {
      var html = "";
      html += "<div class=\"d-head\"><span class=\"d-section\">" +
              (it.section === "hub" ? "Platform Core" : SECTIONS[it.section]) +
              "</span><span class=\"d-tag\">" + it.tag + "</span></div>";
      if (it.soon) html += "<div class=\"soon-badge\">Upcoming MVP</div>";
      html += "<div><span class=\"bot-field\">" + it.field + "</span>";
      html += "<h2 class=\"bot-name\">" + it.name + "</h2>";
      html += "<p class=\"bot-desc\">" + it.desc + "</p>";
      html += "<p class=\"bot-scale\">" + it.scale + "</p></div>";
      html += "<div class=\"d-footer\">";
      if (it.soon) {
        html += "<span class=\"launch-label\" style=\"opacity:.4;font-family:'IBM Plex Mono',monospace;font-size:.6rem;letter-spacing:.1em;text-transform:uppercase;color:var(--green);\">Coming soon</span>";
        html += "<span class=\"cs-eta\">&#128336;&nbsp; In Development</span>";
      } else {
        html += "<a class=\"d-launch\" href=\"" + it.href + "\">" + it.launch +
                " <svg viewBox=\"0 0 24 24\"><line x1=\"5\" y1=\"12\" x2=\"19\" y2=\"12\"/><polyline points=\"12 5 19 12 12 19\"/></svg></a>";
      }
      html += "</div>";
      panel.innerHTML = html;
    }

    function select(id, scroll) {
      selectedId = id;
      svg.querySelectorAll(".wedge").forEach(function (w) {
        w.classList.toggle("selected", w.dataset.id === id);
      });
      hub.classList.toggle("selected", id === "arch");
      var it = findItem(id);
      if (it) render(it);
      if (scroll && window.matchMedia("(max-width: 900px)").matches) {
        panel.scrollIntoView({ behavior: "smooth", block: "nearest" });
      }
    }

    /* nav anchors still land on the right content: hash \u2192 first item of that section */
    function handleHash() {
      var h = (location.hash || "").replace("#", "");
      if (h === "apps") select("coreg", false);
      else if (h === "impact") select("sia", false);
      else if (h === "etymology") select("etymology", false);
    }
    window.addEventListener("hashchange", handleHash);

    /* nav active-state highlighting driven by selection */
    var navAs = document.querySelectorAll(".nav-links a");
    function markNav(hash) {
      navAs.forEach(function (a) { a.classList.toggle("active", a.getAttribute("href") === hash); });
    }
    window.addEventListener("hashchange", function () { markNav(location.hash); });

    /* initial state */
    handleHash();
    if (!selectedId) select("coreg", false);
    fitArcLabels();
    if (document.fonts && document.fonts.ready) { document.fonts.ready.then(fitArcLabels); }
  </script>
</body>
</html>
