class Api::Store::SearchStoreInteractor < ActiveInteraction::Base
  integer :id, presence: true

  def execute
    store = Store.find_by(id: id)
    
    return store if store
    errors.add(:params, "ПОМЕНЯТЬ")
  end
end