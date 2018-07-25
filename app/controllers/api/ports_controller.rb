require './lib/views/port_trade_view'

class Api::PortsController < ApplicationController
  def query
    result = PortQueryService.call(port_params[:id], current_user)
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  def trade
    result = TradeWithPortService.call(current_user.id, {commodity: trade_params[:commodity], qty: trade_params[:qty], trade_type: trade_params[:trade_type]})
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  private

  def trade_params
    params.permit(:id, :commodity, :qty, :trade_type)
  end

  def port_params
    params.permit(:id)
  end
end
