PublicTracker::Application.routes.draw do

  get "projects/new"

  get "projects/create"

  root :to => "home#index"
  devise_for :users
  resources :users, :only => :show
  
end
