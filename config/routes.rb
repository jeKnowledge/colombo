Rails.application.routes.draw do
  resources :website, only: [:new, :create, :index]
  root "website#index"
end
