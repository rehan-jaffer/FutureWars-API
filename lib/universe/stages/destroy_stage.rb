class DestroyStage
  def initialize; 
    @objects = [Warp, Sector, Port]
  end

  def set_size(size); end

  def exec
    @objects.each do |object|
      object.destroy_all
    end
  end
end
