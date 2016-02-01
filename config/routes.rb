Rails.application.routes.draw do
  root "queries#index"

  resources :queries, only: [:index, :new, :create]
end
