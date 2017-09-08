Rails.application.routes.draw do
  resources :categories
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'home#index'

  resources :users, only: [:index, :show]

  namespace :users do
    get '/me', action: :me
    put '/change_status', action: :change_status
    put '/change_role', action: :change_role
  end

  namespace :plugins do
    get '/', action: :index
  end


end
