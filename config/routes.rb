Rails.application.routes.draw do
  root to: "homes#index"
  
  use_doorkeeper
  devise_for :users
  resources :bank_accounts, only: %i[new create edit update destroy]
  resources :cards, only: %i[new create edit update destroy]

  mount Api::Base, at: '/'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      namespace :auth do
        post '/register', to: "registrations#register"
      end
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
