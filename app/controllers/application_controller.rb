class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :gateway

  def gateway
    @gateway = Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV["MERCHANT_ID"],
      public_key: ENV["PUBLIC_KEY"],
      private_key: ENV["PRIVATE_KEY"]
    )
  end
end
