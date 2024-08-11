class Api::Store::CreateStoreInteractor < ActiveInteraction::Base

  integer :user_id, presence: true
  string :name, presence: true
  string :description, presence: true


  def execute
    user = User.find_by(id: user_id )
    return errors.add(:user, :invalid) unless user 

    store = user.stores.build(name: name, description: description)

    return errors.add(:params, I18n.t("error.messages.store_not_create")) unless store.save

    store
  end
end