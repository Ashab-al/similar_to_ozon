require 'rails_helper'


RSpec.describe Api::ShopsController, type: :controller do 
  let! (:user) { create(:user) }
  let! (:category) { create(:category) }
  let! (:store_1) { create(:store, user: user) }
  let! (:store_2) { create(:store, user: user) }
  let! (:store_3) { create(:store, user: user) }

  let! (:products_1) { create_list(:product, 5, store: store_1, category: category) }
  let! (:products_2) { create_list(:product, 10, store: store_2, category: category) }
  let! (:products_3) { create_list(:product, 15, store: store_3, category: category) }

  let (:greater_than) { rand(5...10) }
  let (:less_than) { rand(1...4) }
  let (:less_than_more_greater_than) { rand(11...15) }
  let (:incorrect_parametr) { "aasdadasd" }

  
  context "Success" do 
    it "passing the asc_or_desc parameter http status answer" do 
      get :index, params: { :sort_store => {:asc_or_desc => 'DESC'} }

      expect(response).to have_http_status(:ok)
    end
    it "passing the asc_or_desc parameter (json answer)" do 
      get :index, params: { :sort_store => { :asc_or_desc => 'DESC' } }

      expect(JSON.parse(response.body)["shops"]).to eq(JSON.parse(Store.with_product_count.order(products_count: :desc).to_json))
    end

    it "passing the parameter greater_than (https status answer)" do 
      get :index, params: { :sort_store => { :greater_than => greater_than } }

      expect(response).to have_http_status(:ok)
    end
    it "passing the parameter greater_than (json answer)" do 
      get :index, params: { :sort_store => { :greater_than => greater_than } }

      expect(JSON.parse(response.body)["shops"]).to eq(JSON.parse(Store.greater_than_products(greater_than).to_json))
    end

    it "passing the parameter less_than (https status answer)" do 
      get :index, params: { :sort_store => { :less_than => less_than } }

      expect(response).to have_http_status(:ok)
    end
    it "passing the parameter less_than (json answer)" do 
      get :index, params: { :sort_store => { :less_than => less_than } }

      expect(JSON.parse(response.body)["shops"]).to eq(JSON.parse(Store.less_than_products(less_than).to_json))
    end

    it "passing the parameter greater_than and less_than (https status answer)" do 
      get :index, params: { :sort_store => { :greater_than => greater_than, :less_than => less_than } }

      expect(response).to have_http_status(:ok)
    end
    it "passing the parameter greater_than and less_than (json answer)" do 
      get :index, params: { :sort_store => { :greater_than => greater_than, :less_than => less_than } }

      expect(JSON.parse(response.body)["shops"]).to eq(JSON.parse(Store.less_and_greater_than_products(less_than, greater_than).to_json))
    end
  end
  
  context "Failure" do
    it "empty parameters for index" do 
      expect{ get :index }.to raise_error(ActionController::ParameterMissing)
    end

    it "less_than is more than greater_than" do 
      get :index, params: {:sort_store => { :less_than => less_than_more_greater_than, :greater_than => greater_than } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "incorrect parameter was passed asc_or_desc" do 
      get :index, params: { :sort_store => { :greater_than => incorrect_parametr } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "incorrect parameter was passed less_than" do 
      get :index, params: { :sort_store => { :less_than => incorrect_parametr } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "incorrect parameter was passed greater_than" do 
      get :index, params: { :sort_store => { :greater_than => incorrect_parametr } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    context "passing the wrong greater_than and less_than" do 
      it "passing greater_than and less_than, but greater_than is incorrect" do 
        get :index, params: { :sort_store => { :less_than => less_than, :greater_than => incorrect_parametr } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "passing greater_than and less_than, but less_than is incorrect" do 
        get :index, params: { :sort_store => { :less_than => incorrect_parametr, :greater_than => greater_than } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "passing greater_than and less_than, but both are wrong" do 
        get :index, params: { :sort_store => { :less_than => incorrect_parametr, :greater_than => incorrect_parametr } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end