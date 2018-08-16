class PurchaseClassZeroItemsService
  prepend SimpleCommand

  def initialize(user_id, port_id, item, qty)
    @player = Player.where(id: user_id).first
    @port = Port.where(id: port_id)
    @item = item
    @qty = qty
  end

  def validates?
    errors.add(:errors, "You cannot buy that many") if @qty > @player.class_zero_costs[:items][@item.to_sym][:available]
    errors.add(:errors, "Purchase not understood") unless [:fighters, :holds, :shields].include?(@item.to_sym)
    errors.empty?
  end

  def call
    return nil unless validates?
    
    cost = @qty * @player.class_zero_costs[:items][@item.to_sym][:cost]
    @player.credits = @player.credits - cost
    ship = @player.primary_ship
    case @item.to_sym
      when :fighters
        ship.fighters += @qty
      when :shields
        ship.shields += @qty
      when :holds
        ship.holds += @qty
    end
    ship.save && @player.save
    ship
  end
end
