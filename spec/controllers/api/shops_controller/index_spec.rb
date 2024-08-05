require 'rails_helper'


RSpec.describe Api::ShopsController, type: :controller do 
  let (:user) { create(:user) }
  let (:category) {create(:category)}

  context "Success" do 
    it "passing the asc_or_desc parameter" do 
      p user.name
      
      get :index, params: { :asc_or_desc => 'DESC' }
      expect(response).to have_http_status(:ok)
    end

    it "passing the parameter greater_than" do 
      get :index, params: { :greater_than => 3 }

      expect(response).to have_http_status(:ok)
    end

    it "passing the parameter less_than" do 
      get :index, params: { :less_than => 2 }

      expect(response).to have_http_status(:ok)
    end

    it "passing the parameter greater_than and less_than" do 
      get :index, params: { :greater_than => 3, :less_than => 1 }

      expect(response).to have_http_status(:ok)
    end
  end
  
  context "Failure" do
    it "empty parameters for index" do 
      get :index

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "less_than is more than greater_than" do 
      get :index, params: { :less_than => 3, :greater_than => 2 }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "incorrect parameter was passed asc_or_desc" do 
      get :index, params: { :greater_than => "Lalala" }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "incorrect parameter was passed less_than" do 
      get :index, params: { :less_than => "Lalala" }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "incorrect parameter was passed greater_than" do 
      get :index, params: { :greater_than => "Lalala" }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    context "passing the wrong greater_than and less_than" do 
      it "passing greater_than and less_than, but greater_than is incorrect" do 
        get :index, params: { :less_than => 3, :greater_than => "Lololol" }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "passing greater_than and less_than, but less_than is incorrect" do 
        get :index, params: { :less_than => "Lololol", :greater_than => 2 }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "passing greater_than and less_than, but both are wrong" do 
        get :index, params: { :less_than => "Lololol", :greater_than => "Lololol" }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end