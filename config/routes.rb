Rails.application.routes.draw do
  use_doorkeeper

  root "home#index"

  scope path: "users", controller: "users" do
    get "new", to: "users#new"
    post "signup", to: "users#create"
  end

  scope path: "sessions", controller: "sessions" do
    post "login", to: "sessions#create"
    post "logout", to: "sessions#destroy"
  end
end
