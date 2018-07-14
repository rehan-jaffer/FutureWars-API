class WarpView

  def self.render(attributes)
    return Sector.find(attributes['id']).warps
  end

end
