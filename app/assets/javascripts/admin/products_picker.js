document.addEventListener('turbolinks:load', function() {
  var body = document.getElementsByTagName("body")[0]
  if (body.id == "audits_plan" || body.id == "audits_plan_send") {
    $("#plan_products").tokenfield({ delimiter: ';' });
  }

  if (body.id == "audits_report" || body.id == "audits_report_send") {
    $("#report_products").tokenfield({ delimiter: ';' });
  }
})