function getSiteHeader() {
  var siteHeaderMenu = "site-header-menu";
  var el = document.getElementById(siteHeaderMenu);
  if (!el) {
    throw "Couldn't find header!";
  }

  return el;
}

function toggleMenu() {
  var siteHeader = getSiteHeader();
  var siteHeaderDisplay = siteHeader.style.display;
  if (siteHeaderDisplay !== "block") {
    siteHeader.setAttribute("style", "display: block");
  } else {
    siteHeader.setAttribute("style", "display: none");
  }
}

