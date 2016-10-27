Rails.application.routes.draw do
  use_doorkeeper

  root "home#index"

  get "documentation", to: "home#documentation", as: "documentation"

  namespace :api, defaults: { format: "json" } do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :lists, path: "bucketlists", except: [:edit, :new] do
        resources :items, only: [:create, :update, :destroy], param: :item_id
      end
    end
    match "*url", to: "api#route_not_found", via: :all
  end

  scope path: "users", controller: "users" do
    get "register", to: "users#new", as: "register"
    post "signup", to: "users#create"
  end

  scope path: "auth", controller: "sessions" do
    post "login", to: "sessions#create", as: "login"
    delete "logout", to: "sessions#destroy", as: "logout"
  end
end
