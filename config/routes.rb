Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'home#index'

  resources :users, only: [:index, :show]

  resources :tags, except: [:show]

  scope :tags do
    get '/:tag_name', controller: :tags, action: :show
    get '/:tag_name/plugins', controller: :plugins, action: :filter_by_tag
    get '/search', controller: :tags, action: :search
  end

  namespace :users do
    get '/me', action: :me
    put '/change_status', action: :change_status
    put '/change_role', action: :change_role
  end

  namespace :plugins do
    get '/', action: :index
    get '/:plugin_name', action: :show
    post '/', action: :create
    put '/:id', action: :update
    delete '/:id', action: :destroy
  end


end
