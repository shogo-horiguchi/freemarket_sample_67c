Rails.application.routes.draw do
  root "items#index"

  resources :items, only: [:index, :show, :new, :create] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    resources :comments, only: [:new, :create, :show]
    collection do
      get 'confirmation', to: 'items#confirmation'
      post 'pay', to: 'items#pay'
      get 'done', to: 'items#done'
      get 'index_selling', to: 'items#index_selling'
      get 'index_sold', to: 'items#index_sold'
      get 'index_recent_posted', to: 'items#index_recent_posted'
    end
  end

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  resources :users, only: :show do
    member do
      get 'logout'
    end
  end

  resources :payments, only: [:new, :show] do
    collection do
      post 'show', to: 'payments#show'
      post 'pay', to: 'payments#pay'
      post 'delete', to: 'payments#delete'
      get 'detail',to: 'payments#detail'
    end
  end
end


