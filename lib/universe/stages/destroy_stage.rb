class DestroyStage
  def initialize; end

  def set_size(size); end

  def exec
    Warp.destroy_all
    Sector.destroy_all
    Port.destroy_all
  end
end
