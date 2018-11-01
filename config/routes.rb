Rails.application.routes.draw do
  resource :admin do
    get '/', to: 'admins#index', as: 'dashboard'
    post '/validate/user/:id', to: 'admins#validate_user', as: 'validate_user'
    get '/show/user/:id', to: 'admins#show_user', as: 'show_user'
  end

  resource :client, except: [:show] do
    get '/', to: 'clients#index', as: 'dashboard'
    get '/sign_up', to: 'clients#new'
    post '/sign_up', to: 'clients#create'
    get '/mail', to: 'clients#mail'
    get '/requests', to: 'clients#requests'
    get '/reservations', to: 'clients#reservations'
    get '/purchases', to: 'clients#purchases'

    resource :audits, except: [:new, :create, :edit, :update, :show, :destroy] do
      get '/search', to: 'client/audits#search'
      post '/reserve/:id', to: 'client/audits#reserve'
      post '/buy/:id', to: 'client/audits#buy', as: 'buy'
      get '/request', to: 'client/audits#new_request'
      post '/request', to: 'client/audits#request_send'
    end
  end

  resource :auditor, except: [:show] do
    get '/', to: 'auditors#index', as: 'dashboard'
    get '/sign_up', to: 'auditors#new'
    post '/sign_up', to: 'auditors#create'
    get '/mail', to: 'auditors#mail'
    get '/requests', to: 'auditors#requests'
    get '/reservations', to: 'auditors#reservations'
    get '/purchases', to: 'auditors#purchases'

    resource :audits, except: [:new, :create, :edit, :update, :show, :destroy] do
      get '/report', to: 'auditor/audits#report'
      post '/report/:id', to: 'auditor/audits#report_send'
      get '/reports', to: 'auditor/audits#reports'
      get '/plan', to: 'auditor/audits#plan'
      post '/plan/:id', to: 'auditor/audits#plan_send'
      get '/plans', to: 'auditor/audits#plans'
    end
  end

  get '/sign_in', to: 'website#new', as: 'sign_in'
  post '/sign_in', to: 'website#create'
  get '/terms', to: 'website#terms', as: 'terms'
  get '/sign_out', to: 'website#destroy', as: 'sign_out'

  root 'website#index'
end
