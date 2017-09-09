Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'home#index'

  resources :users, only: [:index, :show]

  resources :categories, except: [:show]

  scope :categories do
    get '/:category_name', controller: :categories, action: :show
    get '/:category_name/plugins', controller: :plugins, action: :filter_by_category
  end

  namespace :users do
    get '/me', action: :me
    put '/change_status', action: :change_status
    put '/change_role', action: :change_role
  end

  namespace :plugins do
    get '/', action: :index
    get '/:plugin_name', action: :show
  end


end
