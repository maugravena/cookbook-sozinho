Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'search', to: 'home#index'

  resources :cuisines, only: %i[new create]
  resources :recipe_types, only: %i[new create]
  resources :recipes, only: %i[show new create edit update] do
    get 'pending', on: :collection
  end

  namespace :user do
    resources :recipes, only: %i[index]
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :recipes, only: %i[index create show update destroy]
      resources :recipe_types, only: %i[create show]
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
