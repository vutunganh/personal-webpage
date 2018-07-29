function getSiteHeader() {
  var arr = document.getElementsByClassName("site-header-menu");
  if (arr.length !== 1) {
    throw new Error("Multiple elements with class 'site-header-menu'!");
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

