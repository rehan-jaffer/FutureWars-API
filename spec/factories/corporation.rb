FactoryBot.define do
  factory :corporation do
    sequence :name do |n|
     "Corporation Name #{n}"
    end
    ceo_id 10
    creator_id 0
  end
end
