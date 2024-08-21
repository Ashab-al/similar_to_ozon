Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do 
    resources :shops, only: [:index, :show]
    get '/categories', to: 'shops#categories'
    post '/create', to: 'shops#create'
    resources :products, only: [:show, :create, :update]
  end
end
