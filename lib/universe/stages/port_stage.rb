class PortStage
  def initialize; end

  def set_size(size)
    @size = size
  end

  def exec
    distributions = [0, 19.99, 19.91]
    sector_list = Sector.all.map(&:id)
  end
end
