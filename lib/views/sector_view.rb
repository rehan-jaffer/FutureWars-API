class SectorView
  def self.render(attributes)
    {
      sector: ['id'],
      port: PortView.render(attributes),
      beacon: BeaconView.render(attributes),
      player: PlayerView.render(attributes),
      warps: Sector.warps(attributes['id'])
    }
  end
end
