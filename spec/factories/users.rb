FactoryBot.define do
  factory :user do
    name { "Name #{rand(999)}" }
    last_name { "last name #{rand(999)}" }
    phone { "79999999999" }
    email { "example@gmail.com" }
    age { 20 }
    role { :admin }
    address { "Д.Бедного" }
  end
end