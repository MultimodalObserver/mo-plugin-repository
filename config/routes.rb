Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth', :controllers => { :registrations => "registrations" }

  get '/', to: 'home#index'

  #resources :tags, except: [:show]

  scope :tags do
    get '/', controller: :tags, action: :index
    get '/:tag_name', controller: :tags, action: :show
    get '/:tag_name/plugins', controller: :plugins, action: :filter_by_tag
  end

  namespace :users do
    get '/me', action: :me
    put '/change_username', action: :change_username
    get '/my_plugins', action: :my_plugins
    #put '/change_status', action: :change_status
    #put '/change_role', action: :change_role
  end

  #resources :users, only: [:index, :show]

  namespace :plugins do
    get '/', action: :explore
    get '/:plugin_name', action: :show
    post '/', action: :create
    put '/:id', action: :update
    delete '/:id', action: :destroy
    delete '/:id/tags/:tag_id', action: :remove_tag
    post '/:id/tags', action: :add_tag
  end

  namespace :admin do
    post '/:id/reject', action: :reject_plugin
    post '/:id/accept', action: :accept_plugin
    get '/pending', action: :get_pending_plugins
  end

end
