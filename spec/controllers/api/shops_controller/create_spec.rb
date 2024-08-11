require 'rails_helper'


RSpec.describe Api::ShopsController, type: :controller do 

  let! (:user) { create(:user) }
  let (:name) { "Name #{rand(999)}" }
  let (:description) { "description #{rand(999)}" }
  let (:not_existing_user) { rand(5..100) }
  let (:user_nil) { nil }
  let (:name_nil) { nil }
  let (:description_nil) { nil }
  let (:params) {{ :store => { :user_id => user.id, :name => name, :description => description } }}
  before (:each) { post :create, params: params }

  context "Success" do
    it "store was successfully created" do 
      expect(response).to have_http_status(:ok)
    end

    it "required name is returned" do 
      expect(JSON.parse(response.body)["shop"]["name"]).to eq(name)
    end 

    it "required description is returned" do 
      expect(JSON.parse(response.body)["shop"]["description"]).to eq(description)
    end 

    it "required user_id is returned" do 
      expect(JSON.parse(response.body)["shop"]["user_id"]).to eq(user.id)
    end 
  end

  context "Failure" do
    context "emtpy params" do 
      let (:params) {{ :store => nil }}

      it "empty parameters for create (https status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "empty parameters for create (error message)" do 
        expect(JSON.parse(response.body)["message"]).to eq(I18n.t("error.messages.not_validated_params"))
      end
    end
    
    context "incorrect parametr user.id" do 
      let (:params) {{ :store => { :user_id => not_existing_user, :name => name, :description => description } }}

      it "passed incorrect user_id params (http status)" do         
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "passed incorrect user_id params (error message)" do
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.invalid"))
      end
    end
    
    context "nil parametr user.id" do 
      let (:params) {{ :store => { :user_id => user_nil, :name => name, :description => description } }}

      it "passed nil user_id params (http status)" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "passed nil user_id params (error message)" do
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.missing"))
      end
    end
    
    context "nil parametr name" do 
      let (:params) {{ :store => { :user_id => user.id, :name => name_nil, :description => description } }}

      it "passed nil name params (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "passed nil name params (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.store_not_create"))
      end
    end
    
    context "nil parametr description" do 
      let (:params) {{ :store => { :user_id => user.id, :name => name, :description => description_nil } }}

      it "passed nil description params (http status)" do 
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "passed nil description params (error message)" do 
        expect(JSON.parse(response.body)["message"].first["name"]).to eq(I18n.t("error.messages.store_not_create"))
      end
    end
  end
end