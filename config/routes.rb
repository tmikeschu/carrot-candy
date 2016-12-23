Rails.application.routes.draw do
  root to: "sessions#new"
  
  resources :users, only: [:show] do
    get '/dashboard', to: "users#dashboard" 
  end
  
  namespace :admin do
    resources :users, only: [:new, :create, :index, :edit, :update, :show]  
    resources :rewards, except: [:patch]
  end

  resources :rewards, only: [:index, :show]
  get 'buy/:id', to: "users#buy"
  post 'buy/:id', to: "users#add_reward"

  get     '/login', to: "sessions#new"
  post    '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
end
