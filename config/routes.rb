Rails.application.routes.draw do
  resource :admin do
    get '/dashboard', to: 'admins#index'
    post '/validate/user/:id', to: 'admins#validate_user', as: 'validate_user'
    get '/show/user/:id', to: 'admins#show_user', as: 'show_user'
  end

  resource :client do
    get '/sign_up', to: 'clients#new'
    post '/sign_up', to: 'clients#create'
    get '/dashboard', to: 'clients#index'
    get '/mail', to: 'clients#mail'
    get '/requests', to: 'clients#requests'
    get '/reservations', to: 'clients#reservations'
    get '/purchases', to: 'clients#purchases'

    resource :audits, except: [:new, :create, :edit, :update, :show, :destroy] do
      get '/search', to: 'client/audits#search'
      post '/reserve', to: 'client/audits#reserve'
      post '/buy', to: 'client/audits#buy'
      get '/request', to: 'client/audits#new_request'
      post '/request', to: 'client/audits#request_send'
    end
  end

  resource :auditor do
    get '/sign_up', to: 'auditors#new'
    post '/sign_up', to: 'auditors#create'
    get '/dashboard', to: 'auditors#index'
    get '/mail', to: 'auditors#mail'
    get '/requests', to: 'auditors#requests'
    get '/reservations', to: 'auditors#reservations'
    get '/purchases', to: 'auditors#purchases'

    resource :audits, except: [:new, :create, :edit, :update, :show, :destroy] do
      get '/report', to: 'auditor/audits#report'
      post '/report', to: 'auditor/audits#report_send'
      get '/plan', to: 'auditor/audits#plan'
      post '/plan', to: 'auditor/audits#plan_send'
      get '/', to: 'auditor/audits#audits'
    end
  end

  get '/sign_in', to: 'website#new', as: 'sign_in'
  post '/sign_in', to: 'website#create'
  get '/terms', to: 'website#terms', as: 'terms'
  post '/sign_out', to: 'website#destroy', as: 'sign_out'

  root 'website#index'
end
