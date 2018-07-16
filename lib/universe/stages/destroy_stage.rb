class DestroyStage
  def initialize
    @objects = [Warp, Sector, Port]
  end

  def set_size(size); end

  def exec
    @objects.each(&:destroy_all)
  end
end
