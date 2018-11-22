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
    post '/purchases/:id/rate', to: 'clients#rate_purchase', as: 'rate_purchase'
    get '/requests', to: 'clients#requests'
    get '/reservations', to: 'clients#reservations'
    get '/sign_up', to: 'clients#new'
    post '/sign_up', to: 'clients#create'
    post '/accept_terms', to: 'clients#accept_terms'

    resource :audits, except: [:new, :create, :edit, :update, :show, :destroy] do
      get '/advanced_search', to: 'client/audits#advanced_search'
      get '/purchase_preview/:id', to: 'client/audits#purchase_preview', as: 'purchase_preview'
      get '/purchase/:id', to: 'client/audits#purchase', as: 'purchase'
      get '/request', to: 'client/audits#make_request'
      get '/reserve_preview/:id', to: 'client/audits#reserve_preview', as: 'reserve_preview'
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
    get '/show_client/:id', to: 'auditors#show_client', as: 'show_client'
    post '/accept_terms', to: 'auditors#accept_terms'

    resource :audits, except: [:new, :create, :edit, :update, :show, :destroy] do
      get '/show_report/:id', to: 'auditor/audits#show_report', as: 'show_report'
      get '/show_plan/:id', to: 'auditor/audits#show_plan', as: 'show_plan'
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
