class Api::Store::CreateStoreInteractor
  include Interactor

  def call
    user = search_user(context.user_id)

    store = user.stores.build(context.name, context.description)
    if store.save
      context.store = store
    else 
      context.fail!(errors: store.errors)
    end
  end

  def search_user(user_id)
    user = User.find_by(user_id)
    if user.nil?
      context.fail!(errors: {user: "not found"})
    end

    user
  end
end