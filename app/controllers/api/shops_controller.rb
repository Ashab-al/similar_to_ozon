class Api::ShopsController < ApplicationController

  def index

  end

  def show

  end

  def create
    render json: Product.all
  end

  def categories
    render json: Category.find_by(params[:id])
  end

end
