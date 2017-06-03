Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :index, :show, :edit, :update]
  get "/users/initial_setup", to: "users#initial_setup"

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :albums, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  post "sign_in", to: "sessions#create"
  delete "sign_out", to: "sessions#destroy"

  root "users#new"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
end
