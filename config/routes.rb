PublicTracker::Application.routes.draw do
  root :to => "home#index"
  get "projects/upvote/:id" => "projects#upvote"
  resources :projects
  devise_for :users
  resources :users, :only => :show
  

end
