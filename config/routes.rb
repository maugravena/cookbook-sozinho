Rails.application.routes.draw do
  root to: 'home#index'
  get 'recipes', to: 'home#index'

  resources :recipes, only: %i[show new create edit update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
