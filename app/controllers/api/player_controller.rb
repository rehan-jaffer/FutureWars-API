class Api::PlayerController < ApplicationController
  def stats
    render json: current_user
  end

  def status
    render json: { status: 'idling' }
  end

  def move
    result = MovePlayerService.call(current_user.id, player_params[:id].to_i)
    if result.success?
      render json: SectorView.render(Sector.find(current_user.current_sector))
    else
      render json: result.errors, status: :forbidden
    end
  end

  private

  def player_params
    params.permit(:id)
  end
end
