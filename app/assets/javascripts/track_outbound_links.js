function recordOutboundLink(link, category, action) {
  _gat._getTrackerByName()._trackEvent(category, action);
  setTimeout('document.location = "' + link.href + '"', 100);
}