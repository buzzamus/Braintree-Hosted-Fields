class CardsController < ApplicationController

  def index

  end

  def show
    @card = gateway.credit_card.find(params[:id])
  end

end
