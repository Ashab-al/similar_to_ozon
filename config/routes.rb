Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do 
    resources :shops, only: [:index, :show]
    get '/categories', to: 'shops#categories'
    get '/products', to: 'shops#products'
    post '/create', to: 'shops#create'
  end
end
