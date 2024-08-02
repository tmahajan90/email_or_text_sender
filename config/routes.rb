Rails.application.routes.draw do
  
  devise_for :users
  resources :users
  resources :clients
  resources :campaigns
  
  resources :groups do
    resources :group_clients, only: [:index, :create, :destroy]
  end

  root 'dashboards#index'
end
