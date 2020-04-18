Rails.application.routes.draw do
  root "items#index"
  resources :items, only: :show do
    resources :comments, only: [:new, :create]
  end
  devise_for :users
  resources :users, only: :show
  resources :payments
end

