class ProductsController < ApplicationController

	def index
    
	end

	def show
    begin
      outcome = Product::SearchProductInteractor.run(params)

      return render json: {success: false, message: errors_converter(outcome.errors) }, status: :unprocessable_entity if outcome.errors.present?
      render json: {success: true, product: outcome.result }, status: :ok

    rescue ActionController::UrlGenerationError
      return render json: {success: false, message: I18n.t("error.messages.not_validated_params") }, status: :unprocessable_entity
    end
	end

	def create
    begin
      outcome = Product::CreateProductInteractor.run(product_params)

      return render json: {success: false, message: errors_converter(outcome.errors) }, status: :unprocessable_entity if outcome.errors.present?
      render json: {success: true, product: outcome.result }, status: :ok
    rescue ActionController::ParameterMissing
      return render json: {success: false, message: I18n.t("error.messages.not_validated_params") }, status: :unprocessable_entity
    end
	end

	def product_params 
		params.require(:product_create).permit(:name, :description, :category_id, :store_id, :product_id)
	end
end