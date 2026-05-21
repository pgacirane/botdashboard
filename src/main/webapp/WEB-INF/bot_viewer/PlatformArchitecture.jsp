<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Platform Architecture — PagaDromeda AI Suite</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&family=IBM+Plex+Mono:wght@400;500&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    html, body {
      height: 100%;
      background: #0d1117;
      color: #f0f4ff;
      font-family: 'Sora', sans-serif;
      -webkit-font-smoothing: antialiased;
      overflow: hidden; /* shell handles layout; viewport handles scroll */
    }

    /* ── Shell ── */
    .shell { display: flex; flex-direction: column; height: 100vh; }

    /* ── Top bar ── */
    .top-bar {
      flex-shrink: 0;
      background: rgba(13,17,23,0.97);
      border-bottom: 1px solid rgba(255,255,255,0.07);
      padding: 0 20px;
      height: 52px;
      display: flex; align-items: center; justify-content: space-between; gap: 16px;
      z-index: 10;
    }

    .brand {
      font-family: 'IBM Plex Mono', monospace;
      font-size: 0.7rem; letter-spacing: 0.18em; text-transform: uppercase;
      color: #4ade80; display: flex; align-items: center; gap: 8px; flex-shrink: 0;
    }
    .brand-dot {
      width: 6px; height: 6px; border-radius: 50%;
      background: #4ade80; box-shadow: 0 0 6px #4ade80;
      animation: pdot 2.4s ease-in-out infinite;
    }
    @keyframes pdot { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:.4;transform:scale(.7)} }

    .subtitle { font-size: 0.74rem; color: #6b7a99; font-weight: 300; }

    /* ── Zoom toolbar ── */
    .toolbar { display: flex; align-items: center; gap: 6px; flex-shrink: 0; }

    .tb-btn {
      height: 34px; min-width: 34px; padding: 0 10px;
      border-radius: 8px;
      border: 1px solid rgba(255,255,255,0.12);
      background: rgba(255,255,255,0.05);
      color: #c9d1e0;
      font-family: 'IBM Plex Mono', monospace; font-size: 0.62rem;
      letter-spacing: 0.08em; text-transform: uppercase;
      cursor: pointer; display: flex; align-items: center; justify-content: center;
      user-select: none; transition: background .16s, border-color .16s, color .16s;
      white-space: nowrap;
    }
    .tb-btn:hover { background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.25); color: #f0f4ff; }
    .tb-btn:active { transform: scale(0.94); }
    .tb-btn.large { font-size: 18px; font-weight: 300; padding: 0; width: 34px; }
    .tb-btn.green { border-color: rgba(74,222,128,0.3); background: rgba(74,222,128,0.08); color: #4ade80; }
    .tb-btn.green:hover { background: rgba(74,222,128,0.16); border-color: rgba(74,222,128,0.5); }

    .z-pct {
      font-family: 'IBM Plex Mono', monospace; font-size: 0.65rem;
      color: #6b7a99; min-width: 48px; text-align: center; letter-spacing: 0.05em;
    }
    .sep { width: 1px; height: 22px; background: rgba(255,255,255,0.1); margin: 0 4px; }

    /* ── Hint bar ── */
    .hint-bar {
      flex-shrink: 0;
      background: rgba(10,14,20,0.8);
      border-bottom: 1px solid rgba(255,255,255,0.04);
      padding: 4px 20px;
      display: flex; align-items: center; gap: 18px; flex-wrap: wrap;
    }
    .hint {
      font-family: 'IBM Plex Mono', monospace; font-size: 0.56rem;
      letter-spacing: 0.08em; text-transform: uppercase;
      color: rgba(255,255,255,0.2);
      display: flex; align-items: center; gap: 5px;
    }
    .hk {
      background: rgba(255,255,255,0.07); border: 1px solid rgba(255,255,255,0.1);
      border-radius: 3px; padding: 0 4px; font-size: 0.53rem; color: rgba(255,255,255,0.28);
    }

    /* ══════════════════════════════════════════════════════
       VIEWPORT — THIS IS THE KEY FIX
       overflow: auto  →  native scrollbars appear automatically
       when the image is wider or taller than the viewport.
       Both horizontal AND vertical scroll work out of the box.
    ══════════════════════════════════════════════════════ */
    .viewport {
      flex: 1;
      overflow: auto;          /* ← scrollbars when content > viewport */
      position: relative;
      background:
        radial-gradient(ellipse 70% 50% at 10% 10%, rgba(74,222,128,0.03) 0%, transparent 55%),
        radial-gradient(ellipse 50% 40% at 90% 90%, rgba(34,211,238,0.03) 0%, transparent 55%),
        #0d1117;
      /* Dot grid */
      background-image:
        radial-gradient(circle, rgba(255,255,255,0.055) 1px, transparent 1px),
        radial-gradient(ellipse 70% 50% at 10% 10%, rgba(74,222,128,0.03) 0%, transparent 55%);
      background-size: 26px 26px, 100% 100%;
    }

    /* Inner wrapper: centers image, grows with zoom */
    .img-wrap {
      display: flex;
      justify-content: center;
      align-items: flex-start;
      min-width: 100%;        /* always at least viewport-wide   */
      min-height: 100%;       /* always at least viewport-tall    */
      padding: 20px;
    }

    /* The image — JS controls its width to implement zoom */
    #archImg {
      display: block;
      max-width: none;        /* override any browser max-width   */
      height: auto;           /* maintain aspect ratio            */
      border-radius: 6px;
      box-shadow: 0 4px 32px rgba(0,0,0,0.5);
      user-select: none;
      -webkit-user-drag: none;
      cursor: zoom-in;
      transition: width 0.12s ease; /* smooth zoom step animation */
    }

    /* Error state */
    .img-error {
      display: none;
      flex-direction: column; align-items: center; justify-content: center;
      gap: 12px;
      color: #ef4444; font-family: 'IBM Plex Mono', monospace; font-size: 0.75rem;
      padding: 60px 20px; text-align: center;
    }
    .img-error.visible { display: flex; }
    .img-error svg { width: 48px; height: 48px; opacity: 0.5; }

    /* ── Corner badges ── */
    .badge-zoom {
      position: fixed;
      bottom: 20px; right: 20px;
      background: rgba(13,17,23,0.9);
      border: 1px solid rgba(255,255,255,0.09);
      border-radius: 7px; padding: 5px 11px;
      font-family: 'IBM Plex Mono', monospace; font-size: 0.64rem;
      letter-spacing: 0.07em; color: #6b7a99;
      backdrop-filter: blur(8px);
      z-index: 20; pointer-events: none;
      transition: opacity .3s;
    }

    .badge-scroll {
      position: fixed;
      bottom: 20px; left: 20px;
      background: rgba(13,17,23,0.9);
      border: 1px solid rgba(255,255,255,0.09);
      border-radius: 7px; padding: 5px 11px;
      font-family: 'IBM Plex Mono', monospace; font-size: 0.6rem;
      letter-spacing: 0.07em; color: rgba(74,222,128,0.6);
      backdrop-filter: blur(8px);
      z-index: 20; pointer-events: none;
      opacity: 0; transition: opacity .3s;
    }
    .badge-scroll.visible { opacity: 1; }

    /* Fullscreen + download (bottom-left, above scroll badge) */
    .corner-btns {
      position: fixed;
      bottom: 56px; left: 20px;
      display: flex; gap: 8px;
      z-index: 20;
    }
    .corner-btn {
      width: 36px; height: 36px; border-radius: 8px;
      border: 1px solid rgba(255,255,255,0.1);
      background: rgba(13,17,23,0.88);
      color: #6b7a99; cursor: pointer;
      display: flex; align-items: center; justify-content: center;
      transition: color .2s, border-color .2s;
      backdrop-filter: blur(8px);
      text-decoration: none;
    }
    .corner-btn:hover { color: #4ade80; border-color: rgba(74,222,128,0.4); }
    .corner-btn svg { width: 15px; height: 15px; fill: none; stroke: currentColor; stroke-width: 2; stroke-linecap: round; stroke-linejoin: round; }
  </style>
</head>
<body>
<div class="shell">

  <!-- ── Top bar ── -->
  <div class="top-bar">
    <div style="display:flex;align-items:center;gap:16px;min-width:0;">
      <div class="brand"><span class="brand-dot"></span>PagaDromeda</div>
      <div class="subtitle">Platform Architecture &amp; Tech Stack</div>
    </div>
    <div class="toolbar">
      <button class="tb-btn large" id="btnOut" title="Zoom out (-)">−</button>
      <span   class="z-pct"       id="zPct">100%</span>
      <button class="tb-btn large" id="btnIn"  title="Zoom in (+)">+</button>
      <div class="sep"></div>
      <button class="tb-btn"       id="btn50"  title="50%">50%</button>
      <button class="tb-btn"       id="btn100" title="Actual size">100%</button>
      <button class="tb-btn"       id="btn200" title="200%">200%</button>
      <div class="sep"></div>
      <button class="tb-btn green" id="btnFit" title="Fit to window (F)">Fit</button>
    </div>
  </div>

  <!-- ── Hint bar ── -->
  <div class="hint-bar">
    <span class="hint"><span class="hk">Scroll</span> pan vertically</span>
    <span class="hint"><span class="hk">Shift + Scroll</span> pan horizontally</span>
    <span class="hint"><span class="hk">Ctrl + Scroll</span> zoom</span>
    <span class="hint"><span class="hk">+</span><span class="hk">−</span> zoom</span>
    <span class="hint"><span class="hk">F</span> fit to window</span>
    <span class="hint"><span class="hk">1</span> 100%</span>
    <span class="hint"><span class="hk">Pinch</span> mobile zoom</span>
  </div>

  <!-- ── Viewport (scrollable) ── -->
  <div class="viewport" id="vp">
    <div class="img-wrap" id="wrap">
      <%--
        ══════════════════════════════════════════════════════════════
        IMAGE PATH FIX — choose ONE of these two options:

        OPTION A (recommended — move file outside WEB-INF):
          Move your JPG to:  webapp/images/architecture.jpg
          Use src below as-is.

        OPTION B (keep in WEB-INF — needs ImageServlet):
          Keep file at: WEB-INF/svg/architecture.jpg
          Add ImageServlet.java that maps /images/* → WEB-INF/svg/*
          Use src below as-is.

        The browser CANNOT directly access WEB-INF/ — that is why
        you see a broken image. Either move the file OR add a servlet.
        ══════════════════════════════════════════════════════════════
      --%>
      <img id="archImg"
           src="<%= ctx %>/images/architecture.jpg"
           alt="PagaDromeda Platform Architecture Diagram"/>

      <!-- Error message shown if image fails to load -->
      <div class="img-error" id="imgError">
        <svg viewBox="0 0 24 24" fill="none" stroke="#ef4444" strokeWidth="1.5">
          <rect x="3" y="3" width="18" height="18" rx="2"/>
          <line x1="9" y1="9" x2="15" y2="15"/><line x1="15" y1="9" x2="9" y2="15"/>
        </svg>
        <div style="font-size:0.85rem;color:#ef4444;">Image could not be loaded</div>
        <div style="color:rgba(255,255,255,0.35);font-size:0.7rem;max-width:380px;line-height:1.7;">
          Files inside <code style="color:#f59e0b">WEB-INF/</code> are not browser-accessible.<br/>
          Move <code style="color:#f59e0b">architecture.jpg</code> to
          <code style="color:#4ade80">webapp/images/architecture.jpg</code>
          or add an <code style="color:#4ade80">ImageServlet</code> to proxy it.
        </div>
      </div>
    </div>
  </div>

</div>

<!-- Fixed corner UI -->
<div class="badge-zoom"  id="zBadge">100%</div>
<div class="badge-scroll" id="scrollBadge">Scrollable</div>

<div class="corner-btns">
  <button class="corner-btn" id="btnFS" title="Fullscreen">
    <svg id="fsExp"  viewBox="0 0 24 24"><path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3"/></svg>
    <svg id="fsColl" viewBox="0 0 24 24" style="display:none"><path d="M8 3v3a2 2 0 0 1-2 2H3m18 0h-3a2 2 0 0 1-2-2V3m0 18v-3a2 2 0 0 0 2-2h3M3 16h3a2 2 0 0 0 2 2v3"/></svg>
  </button>
  <a class="corner-btn"
     href="<%= ctx %>/images/architecture.jpg"
     download="pagadromeda-architecture.jpg"
     title="Download JPG">
    <svg viewBox="0 0 24 24"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
  </a>
</div>

<script>
(function () {
  "use strict";

  /* ── Config ── */
  const STEP     = 0.15;   // zoom step per button click
  const MIN      = 0.05;   // 5%
  const MAX      = 8.0;    // 800%
  const PRESETS  = [0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0];

  /* ── State ── */
  let naturalW = 0;   // image natural pixel width
  let naturalH = 0;   // image natural pixel height
  let scale    = 1;   // current zoom scale
  let loaded   = false;

  /* ── DOM ── */
  const vp          = document.getElementById('vp');
  const img         = document.getElementById('archImg');
  const imgError    = document.getElementById('imgError');
  const zPct        = document.getElementById('zPct');
  const zBadge      = document.getElementById('zBadge');
  const scrollBadge = document.getElementById('scrollBadge');
  const btnIn       = document.getElementById('btnIn');
  const btnOut      = document.getElementById('btnOut');
  const btn50       = document.getElementById('btn50');
  const btn100      = document.getElementById('btn100');
  const btn200      = document.getElementById('btn200');
  const btnFit      = document.getElementById('btnFit');
  const btnFS       = document.getElementById('btnFS');
  const fsExp       = document.getElementById('fsExp');
  const fsColl      = document.getElementById('fsColl');

  /* ══════════════════════════════════════════════════════
     CORE ZOOM FUNCTION
     Sets img.style.width = naturalW * scale px.
     The viewport (overflow:auto) automatically shows
     scrollbars when the image is wider/taller than the
     viewport — no manual scroll logic needed.
  ══════════════════════════════════════════════════════ */
  function applyScale(newScale) {
    if (!loaded) return;
    scale = Math.min(MAX, Math.max(MIN, newScale));

    /* Disable transition for large jumps (feels snappier) */
    const jump = Math.abs(newScale - scale) > 0.5;
    img.style.transition = jump ? 'none' : 'width 0.12s ease';

    /* ── This is all that's needed to zoom ── */
    img.style.width  = (naturalW * scale) + 'px';
    img.style.height = 'auto';

    /* Update labels */
    const pct = Math.round(scale * 100) + '%';
    zPct.textContent   = pct;
    zBadge.textContent = pct;

    /* Show scroll badge when image bigger than viewport */
    const overflows = (naturalW * scale > vp.clientWidth) ||
                      (naturalH * scale > vp.clientHeight);
    scrollBadge.textContent = overflows ? '↕ Scroll to explore' : '';
    scrollBadge.classList.toggle('visible', overflows);
  }

  /* Fit image to the visible viewport with 40px padding */
  function fit() {
    if (!loaded) return;
    const availW = vp.clientWidth  - 40;
    const availH = vp.clientHeight - 40;
    const s = Math.min(availW / naturalW, availH / naturalH, 1);
    /* Scroll to top-left then apply scale */
    vp.scrollTo(0, 0);
    applyScale(s);
  }

  /* ── Image load success ── */
  img.addEventListener('load', function () {
    naturalW = img.naturalWidth;
    naturalH = img.naturalHeight;
    loaded   = true;
    imgError.classList.remove('visible');
    img.style.display = 'block';
    fit();
  });

  /* ── Image load failure ── */
  img.addEventListener('error', function () {
    img.style.display = 'none';
    imgError.classList.add('visible');
    zPct.textContent   = 'N/A';
    zBadge.textContent = 'No image';
  });

  /* Already cached and loaded? */
  if (img.complete) {
    if (img.naturalWidth > 0) {
      img.dispatchEvent(new Event('load'));
    } else {
      img.dispatchEvent(new Event('error'));
    }
  }

  /* ══════════════════════════════════════════════════════
     SCROLL WHEEL
     - Normal scroll  → vertical pan (browser default)
     - Shift + scroll → horizontal pan (browser default with shift)
     - Ctrl + scroll  → zoom (we intercept this only)
  ══════════════════════════════════════════════════════ */
  vp.addEventListener('wheel', function (e) {
    if (!e.ctrlKey && !e.metaKey) return; /* let normal scroll pass through */
    e.preventDefault();
    const delta  = e.deltaY > 0 ? -0.08 : 0.08;
    applyScale(scale + delta);
  }, { passive: false });

  /* ══════════════════════════════════════════════════════
     TOUCH — PINCH TO ZOOM
  ══════════════════════════════════════════════════════ */
  let lastPinchDist = 0;

  vp.addEventListener('touchstart', function (e) {
    if (e.touches.length === 2) {
      lastPinchDist = Math.hypot(
        e.touches[1].clientX - e.touches[0].clientX,
        e.touches[1].clientY - e.touches[0].clientY
      );
    }
  }, { passive: true });

  vp.addEventListener('touchmove', function (e) {
    if (e.touches.length !== 2) return;
    e.preventDefault();
    const d = Math.hypot(
      e.touches[1].clientX - e.touches[0].clientX,
      e.touches[1].clientY - e.touches[0].clientY
    );
    applyScale(scale * (d / lastPinchDist));
    lastPinchDist = d;
  }, { passive: false });

  /* ══════════════════════════════════════════════════════
     BUTTON CONTROLS
  ══════════════════════════════════════════════════════ */
  btnIn .addEventListener('click', function () { applyScale(scale + STEP); });
  btnOut.addEventListener('click', function () { applyScale(scale - STEP); });
  btn50 .addEventListener('click', function () { applyScale(0.5); });
  btn100.addEventListener('click', function () { applyScale(1.0); });
  btn200.addEventListener('click', function () { applyScale(2.0); });
  btnFit.addEventListener('click', fit);

  /* Click image → zoom in one preset step; Ctrl+click → zoom out */
  img.addEventListener('click', function (e) {
    if (!loaded) return;
    if (e.ctrlKey || e.metaKey) {
      applyScale(scale - STEP);
    } else {
      /* Find next preset above current scale */
      const next = PRESETS.find(function(p){ return p > scale + 0.01; });
      applyScale(next || scale + STEP);
    }
  });

  /* ══════════════════════════════════════════════════════
     KEYBOARD SHORTCUTS
  ══════════════════════════════════════════════════════ */
  document.addEventListener('keydown', function (e) {
    if (['INPUT','TEXTAREA','SELECT'].includes(e.target.tagName)) return;
    switch (e.key) {
      case '+': case '=': e.preventDefault(); applyScale(scale + STEP); break;
      case '-': case '_': e.preventDefault(); applyScale(scale - STEP); break;
      case '0': case 'f': case 'F': e.preventDefault(); fit(); break;
      case '1': e.preventDefault(); applyScale(1.0); break;
      case '2': e.preventDefault(); applyScale(2.0); break;
      case '5': e.preventDefault(); applyScale(0.5); break;
    }
  });

  /* ══════════════════════════════════════════════════════
     FULLSCREEN
  ══════════════════════════════════════════════════════ */
  btnFS.addEventListener('click', function () {
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen().catch(function(){});
    } else {
      document.exitFullscreen().catch(function(){});
    }
  });
  document.addEventListener('fullscreenchange', function () {
    const fs = !!document.fullscreenElement;
    fsExp .style.display = fs ? 'none' : '';
    fsColl.style.display = fs ? ''     : 'none';
    setTimeout(fit, 200);
  });

  /* ── Resize → refit ── */
  window.addEventListener('resize', fit);

})();
</script>
</body>
</html>
