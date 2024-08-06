FactoryBot.define do
  factory :product do
    name { "Name #{rand(999)}" }
    description { "last name #{rand(999)}" }
  end
end