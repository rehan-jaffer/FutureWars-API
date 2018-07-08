require './lib/views/port_trade_view'

class PortQueryService
  prepend SimpleCommand

  def initialize(id)
    @id = id
    # @user = user
  end

  def call
    unless @id
      errors.add(:auth, 'No user supplied!')
      return nil
    end
    PortTradeView.render(Sector.find(@id).attributes)
  end
end
