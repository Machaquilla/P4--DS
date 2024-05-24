Rails.application.routes.draw do
  resources :texts, only: [:index, :create, :update, :destroy]
end
