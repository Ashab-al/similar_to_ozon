FactoryBot.define do
  factory :category do
    title { "Title Category #{rand(999)}" }
    description { "Description Category #{rand(999)}" }
  end
end