class Api::Product::SearchProductInteractor < ActiveInteraction::Base
  integer :id, presence: true

  def execute
    product = Product.find_by(id: id)
    
    return errors.add(:params, I18n.t("error.messages.product_not_found")) unless product

    product
  end
end