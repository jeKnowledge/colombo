Rails.application.routes.draw do
  get '/sign_in', to: 'website#new', as: 'sign_in'
  post '/sign_in', to: 'website#create'
  root "website#index"
end
