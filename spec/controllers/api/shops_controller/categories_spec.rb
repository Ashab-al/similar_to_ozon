require 'rails_helper'


RSpec.describe Api::ShopsController, type: :controller do 
  include Devise::Test::ControllerHelpers

  render_views
  include ApiHelper::Request
  
  let! (:user) { create(:user) }
  let! (:category) { create(:category) }
  let (:not_existing_category) { rand(5..100) }
  let (:category_nil) { nil }
  let (:category_str) { "asdasd" }
  let (:negative_number) { rand(-100..-1) }

  let (:params) { { :id => category.id } }

  let (:headers) do
    request.headers.merge!(
    {
      'Authorization' => "Bearer #{jwt_token(user.id.to_s)}"
    })
  end

  before do
    sign_in(user, scope: :user)
  end

  before (:each) { get :categories, params: params }

  context "Success" do
    it "successful finding of the category (http status answer)" do       
      expect(response).to have_http_status(:ok)
    end

    it "successful finding of the category (http status answer)" do 
      expect(JSON.parse(response.body)["category"]).to eq(JSON.parse(category.to_json))
    end
  end

  context "Failure" do 
    context "empty parametr" do 
      let (:params) { nil }

      it "empty parameter for categories (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "empty parameter for categories (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.missing"))
      end
    end
    
    context "nil parameter" do 
      let (:params) { { id: category_nil } }

      it "nil parameter for categories (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "nil parameter for categories (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.missing"))
      end
    end
    
    context "string parameter" do 
      let (:params) { { id: category_str } }

      it "string parameter for categories (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "string parameter for categories (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.invalid_type"))
      end
    end
    
    context "random nubmer parameter" do 
      let (:params) { { id: not_existing_category } }

      it "random number parameter for categories (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "random number parameter for categories (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.category_not_found"))
      end
    end

    context "negative number" do 
      let (:params) { { id: negative_number } }

      it "negative number parameter for categories (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "negative number parameter for categories (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.category_not_found"))
      end
    end
  end
end