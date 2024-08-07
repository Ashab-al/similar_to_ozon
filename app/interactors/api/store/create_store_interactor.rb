class Api::Store::CreateStoreInteractor < ActiveInteraction::Base

  integer :user_id, presence: true
  string :name, presence: true
  string :description, presence: true


  def execute
    user = User.find_by(id: user_id )
    return errors.add(:user, :invalid) unless user 

    store = user.stores.build(name: name, description: description)

    return store if store.save

    errors.add(:params, "ПОМЕНЯТЬ ТУТ")
  end
end