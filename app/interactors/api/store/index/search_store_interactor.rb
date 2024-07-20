class Api::Store::Index::SearchStoreInteractor
  include Interactor
  
  def call(greater_than: nil, less_than: nil, user_sort_method: nil)
    stores = greater_than_method(greater_than)

    stores = less_than_method(less_than)

    stores = sort_method(stores, user_sort_method)

    return false if stores.nil?
    stores
  end

  private 

  def sort_method(stores, user_sort_method)
    if [:the_newest, :the_oldest].include?(user_sort_method)
      if stores.nil?
        stores = sorts_stores(user_sort_method, Store.all)
      else
        stores = sorts_stores(user_sort_method, stores)
      end
    else
      nil
    end
  end

  def sorts_stores(method, stores)
    methods = {
      :the_newest => {created_at: :desc},
      :the_oldest => {created_at: :asc}
    }
    stores.order(methods[method])
  end

  def greater_than_method(greater_than)
    if greater_than.is_a? && greater_than >= 1
      stores = Store.joins(:products).group('stores.id').having('COUNT(products.id) >= ?', greater_than)
      return stores
    end
    nil
  end

  def less_than_method(less_than)
    if less_than.is_a? && less_than >= 1
      stores = Store.joins(:products).group('stores.id').having('COUNT(products.id) >= ?', less_than)
      return stores
    end

    nil
  end
end