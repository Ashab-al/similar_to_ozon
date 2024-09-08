require 'rails_helper'


RSpec.describe Api::ShopsController, type: :controller do 
  include Devise::Test::ControllerHelpers
  include ApiHelper::Request
  include Helpers::Responses::Shops
  
  render_views
  

  let! (:user) { create(:user) }
  let! (:store_1) { create(:store, user: user) }

  let (:not_existing_store) { rand(5..100) }
  let (:string_params) { "asdasd" }
  let (:negative_number) { rand(-100..-1) }
  let (:params) { { :id => store_1.id } }
  let (:headers) do
    request.headers.merge!(
    {
      'Authorization' => "Bearer #{jwt_token(user.id.to_s)}"
    })
  end

  before do
    sign_in(user, scope: :user)
  end
  
  before(:each) do
    get :show, params: params
  end

  context "when signed in" do  
    context "Success" do 
      it "successful finding of the store (http status answer)" do 
        get :show, params: params

        expect(response).to have_http_status(:ok)
      end

      it "successful finding of the store (json answer)" do 
        get :show, params: params

        expect(JSON.parse(JSON.parse(response.body)["shop"])).to eq(shop_external_response(store_1))
      end
    end
  end

  context "Failure" do
    context "empty parameters" do 
      it "empty parameters for show" do 
        expect{ get :show }.to raise_error(ActionController::UrlGenerationError)
      end
    end
 
    context "nonexistent parameter" do 
      let (:params) { { :id => not_existing_store } }

      it "nonexistent parameter was passed (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "nonexistent parameter was passed (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.could_not_find_the_store"))
      end
    end

    context "string parameter" do 
      let (:params) { { :id => string_params } }

      it "string parameter was passed (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "string parameter was passed (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.invalid_type"))
      end
    end

    context "negative number" do 
      let (:params) { { :id => negative_number } }

      it "negative number parameter was passed (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "negative number parameter was passed (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.could_not_find_the_store"))
      end
    end
  end
end