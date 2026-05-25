<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<%--
  PlatformArchitecture.jsp
  ────────────────────────────────────────────────────────────────
  Injected into BotViewerTemplate's content area.
  Outputs only a full-bleed iframe — no duplicate nav or toolbar.

  /arch-diagram is served by LoadArchitectureDiagram.java which
  streams architecture-sketche.html directly from WEB-INF.
  That file owns the zoom toolbar, hint bar, viewport and all JS.

  Centering: once the iframe finishes loading we dispatch a resize
  event inside it so the HTML's fit() function recalculates against
  the correct iframe dimensions and re-centers the diagram.
  ────────────────────────────────────────────────────────────────
--%>
<style>
  /* Strip any margin/padding the template may inject */
  html, body {
    margin:  0;
    padding: 0;
    overflow: hidden;
    background: #0d1117;
  }

  /* Wrapper centres the iframe both axes */
  .arch-wrap {
    display:         flex;
    align-items:     center;
    justify-content: center;
    width:  100%;
    height: calc(100vh - 52px); /* subtract BotViewerTemplate nav height */
    overflow: hidden;
    background: #0d1117;
  }

  .arch-frame {
    display: block;
    width:   100%;
    height:  100%;
    border:  none;
    background: #0d1117;
  }
</style>

<div class="arch-wrap">
  <iframe
    class="arch-frame"
    id="archFrame"
    src="<%= ctx %>/arch-diagram"
    title="AIonifier Platform Architecture Diagram"
    allowfullscreen>
  </iframe>
</div>

<script>
(function () {
  "use strict";
  var frame = document.getElementById('archFrame');

  /*
   * Once the iframe document is ready, dispatch a resize event inside it.
   * This causes the HTML's fit() function to recalculate the diagram scale
   * against the actual rendered iframe dimensions, centering the diagram
   * correctly regardless of when the template finishes painting.
   */
  frame.addEventListener('load', function () {
    try {
      var iwin = frame.contentWindow;
      if (iwin) {
        iwin.dispatchEvent(new Event('resize'));
      }
    } catch (e) {
      /* cross-origin guard — safe to ignore if origin differs */
    }
  });
})();
</script>
