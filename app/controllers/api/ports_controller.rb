require './lib/views/port_trade_view'

class Api::PortsController < ApplicationController
  def query
    result = PortQueryService.call(port_params[:id], current_user.current_sector)
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  def order
    result = TradeWithPortService.call(trade_params[:commodity], trade_params[:qty], trade_params[:price])
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  private

  def port_params
    params.permit(:id)
  end
end
