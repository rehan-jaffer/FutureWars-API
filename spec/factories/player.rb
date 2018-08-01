FactoryBot.define do
  factory :player do
    username 'testusername'
    ship_name 'USS Enterprise'
    turns 300
    ship_type_id 1
    alignment 0
    current_sector 1    
  end
end
