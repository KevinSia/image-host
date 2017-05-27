Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :index]
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"
  delete "sign_out", to: "sessions#destroy"

  root "users#index"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
end
