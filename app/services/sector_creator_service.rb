class SectorCreatorService
  prepend SimpleCommand

  def initialize(props = {})
    @props = props
    @defaults = {}
  end

  def call
    Sector.find(@props['id']).destroy if @props.key?('id') && Sector.where(id: @props['id']).count > 0

    new_sector = Sector.create(@props.merge(@defaults))

    return new_sector if new_sector.errors.empty?
    errors.add(:save, new_sector.errors)
    nil
  end
end
