require 'rails_helper'


RSpec.describe Api::ShopsController, type: :controller do 
  
  let! (:user) { create(:user) }
  let! (:store_1) { create(:store, user: user) }

  let (:not_existing_store) { rand(5..100) }
  let (:string_params) { "asdasd" }
  let (:negative_number) { rand(-100..-1) }

  context "Success" do 
    it "successful finding of the store (http status answer)" do 
      get :show, params: { :id => store_1.id }
      
      expect(response).to have_http_status(:ok)
    end

    it "successful finding of the store (json answer)" do 
      get :show, params: { :id => store_1.id }
      
      expect(JSON.parse(response.body)["shop"]).to eq(JSON.parse(store_1.to_json))
    end
  end

  context "Failure" do 
    it "empty parameters for show" do 
      expect{ get :show }.to raise_error(ActionController::UrlGenerationError)
    end

    it "nonexistent parameter was passed" do 
      get :show, params: { :id => not_existing_store }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "nil parameter was passed" do 
      expect{ get :show, params: { :id => nil } }.to raise_error(ActionController::UrlGenerationError)
    end

    it "String parameter was passed" do 
      get :show, params: { :id => string_params }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "negative number parameter was passed" do 
      get :show, params: { :id => negative_number }
      
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end