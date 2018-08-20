require 'pp'

class Planet < ApplicationRecord

  belongs_to :planet_type
  belongs_to :sector

  validates :sector_id, presence: true

  include Mixins::Planet::Colonists
  include Mixins::Planet::Products

  def update_planet_products

    commodities = Hash.new(0)

    Port.commodities.each do |commodity|
      commodities[commodity] = attributes[commodity] + estimated_hourly_product(commodity)
    end

    update(commodities)

  end

end
