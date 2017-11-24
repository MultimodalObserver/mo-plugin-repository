Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  get '/', to: 'home#index'

  resources :tags, except: [:show]

  scope :tags do
    get '/:tag_name', controller: :tags, action: :show
    get '/:tag_name/plugins', controller: :plugins, action: :filter_by_tag
  end

  namespace :users do
    get '/me', action: :me
    get '/my_plugins', action: :my_plugins
    put '/change_status', action: :change_status
    put '/change_role', action: :change_role
  end

  resources :users, only: [:index, :show]

  namespace :plugins do
    get '/', action: :index
    get '/:plugin_name', action: :show
    post '/', action: :create
    put '/:id', action: :update
    delete '/:id', action: :destroy
    delete '/:id/tags/:tag_id', action: :remove_tag
    post '/:id/tags', action: :add_tag

    post '/:id/reject', action: :reject_plugin
    post '/:id/accept', action: :accept_plugin
  end

end
