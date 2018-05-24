class CheckoutsController < ApplicationController
  before_action :gateway

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
    if @result.success?
      redirect_to checkout_path(@result.transaction.id)
    else
      render 'new'
    end
  end

  def show
    @transaction = gateway.transaction.find(params[:id])
  end
end
