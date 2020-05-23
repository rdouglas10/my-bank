Rails.application.routes.draw do
  
  get 'accounts/statement'
  post 'accounts/statement'

  resources :deposits
  # get 'accounts/cash'
  
  resources :accounts

  post 'transactions/withdraw'
  get 'transactions/cash'
  

  resources :transactions

  get 'pages/index'
  get 'pages/services'
  get 'pages/rates'
  get 'pages/contact'

  

  devise_for :users

  # Define the principal page of system
  root to: "pages#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
