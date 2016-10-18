Rails.application.routes.draw do
  use_doorkeeper

  root "home#index"
end
