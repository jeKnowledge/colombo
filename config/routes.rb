Rails.application.routes.draw do
  resource :admin do
    get '/', to: 'admins#index', as: 'dashboard'
    get '/show/user/:id', to: 'admins#show_user', as: 'show_user'
    get '/show/audit/:id', to: 'admins#show_audit', as: 'show_audit'
    get '/show/request/:id', to: 'admins#show_request', as: 'show_request'
    get '/validate/audit/:id', to: 'admins#validate_audit', as: 'validate_audit'
    get '/validate/user/:id', to: 'admins#validate_user', as: 'validate_user'
    get '/validate/request/:id', to: 'admins#validate_request', as: 'validate_request'

    get '/consents/toggle/:id', to: 'admin/consents#toggle', as: 'toggle_consent'
    resources :consents , controller: 'admin/consents'
  end

  resource :client do
    get '/', to: 'clients#index', as: 'dashboard'
    get '/profile', to: 'clients#show'
    get '/mail', to: 'clients#mail'
    get '/purchases', to: 'clients#purchases'
    get '/requests', to: 'clients#requests'
    get '/reservations', to: 'clients#reservations'
    get '/sign_up', to: 'clients#new'
    get '/show_profile/:id', to: 'clients#profile', as: 'show_profile'
    post '/sign_up', to: 'clients#create'

    resource :audits, except: [:new, :create, :edit, :update, :show, :destroy] do
      get '/advanced_search', to: 'client/audits#advanced_search'
      get '/purchase/:id', to: 'client/audits#purchase', as: 'purchase'
      get '/request', to: 'client/audits#make_request'
      get '/reserve/:id', to: 'client/audits#reserve', as: 'reserve'
      get '/search', to: 'client/audits#search'
      post '/request', to: 'client/audits#request_send'
    end
  end

  resource :auditor do
    get '/', to: 'auditors#index', as: 'dashboard'
    get '/profile', to: 'auditors#show'
    get '/mail', to: 'auditors#mail'
    get '/purchases', to: 'auditors#purchases'
    get '/requests', to: 'auditors#requests'
    get '/reservations', to: 'auditors#reservations'
    get '/sign_up', to: 'auditors#new'
    post '/sign_up', to: 'auditors#create'

    resource :audits, except: [:new, :create, :edit, :update, :show, :destroy] do
      get '/show_report/:id', to: 'auditor/audits#show_report', as: 'show_report'
      get '/purchases', to: 'auditor/audits#purchases'
      get '/report', to: 'auditor/audits#report'
      post '/report', to: 'auditor/audits#report_send'
      get '/reports', to: 'auditor/audits#reports'
      get '/plan', to: 'auditor/audits#plan'
      post '/plan', to: 'auditor/audits#plan_send'
      get '/plans', to: 'auditor/audits#plans'
    end
  end

  get '/sign_in', to: 'website#new', as: 'sign_in'
  get '/sign_out', to: 'website#destroy', as: 'sign_out'
  get '/terms', to: 'website#terms', as: 'terms'
  post '/sign_in', to: 'website#create'

  root 'website#index'
end
