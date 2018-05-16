class CheckoutsController < ApplicationController

  def new
    @client_token = gateway.client_token.generate
  end

  def create
    @result = gateway.transaction.sale(
      amount: "50.43",
      payment_method_nonce: params["payment_method_nonce"],
      options: {
        submit_for_settlement: true
      }
    )
  end

  def gateway
    @gateway = Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV["MERCHANT_ID"],
      public_key: ENV["PUBLIC_KEY"],
      private_key: ENV["PRIVATE_KEY"],
    )
  end

end
