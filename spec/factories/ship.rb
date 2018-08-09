FactoryBot.define do
  factory :default_ship, class: Ship do
    name 'Merchant Cruiser'
    primary true
    ship_type_id 1
  end
end
