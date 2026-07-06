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
  <meta property="og:description" content="5 live AI agentic applications spanning legal, clinical, banking, education, and HR— built end-to-end by GACIRANE Patrick." />
  <meta property="og:image"       content="<%= request.getContextPath() %>/images/aionifier-og.png" />
  <meta property="og:image:width"  content="1200" />
  <meta property="og:image:height" content="630" />
  <meta property="og:url"         content="https://aionifier.ai" />
  <meta name="twitter:card"        content="summary_large_image" />
  <meta name="twitter:title"       content="AIonifier.ai — AI MVP Portfolio" />
  <meta name="twitter:description" content="5 live AI agentic applications spanning legal, clinical, banking, education, and HR — built end-to-end by GACIRANE Patrick." />
  <meta name="twitter:image"       content="<%= request.getContextPath() %>/images/aionifier-og.png" />
  <meta name="description" content="AIonifier.ai — 5 live AI agentic applications spanning legal, clinical, banking, education, and HR — built end-to-end by GACIRANE Patrick." />
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
    /* GRID */
    .bots-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: clamp(12px, 2vw, 22px); width: 100%; }
    @media (max-width: 860px) { .bots-grid { grid-template-columns: repeat(2, 1fr); } .bots-grid .bot-card:nth-child(5) { grid-column: auto; } }
    @media (max-width: 480px) { .bots-grid { grid-template-columns: 1fr; } }
    /* COMING SOON */
    .bot-card.coming-soon { flex-direction: column; cursor: default; border-style: dashed; border-color: rgba(74,222,128,0.28); border-top: 3px solid rgba(74,222,128,0.55); background: rgba(13,17,28,0.7); opacity: 0.9; }
    .bot-card.coming-soon:hover { transform: none; box-shadow: none; border-color: rgba(74,222,128,0.42); }
    .bot-card.coming-soon:hover::before { opacity: 0.3; }
    .soon-badge { display: inline-flex; align-items: center; gap: 6px; font-family: "IBM Plex Mono", monospace; font-size: clamp(0.54rem, 0.9vw, 0.62rem); letter-spacing: 0.18em; text-transform: uppercase; color: var(--green); border: 1px dashed rgba(74,222,128,0.45); background: rgba(74,222,128,0.06); padding: 3px 10px; border-radius: 20px; margin-bottom: 8px; width: fit-content; }
    .soon-badge::before { content: ''; width: 6px; height: 6px; border-radius: 50%; background: var(--green); opacity: .75; animation: blink 1.8s ease-in-out infinite; }
    .cs-footer { display: flex; align-items: center; justify-content: space-between; margin-top: auto; padding-top: 12px; border-top: 1px solid rgba(255,255,255,0.05); }
    .cs-eta { font-family: "IBM Plex Mono", monospace; font-size: clamp(0.52rem, 0.85vw, 0.60rem); letter-spacing: 0.12em; text-transform: uppercase; color: var(--muted); opacity: .6; white-space: nowrap; }
    /* CARD */
    .bot-card { position: relative; border-radius: 16px; padding: clamp(18px,2.5vw,26px) clamp(16px,2vw,22px) clamp(16px,2vw,22px); text-decoration: none; cursor: pointer; display: flex; flex-direction: column; gap: 12px; background: var(--surface); border: 1px solid var(--border); overflow: hidden; transition: transform .3s cubic-bezier(.22,.68,0,1.2), box-shadow .3s, border-color .3s; }
    .bot-card::before { content: ""; position: absolute; inset: 0; border-radius: 16px; background: radial-gradient(ellipse at top left, rgba(74,222,128,0.09) 0%, transparent 65%); opacity: 0; transition: opacity .3s; pointer-events: none; }
    .bot-card:hover { transform: translateY(-5px) scale(1.01); border-color: rgba(74,222,128,0.3); box-shadow: 0 18px 40px rgba(74,222,128,0.11); }
    .bot-card:hover::before { opacity: 1; }
    .mvp-tag, .sia-tag, .ety-tag, .ethics-tag { position: absolute; top: 11px; right: 0; font-family: "IBM Plex Mono", monospace; font-size: 0.48rem; letter-spacing: 0.18em; text-transform: uppercase; padding: 3px 8px 3px 6px; border-radius: 4px 0 0 4px; background: rgba(74,222,128,0.07); border: 1px solid rgba(74,222,128,0.16); border-right: none; color: rgba(74,222,128,0.6); }
    .corner-glow { position: absolute; top: -16px; right: -16px; width: 72px; height: 72px; border-radius: 50%; background: radial-gradient(circle, rgba(74,222,128,0.11) 0%, transparent 70%); pointer-events: none; }
    .bot-icon { width: clamp(44px,6vw,54px); height: clamp(44px,6vw,54px); border-radius: 12px; display: flex; align-items: center; justify-content: center; background: rgba(74,222,128,0.09); border: 1px solid rgba(74,222,128,0.2); flex-shrink: 0; transition: background .3s, transform .3s; }
    .bot-icon svg { width: clamp(22px,3vw,26px); height: clamp(22px,3vw,26px); stroke: var(--green); fill: none; stroke-width: 1.8; stroke-linecap: round; stroke-linejoin: round; }
    .bot-card:hover .bot-icon { background: rgba(74,222,128,0.17); transform: rotate(-4deg) scale(1.08); }
    .bot-field { font-family: "IBM Plex Mono", monospace; font-size: clamp(0.52rem, 0.85vw, 0.60rem); letter-spacing: 0.17em; text-transform: uppercase; color: var(--green); opacity: .72; margin-bottom: 3px; display: block; }
    .bot-name { font-size: clamp(0.9rem, 1.5vw, 1.04rem); font-weight: 700; color: var(--text); margin: 0 0 7px; line-height: 1.22; }
    .bot-desc { font-size: clamp(0.70rem, 1.1vw, 0.77rem); color: var(--muted); line-height: 1.65; margin: 0; font-weight: 300; }
    .bot-scale { font-family: "IBM Plex Mono", monospace; font-size: 0.52rem; letter-spacing: 0.11em; text-transform: uppercase; color: var(--green); opacity: .45; margin-top: 3px; display: flex; align-items: center; gap: 4px; }
    .bot-scale::before { content: ""; display: inline-block; width: 4px; height: 4px; border-radius: 50%; background: var(--green); }
    .bot-footer { display: flex; align-items: center; justify-content: space-between; margin-top: auto; padding-top: 12px; border-top: 1px solid rgba(255,255,255,0.05); }
    .launch-label { font-family: "IBM Plex Mono", monospace; font-size: clamp(0.54rem, 0.88vw, 0.62rem); letter-spacing: 0.1em; text-transform: uppercase; color: var(--green); opacity: .58; transition: opacity .2s; }
    .bot-card:hover .launch-label { opacity: 1; }
    .arrow-circle { width: 28px; height: 28px; border-radius: 50%; flex-shrink: 0; background: rgba(74,222,128,0.09); border: 1px solid rgba(74,222,128,0.26); display: flex; align-items: center; justify-content: center; transition: background .25s, transform .25s; }
    .arrow-circle svg { width: 12px; height: 12px; stroke: var(--green); fill: none; stroke-width: 2.2; stroke-linecap: round; stroke-linejoin: round; transition: stroke .25s; }
    .bot-card:hover .arrow-circle { background: var(--green); transform: translateX(3px); }
    .bot-card:hover .arrow-circle svg { stroke: var(--bg); }
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
          <p><strong>AIonifier</strong> &mdash; AI (Artificial Intelligence) MVP (Minimum Viable Product) Portfolio &mdash; is a personal AI MVP portfolio by GACIRANE Patrick &mdash; 13 live agentic applications and 2 in development, each built end-to-end to demonstrate production-grade AI engineering across real-world domains.</p>
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
        <div class="stat-sub">13 Live &middot; 2 In Dev</div>
      </div>
      <div class="icard">
        <div class="icard-label">Technology Stack</div>
        <div class="icard-body">
          <div class="pill-row">
            <span class="pill">CrewAI Agents</span>
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
      <div class="dl"></div><span>AI MVP Applications &mdash; Select a Specialist</span><div class="dlr"></div>
    </div>

    <div class="bots-grid">
      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=coreg">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><rect x="2" y="3" width="5" height="4" rx="1"/><rect x="17" y="3" width="5" height="4" rx="1"/><rect x="9" y="17" width="6" height="4" rx="1"/><line x1="4.5" y1="7" x2="4.5" y2="14"/><line x1="19.5" y1="7" x2="19.5" y2="14"/><line x1="4.5" y1="14" x2="12" y2="19"/><line x1="19.5" y1="14" x2="12" y2="19"/><circle cx="4.5" cy="14" r="1.2" fill="#4ade80" stroke="none"/><circle cx="19.5" cy="14" r="1.2" fill="#4ade80" stroke="none"/></svg></div>
        <div>
          <span class="bot-field">RegTech &middot; Cross-Regulatory Intelligence &middot; Compliance Advisory</span>
          <h2 class="bot-name">Regulatory Navigator AI</h2>
          <p class="bot-desc">Move confidently through multi-regulator compliance with a clear, guided path. Four specialist regulatory crews &mdash; <strong>RICA</strong>, <strong>RURA</strong>, <strong>NCSA</strong> and <strong>BNR</strong> &mdash; each answer questions within their own domain, while an <strong>orchestrator agent</strong> coordinates them and synthesises a single, well-reasoned, aggregated response. Every answer is grounded in official regulatory texts via a RAG knowledge base.</p>
          <p class="bot-scale">Scalable &rarr; National Smart Regulation (RegTech) Platform</p>
        </div>
        <div class="bot-footer"><span class="launch-label">Launch navigator</span><span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span></div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=legal">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><line x1="12" y1="3" x2="12" y2="21"/><line x1="4" y1="6" x2="20" y2="6"/><path d="M4 6 L2 11 Q4 13 6 11 Z"/><path d="M20 6 L18 11 Q20 13 22 11 Z"/><line x1="8" y1="21" x2="16" y2="21"/></svg></div>
        <div>
          <span class="bot-field">Legal Tech &middot; Compliance Automation</span>
          <h2 class="bot-name">Global Legal Advisor</h2>
          <p class="bot-desc">Navigate international regulations, draft legal briefs, and get jurisdiction-aware guidance across 180+ countries via multi-agent legal reasoning.</p>
          <p class="bot-scale">Scalable &rarr; Enterprise Legal Intelligence Platform</p>
        </div>
        <div class="bot-footer"><span class="launch-label">Launch advisor</span><span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span></div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=bank">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><rect x="3" y="10" width="2.5" height="9" rx="0.5"/><rect x="7.5" y="10" width="2.5" height="9" rx="0.5"/><rect x="14" y="10" width="2.5" height="9" rx="0.5"/><rect x="18.5" y="10" width="2.5" height="9" rx="0.5"/><polyline points="1 10 12 3 23 10"/><line x1="1" y1="19" x2="23" y2="19"/><polyline points="7.5 16 10 13.5 14 15 18.5 11.5" stroke-width="1.4"/></svg></div>
        <div>
          <span class="bot-field">Banking &middot; CRM &middot; Financial Services</span>
          <h2 class="bot-name">Bank CRM Advisor</h2>
          <p class="bot-desc">Deepen client relationships, automate follow-ups, and surface actionable insights from banking CRM data — powered by a 9-agent CrewAI system.</p>
          <p class="bot-scale">Scalable &rarr; Retail Banking Intelligence Suite</p>
        </div>
        <div class="bot-footer"><span class="launch-label">Launch advisor</span><span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span></div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=hiv">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><rect x="9" y="3" width="6" height="18" rx="1.5"/><rect x="3" y="9" width="18" height="6" rx="1.5"/><polyline points="3 12 6 12 8 8 10 16 12 10 14 14 16 12 21 12" stroke-width="1.3" stroke="#0b0f1a" fill="none"/></svg></div>
        <div>
          <span class="bot-field">Healthcare &middot; Clinical Guidelines &middot; HIV/AIDS</span>
          <h2 class="bot-name">HIV Guidelines Assistant</h2>
          <p class="bot-desc">Retrieve verified ART regimens, PMTCT protocols, and paediatric dosing from Rwanda HIV Guidelines 2022 via RAG over RBC clinical documentation.</p>
          <p class="bot-scale">Scalable &rarr; National Clinical Decision Support System</p>
        </div>
        <div class="bot-footer"><span class="launch-label">Launch advisor</span><span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span></div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=grad">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><polygon points="12 3 22 8 12 13 2 8"/><path d="M6 10.5 v5 Q12 18.5 18 15.5 v-5"/><line x1="22" y1="8" x2="22" y2="14"/><circle cx="22" cy="15" r="1" fill="#4ade80" stroke="none"/></svg></div>
        <div>
          <span class="bot-field">EdTech &middot; Career Advisory &middot; Education</span>
          <h2 class="bot-name">Smart Grad</h2>
          <p class="bot-desc">Agentic university scouting, financial roadmapping, visa navigation and cultural landing — built for any students pursuing global education.</p>
          <p class="bot-scale">Scalable &rarr; Global Student Advisory Platform</p>
        </div>
        <div class="bot-footer"><span class="launch-label">Launch advisor</span><span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span></div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=cv">
        <div class="corner-glow"></div><span class="mvp-tag">MVP</span>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><rect x="2" y="5" width="15" height="14" rx="2"/><circle cx="7" cy="11" r="2.5"/><line x1="11" y1="9.5" x2="14.5" y2="9.5"/><line x1="11" y1="12" x2="14.5" y2="12"/><path d="M17 4 h4 a1 1 0 0 1 1 1 v5 a1 1 0 0 1 -1 1 h-2 l-2 2 v-2 a1 1 0 0 1 -1 -1 v-5 a1 1 0 0 1 1 -1 z"/><circle cx="19" cy="7" r="0.6" fill="#4ade80" stroke="none"/><circle cx="21" cy="7" r="0.6" fill="#4ade80" stroke="none"/></svg></div>
        <div>
          <span class="bot-field">HRTech &middot; Talent Intelligence &middot; Recruitment</span>
          <h2 class="bot-name">Talk to My CV</h2>
          <p class="bot-desc">Chat directly with Patrick's CV — skills, projects, and experience all conversationally accessible via RAG-powered talent profiling.</p>
          <p class="bot-scale">Scalable &rarr; AI-Powered Recruitment Screening Tool</p>
        </div>
        <div class="bot-footer"><span class="launch-label">Start a conversation</span><span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span></div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=arch">
        <div class="corner-glow"></div><span class="mvp-tag">DOCS</span>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><circle cx="12" cy="5" r="2"/><circle cx="4" cy="19" r="2"/><circle cx="20" cy="19" r="2"/><circle cx="12" cy="19" r="2"/><line x1="12" y1="7" x2="12" y2="17"/><line x1="12" y1="17" x2="4" y2="17"/><line x1="12" y1="17" x2="20" y2="17"/><line x1="4" y1="17" x2="4" y2="19"/><line x1="20" y1="17" x2="20" y2="19"/><line x1="12" y1="17" x2="12" y2="19"/></svg></div>
        <div>
          <span class="bot-field">Platform &middot; AI Infrastructure &middot; Tech Stack</span>
          <h2 class="bot-name">Platform Architecture</h2>
          <p class="bot-desc">Explore multi-agent pipelines, RAG MCP servers, Java EE frontends, Heroku deployments and PostgreSQL datastores behind all six domain MVPs.</p>
          <p class="bot-scale">Underpins &rarr; All 6 AI domain MVPs above</p>
        </div>
        <div class="bot-footer"><span class="launch-label">View architecture</span><span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span></div>
      </a>

      <div class="bot-card coming-soon" role="article" aria-label="AI Voice Avatar — Coming Soon">
        <div class="corner-glow"></div>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><rect x="9" y="2" width="6" height="11" rx="3"/><path d="M5 10a7 7 0 0 0 14 0"/><line x1="12" y1="17" x2="12" y2="21"/><line x1="8" y1="21" x2="16" y2="21"/><circle cx="12" cy="7" r="1.2" fill="#4ade80" stroke="none"/></svg></div>
        <div>
          <div class="soon-badge">Upcoming MVP</div>
          <span class="bot-field">Voice AI &middot; Career Intelligence &middot; Digital Twin</span>
          <h2 class="bot-name">AI Voice Avatar</h2>
          <p class="bot-desc">A voice-first chatbot powered by a cloned voice of GACIRANE Patrick — letting visitors have a natural spoken conversation about his professional career, projects, skills, and experience. Built on voice synthesis, RAG over career data, and real-time audio streaming.</p>
          <p class="bot-scale">Scalable &rarr; AI-Powered Professional Digital Twin</p>
        </div>
        <div class="cs-footer"><span class="launch-label" style="opacity:.4;">Coming soon</span><span class="cs-eta">&#128336;&nbsp; In Development</span></div>
      </div>

      <div class="bot-card coming-soon" role="article" aria-label="Global Funding Scout AI — Coming Soon">
        <div class="corner-glow"></div>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="7"/><line x1="16.5" y1="16.5" x2="21" y2="21"/><line x1="8" y1="11" x2="14" y2="11"/><line x1="11" y1="8" x2="11" y2="14"/><circle cx="11" cy="11" r="2.5" fill="#4ade80" stroke="none" opacity="0.35"/></svg></div>
        <div>
          <div class="soon-badge">Upcoming MVP</div>
          <span class="bot-field">FundTech &middot; Grant Intelligence &middot; International Finance</span>
          <h2 class="bot-name">Global Funding Scout AI</h2>
          <p class="bot-desc">A 4-agent CrewAI system that autonomously searches international funding databases, scrapes full eligibility criteria and deadlines, verifies geographic eligibility for your target country, and generates <strong>sector-specific outreach messaging templates</strong> — delivering a compiled funding intelligence report with an interactive dashboard covering grants, investments, and sponsorships across Education, Youth, Women Empowerment, and Climate Resilience sectors.</p>
          <p class="bot-scale">Scalable &rarr; International Development Finance Intelligence Platform</p>
        </div>
        <div class="cs-footer"><span class="launch-label" style="opacity:.4;">Coming soon</span><span class="cs-eta">&#128336;&nbsp; In Development</span></div>
      </div>
    </div>

    <div class="divider" id="impact">
      <div class="dl"></div><span>Social Impact Assessments &mdash; AIonifier AI Ethics</span><div class="dlr"></div>
    </div>

    <div class="bots-grid">
      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=sia">
        <div class="corner-glow"></div><span class="sia-tag">REPORT</span>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M8 12 Q10 8 12 12 Q14 16 16 12"/><line x1="12" y1="3" x2="12" y2="5"/><line x1="12" y1="19" x2="12" y2="21"/><line x1="3" y1="12" x2="5" y2="12"/><line x1="19" y1="12" x2="21" y2="12"/></svg></div>
        <div>
          <span class="bot-field">AI Ethics &middot; Responsible AI &middot; Policy</span>
          <h2 class="bot-name">Social Impact Assessment</h2>
          <p class="bot-desc">A structured Social Impact Matrix evaluation of two AIonifier MVPs — <strong style="color:#c8d4e8;">SmartAttorney AI</strong> and the <strong style="color:#c8d4e8;">Rwanda HIV Guidelines Assistant</strong>. Each is assessed across Individual, Collective, and Societal dimensions for both <em>harms</em> and <em>benefits</em> — following the Social Impact Matrix methodology adopted across East Africa. Essential reading for investors, regulators, and implementation partners.</p>
          <p class="bot-scale">Framework &rarr; Social Impact Matrix (Assessing Harms &amp; Amplifying Benefits)</p>
        </div>
        <div class="bot-footer"><span class="launch-label">View full assessment</span><span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span></div>
      </a>

      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=ethics">
        <div class="corner-glow"></div><span class="ethics-tag">ETHICS</span>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><path d="M12 2L3 7v5c0 5.25 3.75 10.15 9 11.25C17.25 22.15 21 17.25 21 12V7z"/><polyline points="9 12 11 14 15 10"/></svg></div>
        <div>
          <span class="bot-field">AI Ethics &middot; Responsible AI &middot; Platform Principles</span>
          <h2 class="bot-name">AIonifier AI Ethics</h2>
          <p class="bot-desc">The ethical framework governing every AI application on this platform. We do not collect personal data, we do not use cookies or tracking, we warn that AI can generate incorrect information, and we clearly state that this platform is not for real production use. Six principles covering privacy, transparency, human oversight, accuracy, scope, and accountability.</p>
          <p class="bot-scale">Framework &rarr; Responsible AI &amp; Ethical Deployment Principles</p>
        </div>
        <div class="bot-footer"><span class="launch-label">Read AI Ethics</span><span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span></div>
      </a>
    </div>

    <div class="divider" id="etymology">
      <div class="dl"></div><span>AIonifier Etymology &mdash; Origin of the Word</span><div class="dlr"></div>
    </div>

    <div class="bots-grid">
      <a class="bot-card" href="<%= ctx %>/BotViewer?bot=etymology">
        <div class="corner-glow"></div><span class="ety-tag">LEXICON</span>
        <div class="bot-icon"><svg viewBox="0 0 24 24"><path d="M4 19V5a2 2 0 0 1 2-2h13a1 1 0 0 1 1 1v13"/><path d="M4 19a2 2 0 0 0 2 2h13a1 1 0 0 0 1-1v-1"/><line x1="8" y1="7" x2="14" y2="7"/><line x1="8" y1="11" x2="16" y2="11"/><line x1="8" y1="15" x2="12" y2="15"/></svg></div>
        <div>
          <span class="bot-field">Linguistics &middot; Word Origin &middot; Lexicology</span>
          <h2 class="bot-name">AIonifier &mdash; Etymology</h2>
          <p class="bot-desc">An AI-generated exploration of the word <strong style="color:#86efac;">AIonifier</strong>, first thought of by Gacirane Patrick in 2026. Traces the morphological roots of <em>AI</em> + <em>-on-</em> + <em>-ify</em> + <em>-er</em> back to Latin, Greek, and Old French sources. Includes IPA pronunciation, word forms, and definitions. <em>Note: this word is not recognised by any official linguistic authority and is used solely on this platform.</em></p>
          <p class="bot-scale">AI-generated etymology &rarr; For platform use only &middot; 2026</p>
        </div>
        <div class="bot-footer"><span class="launch-label">Read etymology</span><span class="arrow-circle"><svg viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></span></div>
      </a>
    </div>

    <footer class="page-footer">
      <p>&copy; 2026 <a href="https://www.linkedin.com/in/patricus/" target="_blank" rel="noopener noreferrer">GACIRANE Patrick</a> &mdash; AIonifier AI Suite</p>
    </footer>
  </div>

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
    ["top","apps","impact","etymology"].forEach(id => { const el = document.getElementById(id); if (el) obs.observe(el); });
  </script>
</body>
</html>
