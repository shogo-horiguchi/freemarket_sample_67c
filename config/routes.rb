Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :users, only: :show

  get 'items/index'

  root "items#show"

end
