FactoryBot.define do
  factory :player do
    sequence :username do |n|
      "ray#{n}"
    end
    password 'testpassword'
    ship_name 'USS Enterprise'
    email "user@domain.com"
    turns 300
    alignment 0
    current_sector 1    
    after(:create) do |player|
      create(:default_ship, player_id: player.id)
    end
  end
end
