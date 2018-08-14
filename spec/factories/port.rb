FactoryBot.define do
  factory :port do
    name 'Test Port'
    port_class 2
    factory :special_port do
      port_class 0
    end
  end
end
