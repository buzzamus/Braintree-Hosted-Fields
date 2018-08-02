class CustomersController < ApplicationController
  def index
    @customers = gateway.customer.all
  end

  def show
    @customer = gateway.customer.find(params[:id])
  end
end
