function getSiteHeader() {
  var siteHeaderMenu = "site-header-menu";
  var arr = document.getElementsByClassName(siteHeaderMenu);
  if (arr.length !== 1) {
    throw new Error("Multiple elements with class '" + siteHeaderMenu + "'!");
  }

  return arr[0];
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

