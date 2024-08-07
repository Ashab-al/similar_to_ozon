require 'rails_helper'


RSpec.describe Api::ShopsController, type: :controller do 

  let! (:category) { create(:category) }
  let (:not_existing_category) { rand(5..100) }
  let (:category_nil) { nil }
  let (:category_str) { "asdasd" }
  let (:negative_number) { rand(-100..-1) }

  context "Success" do
    it "successful finding of the category (http status answer)" do 
      get :categories, params: { :id => category.id }
      
      expect(response).to have_http_status(:ok)
    end

    it "successful finding of the category (http status answer)" do 
      get :categories, params: { :id => category.id }
      
      expect(JSON.parse(response.body)["category"]).to eq(JSON.parse(category.to_json))
    end
  end

  context "Failure" do 
    it "empty parameters for categories" do 
      get :categories

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "nil parameter for categories" do 
      get :categories, params: { id: category_nil }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "string parameter for categories" do 
      get :categories, params: { id: category_str }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "random number parameter for categories" do 
      get :categories, params: { id: not_existing_category }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "negative number parameter for categories" do 
      get :categories, params: { id: negative_number }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end