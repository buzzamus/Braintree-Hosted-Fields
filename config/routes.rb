Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'pages/home', to: 'pages#home'
  resources :checkouts, only: [:new, :create, :show]
  resources :subscriptions, only: [:index, :new, :create, :show]
  resources :customers, only: [:index, :show]
  resources :cards, only: [:index, :show, :edit, :update]
end
