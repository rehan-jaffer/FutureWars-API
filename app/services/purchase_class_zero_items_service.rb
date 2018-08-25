class PurchaseClassZeroItemsService
  prepend SimpleCommand

  def initialize(user_id, port_id, item, qty)
    @player = Player.where(id: user_id).first
    @port = Port.where(id: port_id).first
    @item = item
    @qty = qty
  end

  def validates?
    errors.add(:errors, 'You cannot buy that many') if @qty > @port.class_zero.item_count(@item.to_sym, @player.credits, @player.primary_ship)
    errors.add(:errors, 'Purchase not understood') unless class_zero_items.include?(@item.to_sym)
    errors.empty?
  end

  def call
    return nil unless validates?

    cost = @qty * @port.class_zero.item_cost(@item.to_sym)
    @player.credits = @player.credits - cost
    ship = @player.primary_ship
    case @item.to_sym
    when :fighters
      ship.fighters += @qty
    when :shields
      ship.shields += @qty
    when :holds
      ship.additional_holds += @qty
    end
    ship.save && @player.save
    ship
  end

  private

  def class_zero_items
    %i[fighters holds shields]
  end
end
