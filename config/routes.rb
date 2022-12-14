Rails.application.routes.draw do
  root to: "homes#index"
  
  use_doorkeeper
  devise_for :users
  resources :bank_accounts, only: %i[new create edit update]
  resources :cards, only: %i[new create edit update]
  resources :purchases, only: %i[index new create edit update] do
    resources :payments, only: %i[show new create edit update] do
      member do
        get :verify
        get :bank_account
        post :save_bank_account
        get :card
        post :save_card
      end
    end
  end
  get "/payments", to: "payments#index"
  get "/profile", to: "profile#get_profile"

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
