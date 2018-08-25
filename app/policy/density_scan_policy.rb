class DensityScanPolicy
  def initialize(user, sector)
    @user = user
    @sector = sector
  end

  def allowed?
    conditions.all? { |c| c[1] }
  end

  def error
    conditions.find { |c| !c[1] }[0]
  end

  private

  def conditions
    [
      ["You don't have a density scanner", @user.primary_ship.has_equip?(:density_scanner)],
      ['You are not in that sector', @user.current_sector == @sector.id]
    ]
  end
end
