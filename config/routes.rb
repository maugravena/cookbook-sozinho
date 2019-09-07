Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'search', to: 'home#index'

  resources :recipes, only: %i[show new create edit update]

  namespace :user do
    resources :recipes, only: %i[index]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
