class Store < ApplicationRecord
  belongs_to :user
  has_many :products

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
