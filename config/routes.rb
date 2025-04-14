Rails.application.routes.draw do
  resources :reply_requests, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  # Email reply generation routes
  resources :email_replies, only: [:new, :create]

  # Subscription routes
  resources :subscriptions, only: [:new, :create]
  post 'subscriptions/webhook', to: 'subscriptions#webhook'
end
