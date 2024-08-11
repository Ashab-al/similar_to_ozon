class Api::Store::SearchCategoryInteractor < ActiveInteraction::Base
  integer :id, presence: true

  def execute
    category = Category.find_by(id: id)
    
    return errors.add(:params, I18n.t("error.messages.category_not_found")) unless category

    category
  end
end