class Api::NavContoller < ApplicationRecord

  def express_warp
  end

  def warp_path
    result = PathFinderService.call(current_user.id, warp_path_params[:id])
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  def warp
    result = MovePlayerService.call(current_user.id, player_params[:id].to_i)
    if result.success?
      render json: Sector.find(current_user.current_sector)
    else
      render json: result.errors, status: :forbidden
    end
  end

  private

    def warp_path_params
      params.permit(:id)
    end

    def warp
      params.permit(:id)
    end

end
