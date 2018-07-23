  
  FactoryBot.define do
    factory :player do
      username 'testusername'
    ship_name 'USS Enterprise'
    turns 300
    ship_type_id 1
  end
  factory :default_player do
    username 'defaultplayer'
    ship_name 'USS Enterprise'
    turns 300
  end
end