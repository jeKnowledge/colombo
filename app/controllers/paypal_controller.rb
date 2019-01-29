require 'json'
require 'paypal-sdk-rest'

class PaypalController < ApplicationController
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging
  skip_before_action :verify_authenticity_token

  def checkout
    parsed_params = JSON.parse(params[:data]).with_indifferent_access
    @payment = Payment.new({
      intent: "sale",
      payer: {
        payment_method: "paypal"
      },
      redirect_urls: {
        return_url: "http://localhost:3000/paypal/execute",
        cancel_url: "http://localhost:3000/"
      },
      transactions: [{
        item_list: {
          items: parsed_params[:items]
        },
        amount: {
          total: parsed_params[:total_amount],
          currency: "USD"
        },
        description: parsed_params[:description] || "This payment has no description."
      }]
    })

    if @payment.create
      render json: {success: true, payment_id: @payment.id}
    else
      render json: {success: false}
    end
  end

  def execute
    payment = Payment.find(params[:payment_id])

    if payment.execute(payer_id: params[:payer_id])
      render json: {success: true, msg: 'Payment Complete'}
    else
      render json: {success: false, msg: payment.error}
    end
  end
end
