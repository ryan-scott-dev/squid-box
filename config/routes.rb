SquidBox::Application.routes.draw do

  match "repository/:id/commit/:commit_id" => "repository_commit#show"

  resources :repositories
  resources :repository_clone

end
