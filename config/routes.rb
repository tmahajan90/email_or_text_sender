require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  
  mount Sidekiq::Web => '/sidekiq'
  root 'dashboards#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users
  resources :users
  resources :clients
  resources :campaigns
  
  resources :groups do
    resources :group_clients, only: [:index, :create, :destroy]
  end

end
