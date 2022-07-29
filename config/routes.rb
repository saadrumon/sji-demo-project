Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "homes#index"
  resources :bank_accounts, only: %i[new create edit update destroy]
  resources :cards, only: %i[new create edit update destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
