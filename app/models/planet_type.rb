class PlanetType < ApplicationRecord
  def self.random_id
    PlanetType.order('RANDOM() DESC').first.id
  end
end
