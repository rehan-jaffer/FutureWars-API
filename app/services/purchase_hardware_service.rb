class PurchaseHardwareService

  def initialize(user_id, _item)
    @player = Player.where(id: user_id).first
    @items = ['density_scanner']
    @item = item
  end

  def call
    @policy = PurchaseHardwarePolicy.new(@player, @item, @items)
    @policy.allowed? ? handle_success : handle_failure
  end

  private

    def handle_success
      @player.primary_ship.equip(item)
    end

    def handle_failure

    end

end
