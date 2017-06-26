Rails.application.routes.draw do
  get 'articles/index'

  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks"}

  root "cases#index"
  # root 'welcome#index'

  resources :cases do
  	member do
  		post :update_timer
  		post :select_template
      get :ranking
      post :update_goal
  	end
  end

  resources :tasks

  resources :task_templates_groups

  namespace :admin do
    resources :cases
    resources :articles
  end

  resources :articles

  mount ActionCable.server => '/cable'

end
