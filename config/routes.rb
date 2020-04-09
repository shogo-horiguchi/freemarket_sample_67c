Rails.application.routes.draw do
  root "items#index"
  resources :items, only: :show
  devise_for :users
  resources :users, only: :show
end
