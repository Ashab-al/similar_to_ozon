class Api::Product::UpdateProductInteractor < ActiveInteraction::Base

  integer :category_id, presence: true
  integer :store_id, presence: true
  integer :product_id, optional: true
  string :name, presence: true
  string :description, presence: true


  def execute
    product = Product.find_by(id: product_id)
    return product.update({name: name, description: description}) if product

    errors.add(:params, I18n.t("error.messages.product_not_found"))
  end
end