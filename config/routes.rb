Rails.application.routes.draw do
  root "items#show"
  resources :items, only: :show
  devise_for :users
  resources :users, only: :show
end
