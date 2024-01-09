Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "authentication#new"
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"
  get "sign_in", to: "authentication#new"
  post "sign_in", to: "authentication#login"
  get "sign_out", to: "authentication#logout", as: 'logout_user'
  get "add_resource", to: "resources#new", as: 'add_resource'
  post "add_resource", to: "resources#create"
  get "get_user", to: "users#show", as: 'get_user'

  resources :users, only: [:create, :update, :show, :index]
  resources :companies, only: [:create, :index]
  resources :resources, only: [:create, :update, :index, :show]
  resources :allotments, only: [:create, :update, :index]

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
