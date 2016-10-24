Rails.application.routes.draw do
  use_doorkeeper

  root "home#index"

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :lists, path: "bucketlists", except: [:edit, :new] do
        resources :items, only: [:create, :update, :destroy], param: :item_id
      end
    end
    match "*url", to: "api#route_not_found", via: :all
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
