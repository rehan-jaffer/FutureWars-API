class SectorView
  def self.render(attributes)
    {
      sector: attributes['id'],
      port: PortView.render(attributes),
      beacon: BeaconView.render(attributes),
      players: PlayerView.render(attributes),
      warps: Sector.warps(attributes['id'])
    }
  end
end
