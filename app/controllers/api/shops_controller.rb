class Api::ShopsController < ApplicationController

  def index
    result_sort_store = Api::Store::Index::SortStoreInteractor.run(sort_params)
    unless result_sort_store.errors
      render json: result_sort_store.result, status: :ok
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
    params
  end
end
