class Api::ShipsController < ApplicationController
  def index
    render json: ShipType.all
  end
end
