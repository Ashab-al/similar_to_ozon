FactoryBot.define do
  factory :store do
    name { "Name #{rand(999)}" }
    description { "last name #{rand(999)}" }
  end
end