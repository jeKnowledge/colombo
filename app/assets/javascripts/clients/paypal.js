function render_paypal(create_url, price, description, execute_url, action_url, name) {
  let paypal_api = "https://www.paypalobjects.com/api/checkout.js"
  let script_node = document.createElement("script")
  script_node.src = paypal_api
  script_node.onload = function() {
    paypal.Button.render({
      env: 'sandbox',
      commit: true,
      style: {
        label: 'checkout',  // horizontal | vertical
        size:   'responsive',    // medium | large | responsive
        shape:  'rect',      // pill | rect
        color:  'black'       // gold | blue | silver | black
      },
      payment: (data, actions) => {
        var data = {
          items: [{
            name,
            price,
            currency: "USD",
            quantity: "1"
          }],
          total_amount: price,
          description
        }

        return actions.request.post(create_url, {data: JSON.stringify(data)})
          .then((res) => {
            return res.payment_id;
          });
      },
      onAuthorize: (data, actions) => {
        var data = {
          payment_id: data.paymentID,
          payer_id: data.payerID,
        };

        return actions.request.post(execute_url, data)
          .then((res) => {
            if(res.success){
              window.location.replace(action_url);
            }
          });
      }
    }, '#paypal-button-container');
  }

  let head = document.getElementsByTagName("head")[0]
  head.appendChild(script_node)
}