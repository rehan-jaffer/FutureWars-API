class PortQueryPolicy
  include PolicyObject

  def initialize(port, player)
    @id = id
    @current_sector = current_sector
  end

  private

  def conditions
    [
      ['You are not in that sector! Cannot query port across sectors.', @id.to_i == @current_sector.to_i]
    ]
end
