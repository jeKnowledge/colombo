Rails.application.routes.draw do
  resource :admin do
    get '/', to: 'admins#index', as: 'dashboard'

    ### Users ###
    get '/user/:id', to: 'admins#show_user', as: 'show_user'
    post '/user/validate/:id', to: 'admins#validate_user', as: 'validate_user'
    delete '/user/:id', to: 'admins#delete_user', as: 'delete_user'

    ### Audits ###
    get '/audit/show/:id', to: 'admins#show_audit', as: 'show_audit'
    get '/audit/validate/:id', to: 'admins#validate_audit', as: 'validate_audit'

    ### Messages ###
    get '/message/show/:id', to: 'admins#show_message', as: 'show_message'
    get '/message/validate/:id', to: 'admins#validate_message', as: 'validate_message'

    ### Consents ###
    get '/consents/toggle/:id', to: 'admin/consents#toggle', as: 'toggle_consent'
    resources :consents, controller: 'admin/consents'
  end

  resource :client do
    get '/', to: 'clients#index', as: 'dashboard'
    get '/profile', to: 'clients#show'
    get '/sign_up', to: 'clients#new'
    post '/sign_up', to: 'clients#create'
    post '/accept_terms', to: 'clients#accept_terms'

    ### Messages ###
    get '/messages', to: 'clients#messages'
    post '/messages', to: 'clients#send_message'
    get '/message/:id', to: 'clients#show_message', as: 'message'
    get '/messages/new', to: 'clients#new_message'

    ### Purchases ###
    get '/purchases', to: 'clients#purchases'
    post '/purchases/:id/rate', to: 'clients#rate_purchase', as: 'rate_purchase'

    ### Requests ###
    get '/requests', to: 'clients#requests'

    ### Reservations ###
    get '/reservations', to: 'clients#reservations'

    namespace :audits do
      get '/search', to: 'audits#search'
      get '/advanced_search', to: 'audits#advanced_search'

      ### Purchase ###
      get '/purchase/preview/:id', to: 'audits#purchase_preview', as: 'purchase_preview'
      get '/purchase/:id', to: 'audits#purchase', as: 'purchase'

      ### Reserve ###
      get '/reserve/preview/:id', to: 'audits#reserve_preview', as: 'reserve_preview'
      get '/reserve/:id', to: 'audits#reserve', as: 'reserve'

      ### Request ###
      get '/request', to: 'audits#make_request'
      post '/request', to: 'audits#request_send'
    end
  end

  resource :auditor do
    get '/', to: 'auditors#index', as: 'dashboard'
    get '/profile', to: 'auditors#show'
    get '/sign_up', to: 'auditors#new'
    post '/sign_up', to: 'auditors#create'
    post '/accept_terms', to: 'auditors#accept_terms'

    ### Messages ###
    get '/messages', to: 'auditors#messages'
    post '/messages', to: 'auditors#send_message'
    get '/message/:id', to: 'auditors#show_message', as: 'message'
    get '/messages/new', to: 'auditors#new_message'

    ### Purchases ###
    get '/purchases', to: 'auditors#purchases'

    ### Requests ###
    get '/requests', to: 'auditors#requests'

    ### Reservations ###
    get '/reservations', to: 'auditors#reservations'

    ### Clients ###
    get '/show_client/:id', to: 'auditors#show_client', as: 'show_client'

    namespace :audits do
      ### Report ###
      get '/show_report/:id', to: 'audits#show_report', as: 'show_report'
      get '/report', to: 'audits#report'
      post '/report', to: 'audits#report_send'
      get '/reports', to: 'audits#reports'

      ### Plan ###
      get '/show_plan/:id', to: 'audits#show_plan', as: 'show_plan'
      get '/plan', to: 'audits#plan'
      post '/plan', to: 'audits#plan_send'
      get '/plans', to: 'audits#plans'
    end
  end

  get '/sign_in', to: 'website#new', as: 'sign_in'
  get '/sign_out', to: 'website#destroy', as: 'sign_out'
  get '/terms', to: 'website#terms', as: 'terms'
  post '/sign_in', to: 'website#create'

  root 'website#index'
end
