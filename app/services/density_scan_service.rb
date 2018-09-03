class DensityScanService
  prepend SimpleCommand

  def initialize(current_user, sector_id)
    @current_user = current_user
    @sector = Sector.find(sector_id)
  end

  def call
    @policy = DensityScanPolicy.new(@current_user, @sector)
    @policy.allowed? ? handle_success : handle_failure
  end

  def handle_success
      @sector.warps
           .map { |warp| Sector.find(warp) }
           .map { |warp| { id: warp.id, density: warp.density, anom: true } }
  end

  def handle_failure
      errors.add(:errors, policy.error)
  end

end
