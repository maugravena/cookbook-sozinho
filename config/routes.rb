Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  resources :recipes, only: %i[show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
