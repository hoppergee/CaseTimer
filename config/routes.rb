Rails.application.routes.draw do
  devise_for :users

  root "cases#index"
  # root 'welcome#index'

  resources :cases

  resources :tasks

end
