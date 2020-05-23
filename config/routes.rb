Rails.application.routes.draw do
  root "items#index"

  resources :items, only: [:index, :show, :new, :create] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  devise_for :users
  resources :users, only: :show 
end

