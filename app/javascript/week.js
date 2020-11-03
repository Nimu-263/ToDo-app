function week() {
  const button_month_week = document.getElementById("button_month_week");
  const week_plans = document.getElementById("week_plans");
  button_month_week.addEventListener("click", (e) => {
    if (week_plans.getAttribute("style") == "display: none;") {
      week_plans.removeAttribute("style", "display: none;");
    }else{
      week_plans.setAttribute("style", "display: none;");
    }
  })
}
window.addEventListener("load", week);