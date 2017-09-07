Rails.application.routes.draw do
  resources :categories
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show]

  get '/users/me', to: 'users#me'
  put '/users/change_status', to: 'users#change_status'
  put '/users/change_role', to: 'users#change_role'

end
