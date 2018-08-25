class Api::Subspace::CorporationController < ApplicationRecord
  def join
    result = JoinCorporationService.call(current_user.id, join_corp_params[:id])
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  def create
    result = CreateCorporationService.call(current_user.id, corporation_params[:name])
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  def leave
    result = LeaveCorporationService.call(current_user.id, leave_corp_params[:id])
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  private

  def join_corp_params
    params.permit(:id)
  end

  def corporation_params
    params.require(:corporation).permit(:name)
  end
end
