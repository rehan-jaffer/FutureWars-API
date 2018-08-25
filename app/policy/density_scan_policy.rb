require './lib/mixins/policy_object'

class DensityScanPolicy

  include PolicyObject

  def initialize(user, sector)
    @user = user
    @sector = sector
  end

  private

  def conditions
    [
      ["You don't have a density scanner", @user.primary_ship.has_equip?(:density_scanner)],
      ['You are not in that sector', @user.current_sector == @sector.id]
    ]
  end
end
