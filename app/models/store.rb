class Store < ApplicationRecord
  belongs_to :user
  has_many :products
  
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :description, presence: true, length: { minimum: 2, maximum: 5000 }


  scope :with_product_count, -> {
    left_joins(:products)
    .select('stores.*, COUNT(products.id) AS products_count')
    .group('stores.id')
  }

  scope :greater_than_products, ->(count) {
    with_product_count.having('COUNT(products.id) >= ?', count)
  }

  scope :less_than_products, ->(count) {
    with_product_count.having('COUNT(products.id) <= ?', count)
  }

  scope :less_and_greater_than_products, ->(less_than, greater_than) {
    with_product_count.having('COUNT(products.id) <= ? AND COUNT(products.id) >= ?', less_than, greater_than)
  }
end
