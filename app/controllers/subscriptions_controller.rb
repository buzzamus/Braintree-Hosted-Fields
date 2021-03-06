class SubscriptionsController < ApplicationController
  before_action :gateway
  @error_message = " "

  def index
    @subscriptions = gateway.subscription.search do |search|
    search.status.in(
      Braintree::Subscription::Status::Active,
      Braintree::Subscription::Status::Canceled,
      Braintree::Subscription::Status::Expired,
      Braintree::Subscription::Status::PastDue,
      Braintree::Subscription::Status::Pending
    )
    end
  end

  def new
    @client_token = gateway.client_token.generate
  end

  def create
    @customer = gateway.customer.create(
      first_name: params["first_name"],
      last_name: params["last_name"],
      email: params["email"],
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
        @error_message = "your transaction did not go through"
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
    @subscription = gateway.subscription.find(params[:id])
  end
end
