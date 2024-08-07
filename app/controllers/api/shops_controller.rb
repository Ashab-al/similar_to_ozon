class Api::ShopsController < ApplicationController

  def index
    outcome = Api::Store::SortStoreInteractor.run(sort_params)
    return render json: {success: false, message: 'ПОМЕНЯТЬ' }, status: :unprocessable_entity if outcome.errors.present?
      
    render json: {success: true, shops: outcome.result }, status: :ok
  end

  def show
    outcome = Api::Store::SearchStoreInteractor.run(params)

    return render json: {success: false, message: 'ПОМЕНЯТЬ' }, status: :unprocessable_entity if outcome.errors.present?
    render json: {success: true, shop: outcome.result }, status: :ok
  end

  def create
    outcome = Api::Store::CreateStoreInteractor.run(store_params)

    return render json: {success: false, message: 'ПОМЕНЯТЬ' }, status: :unprocessable_entity if outcome.errors.present?
    render json: {success: true, shop: outcome.result }, status: :ok
  end

  def categories
    outcome = Api::Store::SearchCategoryInteractor.run(params)
    
    return render json: {success: false, message: 'ПОМЕНЯТЬ' }, status: :unprocessable_entity if outcome.errors.present?
    render json: {success: true, category: outcome.result }, status: :ok
  end

  private

  def store_params
    params.require(:store).permit(:user_id, :name, :description)
  end

  def sort_params
    params.require(:sort_store).permit(:asc_or_desc, :greater_than, :less_than)
  end
end
