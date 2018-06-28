class Api::SectorController < ApplicationController
  def current
    render json: Sector.find(current_user.current_sector).view
  end
end
