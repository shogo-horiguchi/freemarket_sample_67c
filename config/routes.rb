Rails.application.routes.draw do
  root "items#index"

  resources :items, only: [:show, :new]

  resources :payments, only: [:index, :show, :new]
  devise_for :users
  resources :users, only: :show do

    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  
  resources :payments, only: [:new, :show] do
    collection do
      post 'show', to: 'payments#show'
      post 'pay', to: 'payments#pay'
      post 'delete', to: 'payments#delete'
    end
  end
end
