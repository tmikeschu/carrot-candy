Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]  
  namespace :admin do
    resources :rewards, only: [:new, :index, :create, :show]
  end

  get     '/login', to: "sessions#new"
  post    '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
end
