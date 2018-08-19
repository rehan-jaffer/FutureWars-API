class Planet < ApplicationRecord

  belongs_to :planet_type

  include Mixins::Planet::Colonists

end
