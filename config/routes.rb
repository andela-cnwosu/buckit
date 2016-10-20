Rails.application.routes.draw do
  use_doorkeeper

  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :lists, path: "bucketlists"
    end
  end

  scope path: "users", controller: "users" do
    get "new", to: "users#new"
    post "signup", to: "users#create"
  end

  scope path: "sessions", controller: "sessions" do
    post "login", to: "sessions#create", as: "login"
    post "logout", to: "sessions#destroy", as: "logout"
  end
end
