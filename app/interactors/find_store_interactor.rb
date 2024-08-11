class FindStoreInteractor < ActiveInteraction::Base
  integer :id, presence: true

  def execute
    store = Store.find_by(id: id)
    
    return errors.add(:params, I18n.t("error.messages.could_not_find_the_store")) unless store

    store
  end
end