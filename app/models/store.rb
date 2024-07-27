class Store < ApplicationRecord
  belongs_to :user
  has_many :products

  scope :greater_than_products, ->(count) {
    joins(:products)
     .group('stores.id')
     .having('COUNT(products.id) >= ?', count)
  }

  scope :less_than_products, ->(count) {
    joins(:products)
     .group('stores.id')
     .having('COUNT(products.id) <= ?', count)
    end
  }

  scope :less_and_greater_than_products, ->(less_than, greater_than) {
    less_than_products(less_than).merge(greater_than_products(greater_than))
  }
end
