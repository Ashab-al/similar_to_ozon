Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do 
    resources :shops, only: [:index, :show]
    get '/categories', to: 'shops#categories'
    get '/products', to: 'shops#products'
    post '/create', to: 'shops#create'
  end

  namespace :endpoints do
    resources :products, only: [:index, :show, :create]
  end
end
