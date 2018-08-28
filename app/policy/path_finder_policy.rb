class PathFinderPolicy
  include PolicyObject

  def initialize(dest, path)
    @dest = dest
    @path = path
  end

  def conditions
   [
     ['Destination does not exist!', Sector.exists?(@dest)]
     ['No path exists between these sectors', @path.empty?]
   ]
  end

end