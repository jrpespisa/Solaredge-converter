Rails.application.routes.draw do
  devise_for :users
  root "queries#index"

  resources :queries, only: [:index, :new, :create]
  resources :credits, only: [:create]
end
