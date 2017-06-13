Rails.application.routes.draw do
  devise_for :users

  root "cases#index"
  # root 'welcome#index'

  resources :cases do
  	member do
  		post :update_timer
  	end
  end

  resources :tasks

end
