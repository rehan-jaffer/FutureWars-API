class PurchaseHardwareService

  def initialize(user_id, item)
    @player = Player.where(id: user_id).first
    @items = ["density_scanner"]
  end

  def validates?
    errors.add(:errors, "Hardware item not found") unless @items.include?(item)
    errors.add(:errors, "Your ship does not support that item") unless @player.primary_ship.can_equip?(item)
    errors.add(:errors, "You already have that item") unless @player.primary_ship.has_hardware?(item)
  end

  def call
    return nil unless validates?
    @player.primary_ship.equip(item)
  end

end
