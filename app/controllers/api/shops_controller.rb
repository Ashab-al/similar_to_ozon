class Api::ShopsController < ApplicationController

  def index
    result_sort_store = Api::Store::Index::SortStoreInteractor.execute(sort_params)
    
    if result_sort_store
      render json: result_sort_store, status: :ok
    else
      render json: result_sort_store.errors, status: :unprocessable_entity
    end
  end

  def show

  end

  def create
    result_create_store = Api::Store::CreateStoreInteractor.call(store_params)
    if result_create_store.success?
      render json: result_create_store.store, status: :created
    else
      render json: {errors: result_create_store.errors}, status: :unprocessable_entity
    end
  end

  def categories
    render json: Category.find_by(params[:id])
  end

  private

  def store_params
    params.require(:store).permit(:user_id, :name, :description)
  end

  def sort_params
    params.permit(:sort_store).permit(:less_than, :greater_than, :asc_or_desc)
  end
end
