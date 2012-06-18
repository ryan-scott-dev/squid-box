SquidBox::Application.routes.draw do

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  match 'user_sessions/create' => "user_sessions#create", :as => :create_user_sessions

  match "repository/:id/commit/:commit_id" => "repository_commit#show"

  resources :repositories
  resources :repository_clone

  root :to => 'home#index', :as => :home

end
