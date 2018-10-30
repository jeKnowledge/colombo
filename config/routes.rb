Rails.application.routes.draw do
  resource :admin do
    get '/dashboard', to: 'admins#index'
    resource :validations, only: [] do
      get '/validate/:user_id', to: 'validations#validate'
      get '/:user_id', to: 'validations#show'
      get '/', to: 'validations#index'
    end
  end

  resource :client do
    get '/sign_up', to: 'clients#new'
    post '/sign_up', to: 'clients#create'
    get '/dashboard', to: 'clients#index'
  end

  resource :auditor do
    get '/sign_up', to: 'auditors#new'
    post '/sign_up', to: 'auditors#create'
    get '/dashboard', to: 'auditors#index'
  end

  resource :admin do
    get '/dashboard', to: 'admins#index'
  end

  get '/sign_in', to: 'website#new', as: 'sign_in'
  post '/sign_in', to: 'website#create'
  get '/terms', to: 'website#terms', as: 'terms'

  root 'website#index'
end
