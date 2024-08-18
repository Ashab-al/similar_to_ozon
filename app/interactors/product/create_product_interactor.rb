class Product::CreateProductInteractor < ActiveInteraction::Base

  integer :category_id, presence: true
  integer :store_id, presence: true
  integer :product_id, optional: true
  string :name, presence: true
  string :description, presence: true


  def execute
    return update_product if product_id
    
    category = Category.find_by(id: category_id )
    store = Store.find_by(id: store_id)

    return errors.add(:category, :invalid) unless category 
    return errors.add(:store, :invalid) unless store 


    product = Product.create(name: name, description: description, 
                           category_id: category, store_id: store)

    return errors.add(:params, I18n.t("error.messages.store_not_create")) unless product.save

    product
  end

  def update_product
    product = Product.find_by(id: product_id)
    return product.update({name: name, description: description}) if product

    errors.add(:params, I18n.t("error.messages.product_not_found"))
  end
end