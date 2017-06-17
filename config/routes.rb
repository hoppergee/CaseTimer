Rails.application.routes.draw do
  devise_for :users

  root "cases#index"
  # root 'welcome#index'

  resources :cases do
  	member do
  		post :update_timer
  		post :select_template
      get :ranking
      # post :update_goal
  	end
  end

  resources :tasks

  resources :task_templates_groups

  # resources :account do
  #   resources :favors
  # end

end
