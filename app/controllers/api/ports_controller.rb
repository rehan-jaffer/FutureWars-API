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

  def trade
    result = TradeWithPortService.call(current_user.id, commodity: trade_params[:commodity], qty: trade_params[:qty], buy_or_sell: trade_params[:buy_or_sell])
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  private

  def trade_params
    params.permit(:id, :commodity, :qty, :buy_or_sell)
  end

  def port_params
    params.permit(:id)
  end
end
