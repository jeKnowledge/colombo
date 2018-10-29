Rails.application.routes.draw do
  resource :client do
    get '/sign_up', to: 'client#new'
    post '/sign_up', to: 'client#create'
  end

  resource :auditor do
    get '/sign_up', to: 'auditor#new'
    post '/sign_up', to: 'auditor#create'
  end

  get '/sign_in', to: 'website#new', as: 'sign_in'
  post '/sign_in', to: 'website#create'
  get '/terms', to: 'website#terms', as: 'terms'

  root 'website#index'
end
