require 'rails_helper'


RSpec.describe Api::ShopsController, type: :controller do 
  include Devise::Test::ControllerHelpers
  include ApiHelper::Request
  include Helpers::Responses::Shops

  render_views
  
  
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

  let (:params) { {:sort_store => {:asc_or_desc => 'DESC'}} }

  let (:headers) do
    request.headers.merge!(
    {
      'Authorization' => "Bearer #{jwt_token(user.id.to_s)}"
    })
  end

  before do
    sign_in(user, scope: :user)
  end

  before (:each) { get :index, params: params }

  context "Success" do 

    it "passing the asc_or_desc parameter (http status answer)" do 
      get :index, params: { :sort_store => {:asc_or_desc => 'DESC'} }

      expect(response).to have_http_status(:ok)
    end
    it "passing the asc_or_desc parameter (json answer)" do 
      get :index, params: { :sort_store => { :asc_or_desc => 'DESC' } }
      # binding.pry
      expect(JSON.parse(JSON.parse(response.body)["payload"])).to eq(shops_external_response(Store.with_product_count.order(products_count: :desc)))
    end

    it "passing the parameter greater_than (https status answer)" do 
      get :index, params: { :sort_store => { :greater_than => greater_than } }

      expect(response).to have_http_status(:ok)
    end
    it "passing the parameter greater_than (json answer)" do 
      get :index, params: { :sort_store => { :greater_than => greater_than } }

      expect(JSON.parse(JSON.parse(response.body)["payload"])).to eq(shops_external_response(Store.greater_than_products(greater_than)))
    end

    it "passing the parameter less_than (https status answer)" do 
      get :index, params: { :sort_store => { :less_than => less_than } }

      expect(response).to have_http_status(:ok)
    end
    it "passing the parameter less_than (json answer)" do 
      get :index, params: { :sort_store => { :less_than => less_than } }

      expect(JSON.parse(JSON.parse(response.body)["payload"])).to eq(shops_external_response(Store.less_than_products(less_than)))
    end

    it "passing the parameter greater_than and less_than (https status answer)" do 
      get :index, params: { :sort_store => { :greater_than => greater_than, :less_than => less_than } }

      expect(response).to have_http_status(:ok)
    end
    it "passing the parameter greater_than and less_than (json answer)" do 
      get :index, params: { :sort_store => { :greater_than => greater_than, :less_than => less_than } }

      expect(JSON.parse(JSON.parse(response.body)["payload"])).to eq(shops_external_response(Store.less_and_greater_than_products(less_than, greater_than)))
    end
  end
  
  context "Failure" do
    
    it "empty parameters for index" do 
      # TODO потом поправить
      expect{ get :index }.to raise_error(ActionController::ParameterMissing)
    end
    context "less_than is more than greater_than" do 
      let (:params) { {:sort_store => { :less_than => less_than_more_greater_than, :greater_than => greater_than }} }

      it "less_than > greater_than (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "less_than > greater_than (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.cannot_be_more_gthen"))
      end
    end

    context "incorrect parameter asc_or_desc" do 
      let (:params) { {:sort_store => { :greater_than => incorrect_parametr }} }

      it "incorrect parameter was passed asc_or_desc (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "incorrect parameter was passed asc_or_desc (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.invalid_type"))
      end
    end

    context "incorrect parameter less_than" do 
      let (:params) { {:sort_store => { :less_than => incorrect_parametr }} }

      it "incorrect parameter was passed less_than (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "incorrect parameter was passed less_than (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.invalid_type"))
      end
    end

    context "incorrect parameter greater_than" do 
      let (:params) { {:sort_store => { :greater_than => incorrect_parametr }} }

      it "incorrect parameter was passed greater_than (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "incorrect parameter was passed greater_than (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.invalid_type"))
      end
    end


    context "passing the wrong greater_than and less_than" do 
      context "passing greater_than and less_than, but greater_than is incorrect" do 
        let (:params) { {:sort_store => { :less_than => less_than, :greater_than => incorrect_parametr }} }
        
        it "incorrect parameter greater_than (http status)" do 
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "incorrect parameter greater_than (error message)" do 
          expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.invalid_type"))
        end
      end
      
      context "passing greater_than and less_than, but less_than is incorrect" do
        let (:params) { {:sort_store => { :less_than => incorrect_parametr, :greater_than => greater_than }} }

        it "incorrect parameter less_than (http status)" do 
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "incorrect parameter less_than (error message)" do 
          expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.invalid_type"))
        end
      end
      
      context "passing greater_than and less_than, but both are wrong" do 
        let (:params) { {:sort_store => { :less_than => incorrect_parametr, :greater_than => incorrect_parametr }} }

        it "incorrect parameters less_than and greater_than (http status)" do 
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "incorrect parameters less_than and greater_than (error message)" do 
          expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.invalid_type"))
        end
      end
    end
  end
end