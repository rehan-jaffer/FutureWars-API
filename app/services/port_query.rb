require './lib/views/port_trade_view'

class PortQuery

  prepend SimpleCommand

  def initialize(id)
    @id = id
    # @user = user
  end

  def call()
    if !@id
      errors.add(:auth, "No user supplied!")
      return nil
    end
    return PortTradeView.render(Sector.find(@id).attributes)
  end

end
