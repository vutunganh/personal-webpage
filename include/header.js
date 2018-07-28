$("#main-menu-button").click(function () {
  if ($(".site-header-menu").css("display") === "none") {
    $(".site-header-menu").css("display", "block");
  } else {
    $(".site-header-menu").css("display", "none");
  }
});

