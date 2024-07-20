class Api::ShopsController < ApplicationController

  def index
    result_search_store = Api::Store::Index::SearchStoreInteractor.call({:store_id => params[:id]})
    
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

  def store_params
    params.require(:store).permit(:user_id, :name, :description)
  end

end
