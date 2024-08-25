Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  

  namespace :api do 
    resources :shops, only: [:index, :show]
    get '/categories', to: 'shops#categories'
    post '/create', to: 'shops#create'
    resources :products, only: [:show, :create, :update]
  end
end
