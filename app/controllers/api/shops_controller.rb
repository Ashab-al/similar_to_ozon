class Api::ShopsController < ApplicationController

  def index

  end

  def show

  end

  def categories
    render json: Category.all
  end

  def products
    render json: Product.all
  end
end
