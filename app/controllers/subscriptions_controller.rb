class SubscriptionsController < ApplicationController

  def new
    @client_token = gateway.client_token.generate
  end

  def create
    @customer = gateway.customer.create(
      first_name: "John",
      last_name: "#{rand(0..2000)}",
      payment_method_nonce: params["payment_method_nonce"]
    )
    if @customer.success?
      @result = gateway.subscription.create(
        payment_method_token: @customer.customer.payment_methods[0].token,
        plan_id: "Buzz01"
      )
      if @result.success?
        redirect_to subscription_path(@result.subscription.id)
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
    @subscription = gateway.subscription.find(params[:id])
  end

  def gateway
    @gateway = Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV["MERCHANT_ID"],
      public_key: ENV["PUBLIC_KEY"],
      private_key: ENV["PRIVATE_KEY"]
    )
  end
end
