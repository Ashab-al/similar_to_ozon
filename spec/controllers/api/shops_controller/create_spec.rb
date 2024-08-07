require 'rails_helper'


RSpec.describe Api::ShopsController, type: :controller do 

  let! (:user) { create(:user) }
  let (:name) { "Name #{rand(999)}" }
  let (:description) { "description #{rand(999)}" }
  let (:not_existing_user) { rand(5..100) }
  let (:user_nil) { nil }
  let (:name_nil) { nil }
  let (:description_nil) { nil }


  context "Success" do
    it "store was successfully created" do 
      get :create, params: { :store => { :user_id => user.id, :name => name, :description => description } }

      expect(response).to have_http_status(:ok)
    end

    it "required name is returned" do 
      get :create, params: { :store => { :user_id => user.id, :name => name, :description => description } }

      expect(JSON.parse(response.body)["shop"]["name"]).to eq(name)
    end 

    it "required description is returned" do 
      get :create, params: { :store => { :user_id => user.id, :name => name, :description => description } }

      expect(JSON.parse(response.body)["shop"]["description"]).to eq(description)
    end 

    it "required user_id is returned" do 
      get :create, params: { :store => { :user_id => user.id, :name => name, :description => description } }

      expect(JSON.parse(response.body)["shop"]["user_id"]).to eq(user.id)
    end 
  end

  context "Failure" do
    it "empty parameters for create" do 
      expect{ get :create }.to raise_error(ActionController::ParameterMissing)
    end

    it "passed empty user_id params" do 
      get :create, params: { :store => { :user_id => not_existing_user, :name => name, :description => description } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "passed nil user_id params" do 
      get :create, params: { :store => { :user_id => user_nil, :name => name, :description => description } }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "passed nil name params" do 
      get :create, params: { :store => { :user_id => user_nil, :name => name_nil, :description => description } }
      
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "passed nil description params" do 
      get :create, params: { :store => { :user_id => user_nil, :name => name_nil, :description => description_nil } }
      
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end