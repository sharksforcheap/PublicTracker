PublicTracker::Application.routes.draw do
  root :to => "home#index"
  resources :projects
  devise_for :users
  resources :users, :only => :show
  
end
