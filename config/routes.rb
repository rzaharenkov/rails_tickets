Rails.application.routes.draw do
  root to: 'dashboard#index'

  devise_for :users

  namespace :api do
    resources :users
    resources :tickets
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
