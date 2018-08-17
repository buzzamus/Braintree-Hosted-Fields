class CardsController < ApplicationController
  before_action :gateway

  def index
  end

  def show
    @card = gateway.credit_card.find(params[:id])
  end

  def edit
    @client_token = gateway.client_token.generate
    @card = gateway.payment_method.find(params[:id])
  end

  def update
    @result = gateway.payment_method.update(@card.token,
      payment_method_nonce: params[:payment_method_nonce],
      :options => {
        verify_card: true
      }
    )
    if @result.success?
      redirect_to card_path(@result.token)
    else
      @error_message = "your Update Request did not go through"
      render 'edit'
    end
  end
end
