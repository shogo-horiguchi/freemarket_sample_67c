Rails.application.routes.draw do
  root "items#show"
  get 'items/index'
  devise_for :users
  root "items#index"
  resources :users, only: :show
end
