class Api::PlayerController < ApplicationController
  def stats
    render json: { turns: @current_user.turns }
  end

  def status
    render json: { status: 'idling' }
  end

  def move
    result = MovePlayer.call(current_user.id, origin: dest)
    if result.success?
      render json: SectorView.render(Sector.find(dest))
    else
      render json: errors
    end
  end
end
