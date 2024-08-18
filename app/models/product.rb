class Product < ApplicationRecord
  belongs_to :category
  belongs_to :store

  validates :name, presence: true, length: { minimum: 2, maximum: 300 }
  validates :description, presence: true, length: { minimum: 2, maximum: 3000 }
end
