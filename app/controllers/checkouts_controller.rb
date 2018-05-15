class CheckoutsController < ApplicationController

  def new
    @client_token = gateway.client_token.generate()
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

end
