Rails.application.routes.draw do
  root "items#index"
  resources :items, only: [:show, :new, :create]
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  resources :users, only: :show
end
