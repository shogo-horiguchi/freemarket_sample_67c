Rails.application.routes.draw do
  root "items#index"

  resources :items, only: [:show, :new]

  resources :payments, only: [:show, :new]
  devise_for :users
  resources :users, only: :show do

    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
end

