document.addEventListener('turbolinks:load', function() {
  var body = document.getElementsByTagName("body")[0]
  if (body.id == "terms_edit" || body.id == "terms_new") {
    new SimpleMDE({ element: document.getElementById("term_body") })
  }

  if (body.id == "contracts_edit" || body.id == "contracts_new") {
    new SimpleMDE({ element: document.getElementById("contract_body") })
  }
})