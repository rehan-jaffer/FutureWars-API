class WarpView
  def self.render(attributes)
    Sector.find(attributes['id']).warps
  end
end
