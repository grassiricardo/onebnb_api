Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, only: [:update]
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :properties
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
