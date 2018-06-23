class Api::PlayerController < ApplicationController
  def stats
    render json: { turns: @current_user.turns }
  end

  def status
    render json: { status: 'idling' }
  end
end
