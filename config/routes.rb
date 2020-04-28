Rails.application.routes.draw do
  root "items#index"

  resources :items, only: [:index, :show] do
    resources :comments, only: [:new, :create]
    collection do
      get 'index', to: 'items#index'
      post 'pay', to: 'items#pay'
      get 'done', to: 'items#done'
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  resources :users, only: :show
  resources :payments, only: [:new, :show] do
    collection do
      post 'show', to: 'payments#show'
      post 'pay', to: 'payments#pay'
      post 'delete', to: 'payments#delete'
    end
  end

end

