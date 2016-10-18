Rails.application.routes.draw do
  use_doorkeeper

  root "home#index"

  get "users/new", to: "users#new"
end
