class Api::TransactionsController < ApplicationController
  def offer
    result = ConsiderOfferService.call(current_user, offer_params[:id], offer_params[:amount])
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  def offer_params
    params.permit(:id, :amount)
  end
end
