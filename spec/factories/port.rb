FactoryBot.define do
  factory :port do
    name 'Test Port'
    port_class 1

    ore_productivity 100
    organics_productivity 100
    equipment_productivity 100
    ore_qty 100
    organics_qty 100
    equipment_qty 100

    factory :special_port do
      port_class 0
    end
  end
end
