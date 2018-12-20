Rails.application.routes.draw do
  resource :admin do
    get '/', to: 'admins#index', as: 'dashboard'

    ### Users ###
    get '/user/:id', to: 'admins#show_user', as: 'show_user'
    post '/user/validate/:id', to: 'admins#validate_user', as: 'validate_user'
    post '/user/invalidate/:id', to: 'admins#invalidate_user', as: 'invalidate_user'
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

  namespace :client do
    get '/', to: 'general#index', as: 'dashboard'
    get '/sign_up', to: 'general#new'
    post '/sign_up', to: 'general#create'
    get '/profile/edit', to: 'general#edit'
    patch '/profile/edit', to: 'general#update'
    get '/profile', to: 'general#show'
    delete '/profile', to: 'general#delete'
    post '/accept_terms', to: 'general#accept_terms'

    ### Messages ###
    get '/messages', to: 'general#messages'
    post '/messages', to: 'general#send_message'
    get '/message/:id', to: 'general#show_message', as: 'message'
    get '/messages/new', to: 'general#new_message'

    ### Purchases ###
    get '/purchases', to: 'general#purchases'
    post '/purchases/:id/rate', to: 'general#rate_purchase', as: 'rate_purchase'

    ### Requests ###
    get '/requests', to: 'general#requests'

    ### Reservations ###
    get '/reservations', to: 'general#reservations'

    scope :audits do
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

  get '/auditor', to: 'auditor/general#index'
  namespace :auditor do
    root 'general#index'
    get '/', to: 'general#index', as: 'dashboard'
    get '/profile', to: 'general#show'
    delete '/profile', to: 'general#delete'
    get '/profile/edit', to: 'general#edit'
    patch '/profile/edit', to: 'general#update'
    get '/sign_up', to: 'general#new'
    post '/sign_up', to: 'general#create'
    post '/accept_terms', to: 'general#accept_terms'

    ### Messages ###
    get '/messages', to: 'general#messages'
    post '/messages', to: 'general#send_message'
    get '/message/:id', to: 'general#show_message', as: 'message'
    get '/messages/new', to: 'general#new_message'

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

  get '/sign_in', to: 'website#new', as: 'sign_in'
  get '/sign_out', to: 'website#destroy', as: 'sign_out'
  get '/terms', to: 'website#terms', as: 'terms'
  post '/sign_in', to: 'website#create'

  get '/new_forgot_password', to: 'website#new_forgot_password'
  post '/create_forgot_password', to: 'website#create_forgot_password'
  get '/new_change_password/:token', to: 'website#new_change_password', as: 'new_change_password'
  post '/create_change_password', to: 'website#create_change_password'

  root 'website#index'
end
