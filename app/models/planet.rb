require 'pp'

class Planet < ApplicationRecord

  has_many :moons, dependent: :destroy
  belongs_to :planet_type
  belongs_to :sector

  validates :sector_id, presence: true

  include Mixins::Planet::Colonists
  include Mixins::Planet::Products

  after_create :create_moons

  def create_moons
    0.upto(rand(8)) do |n|
      Moon.create(planet_id: id, name: "M-" + rand(999).round().to_s)
    end
  end

  def update_planet_products

    commodities = Hash.new(0)

    Port.commodities.each do |commodity|
      commodities[commodity] = attributes[commodity] + estimated_hourly_product(commodity)
    end

    update(commodities)

  end

end
