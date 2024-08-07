class Api::Store::SearchCategoryInteractor < ActiveInteraction::Base
  integer :id, presence: true

  def execute
    category = Category.find_by(id: id)
    
    return category if category
    errors.add(:params, "ПОМЕНЯТЬ")
  end
end