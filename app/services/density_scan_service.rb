class DensityScanService
  prepend SimpleCommand

  def initialize(current_user, sector_id)
    @current_user = current_user
    @sector = Sector.find(sector_id)
  end

  def call
    policy = DensityScanPolicy.new(@current_user, @sector)

    unless policy.allowed?
      errors.add(:errors, policy.error)
      return nil
    end

    @sector.warps
           .map { |warp| Sector.find(warp) }
           .map { |warp| { id: warp.id, density: warp.density, anom: true } }
  end
end
