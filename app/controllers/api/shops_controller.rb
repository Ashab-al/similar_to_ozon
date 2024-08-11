class Api::ShopsController < ApplicationController

  def index
    outcome = Api::Store::SortStoreInteractor.run(sort_params)
    return render json: {success: false, message: errors_converter(outcome.errors) }, status: :unprocessable_entity if outcome.errors.present?
      
    render json: {success: true, shops: outcome.result }, status: :ok
  end

  def show
    begin
      outcome = FindStoreInteractor.run(params)

      return render json: {success: false, message: errors_converter(outcome.errors) }, status: :unprocessable_entity if outcome.errors.present?
      render json: {success: true, shop: outcome.result }, status: :ok

    rescue ActionController::UrlGenerationError
      return render json: {success: false, message: I18n.t("error.messages.not_validated_params") }, status: :unprocessable_entity
    end
  end

  def create
    begin
      outcome = Api::Store::CreateStoreInteractor.run(store_params)

      return render json: {success: false, message: errors_converter(outcome.errors) }, status: :unprocessable_entity if outcome.errors.present?
      render json: {success: true, shop: outcome.result }, status: :ok
    rescue ActionController::ParameterMissing
      return render json: {success: false, message: I18n.t("error.messages.not_validated_params") }, status: :unprocessable_entity
    end
  end

  def categories
    outcome = Api::Store::SearchCategoryInteractor.run(params)
    
    return render json: {success: false, message: errors_converter(outcome.errors) }, status: :unprocessable_entity if outcome.errors.present?
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
