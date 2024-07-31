require 'rails_helper'


RSpec.describe Api::ShopsController, type: :controller do 
  describe "API::Shops" do
    describe "GET index" do 

      it "empty parameters for index" do 
        get :index

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "passing the asc_or_desc parameter" do 

        get :index, params: { :asc_or_desc => 'DESC' }
        expect(response).to have_http_status(:ok)
      end

    end
  end
end