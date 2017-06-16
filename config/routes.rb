Rails.application.routes.draw do
  devise_for :users

  root "cases#index"
  # root 'welcome#index'

  resources :cases do
  	member do
  		post :update_timer
  		post :select_template
  	end
  end

  resources :tasks

  resources :task_templates_groups

end
