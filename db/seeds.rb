# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

rand_num = rand(1000)
user = User.create!(
    name: "Пользователь #{rand_num}", 
    last_name: "Фамилия",
    phone: "7 999 999 99 99",
    email: "example@mail.com",
    age: 20,
    password: "admin123"
)

user.stores.create!(
    name: "Магазин #{rand_num}",
    description: "Описание магазина"
)

category = Category.create!(
    title: "Категория №#{rand_num}",
    description: "Описание категории"
)


store = user.stores.last

store.products.create!(
    name: "Продукт #{rand_num}",
    description: "Описание",
    category: category
)