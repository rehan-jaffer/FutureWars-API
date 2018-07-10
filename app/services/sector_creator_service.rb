class SectorCreatorService
  prepend SimpleCommand

  def initialize(props = {})
    @props = props
  end

  def call
    Sector.find(@props[:id]).destroy if @props.key?(:id) && Sector.where(id: @props[:id]).count > 0
    defaults = {}
    new_sector = Sector.create(@props.merge(defaults))
    if new_sector.errors.empty?
      return new_sector
    else
      errors.add(:save, new_sector.errors)
      return nil
    end
  end

end
