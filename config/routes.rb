Rails.application.routes.draw do
  devise_for :users
  root "queries#index"

  resources :queries, only: [:index, :new, :create, :destroy]
  resources :credits, only: [:create, :destroy]

  namespace :api do
    namespace :v1 do
      resources :queries, only: [:index, :create, :destroy]
    end
  end
end
