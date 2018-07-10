require './lib/views/port_trade_view'
require './lib/views/special_port_trade_view'

class PortQueryService
  prepend SimpleCommand

  def initialize(id, current_sector)
    @id = id
    @current_sector = current_sector
    # @user = user
  end

  def call
    errors.add(:errors, 'You are not in that sector! Cannot query port across sectors.') unless @id.to_i == @current_sector.to_i
    errors.add(:errors, 'No user supplied!') unless @id
    return nil unless errors.empty?

    sector = Sector.find(@id)

    return SpecialPortTradeView.render(sector.attributes) if sector.port_class == 0
    PortTradeView.render(sector.attributes)
  end
end
