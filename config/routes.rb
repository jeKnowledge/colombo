Rails.application.routes.draw do
  namespace :admin do
    get '/dashboard', to: 'general#index', as: 'dashboard'
    post '/create', to: 'general#create'

    get '/', to: 'general#index'

    #Conversations
    post '/conversations', to: 'general#create_conversation'
    get '/conversations', to: 'general#conversation_index'
    get '/conversations/:id', to: 'general#show_conversation', as: 'show_conversation'
    post '/message', to: 'general#create_message'

    ### Users ###
    get '/user/:id', to: 'general#show_user', as: 'show_user'
    delete '/user/:id', to: 'general#delete_user', as: 'delete_user'
    post '/user/:id/validate', to: 'general#validate_user', as: 'validate_user'
    post '/user/:id/invalidate', to: 'general#invalidate_user', as: 'invalidate_user'

    ### Auditor ###
    post '/auditor/set_default_rating', to: 'general#set_default_auditor_rating', as: 'set_default_auditor_rating'
    post '/auditor/:id/download_cv', to: 'general#download_cv', as: 'download_auditor_cv'

    ### Audits ###
    get '/audit/:id/show', to: 'general#show_audit', as: 'show_audit'
    post '/audit/:id/validate', to: 'general#validate_audit', as: 'validate_audit'
    post '/audit/:id/invalidate', to: 'general#invalidate_audit', as: 'invalidate_audit'
    post '/audit/:id/download', to: 'general#download_audit', as: 'download_audit'

    ### Report ###
    post '/report/set_default_rating', to: 'general#set_default_report_rating', as: 'set_default_report_rating'

    ### Notifications ###
    get '/notification/:id/show', to: 'general#show_notification', as: 'show_notification'

    ### Requests ###
    get '/request/:id/show', to: 'general#show_request', as: 'show_request'

    ### Terms ###
    resources :terms, controller: "terms"
    post 'terms/:id/select', to: "terms#select", as: "term_select"

    ### Contracts ###
    resources :contracts, controller: "contracts"
    post 'contracts/:id/select', to: "contracts#select", as: "contract_select"
    post 'contracts/:id/download', to: "contracts#download", as: "contract_download"
  end

  namespace :client do
    get '/', to: 'general#index', as: 'dashboard'
    get '/sign_up', to: 'general#new'
    post '/sign_up', to: 'general#create'
    get '/profile/edit', to: 'general#edit'
    patch '/profile/edit', to: 'general#update'
    get '/profile', to: 'general#show'
    delete '/profile', to: 'general#delete'

    ### Purchases ###
    get '/purchases', to: 'general#purchases'
    post '/purchases/:id/rate', to: 'general#rate_purchase', as: 'rate_purchase'
    get '/purchase/:id/auditor', to: 'general#show_auditor', as: 'purchase_auditor'
    post '/purchase/:id/download', to: 'general#download_audit', as: 'download_audit'

    ### Requests ###
    get '/requests', to: 'general#requests'

    ### Reservations ###
    get '/reservations', to: 'general#reservations'
    get '/reservation/:id/auditor', to: 'general#show_auditor', as: 'reservation_auditor'

    scope :audits do
      get '/search', to: 'audits#search'
      get '/advanced_search', to: 'audits#advanced_search'

      ### Purchase ###
      get '/purchase/:id/preview', to: 'audits#purchase_preview', as: 'purchase_preview'
      get '/purchase/:id', to: 'audits#purchase', as: 'purchase'

      ### Reserve ###
      get '/reserve/:id/preview', to: 'audits#reserve_preview', as: 'reserve_preview'
      get '/reserve/:id', to: 'audits#reserve', as: 'reserve'

      ### Request ###
      get '/request', to: 'audits#make_request'
      post '/request', to: 'audits#request_send'
    end
  end

  get '/auditor', to: 'auditor/general#index'

  namespace :auditor do
    root 'general#index'
    get '/', to: 'general#index', as: 'dashboard'
    get '/profile', to: 'general#show'
    delete '/profile', to: 'general#delete'
    get '/profile/edit', to: 'general#edit'
    patch '/profile/edit', to: 'general#update'
    post '/profile/download_cv', to: 'general#download_cv', as: 'download_cv'
    get '/sign_up', to: 'general#new'
    post '/sign_up', to: 'general#create'
    post '/accept_terms', to: 'general#accept_terms'

    #Conversations
    post '/conversations', to: 'general#create_conversation'
    get '/conversations', to: 'general#conversation_index'
    get '/conversations/:id', to: 'general#show_conversation', as: 'show_conversation'
    post '/message', to: 'general#create_message'

    ### Audits ###
    post '/audit/:id/download', to: 'general#download_audit', as: 'download_audit'

    ### Purchases ###
    get '/purchases', to: 'general#purchases'

    ### Requests ###
    get '/requests', to: 'general#requests'

    ### Reservations ###
    get '/reservations', to: 'general#reservations'

    ### Clients ###
    get '/show_client/:id', to: 'general#show_client', as: 'show_client'

    scope :audits do
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

  scope :paypal, as: 'paypal' do
    post '/checkout', to: 'paypal#checkout'
    post '/execute', to: 'paypal#execute'
  end

  get '/sign_in', to: 'website#new', as: 'sign_in'
  get '/sign_out', to: 'website#destroy', as: 'sign_out'
  get '/terms', to: 'website#terms', as: 'terms'
  post '/sign_in', to: 'website#create'
  post '/accept_terms', to: 'website#accept_terms'

  get '/new_forgot_password', to: 'website#new_forgot_password'
  post '/create_forgot_password', to: 'website#create_forgot_password'
  get '/new_credentials/:token', to: 'website#new_credentials', as: 'new_credentials'

  root 'website#index'
end
