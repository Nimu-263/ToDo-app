function month() {
  const button_month_week = document.getElementById("button_month_week");
  const calendar = document.getElementById("calendar");
  button_month_week.addEventListener("click", (e) => {
    if (calendar.getAttribute("style") == "display: none;") {
      calendar.removeAttribute("style", "display: none;");
    }else{
      calendar.setAttribute("style", "display: none;");
    }
  })
}
window.addEventListener("load", month);

