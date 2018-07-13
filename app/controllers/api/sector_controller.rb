class Api::SectorController < ApplicationController
  skip_before_action :authenticate_request, only: [:view]

  def current
    render json: Sector.find(current_user.current_sector).view
  end

  def view
    render json: Sector.find(params[:id])
  end
end
