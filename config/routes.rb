Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]  
  
  namespace :admin do
    resources :rewards, except: [:patch]
  end

  resources :rewards, only: [:index, :show]
  get 'buy/:id', to: "users#buy"
  post 'buy/:id', to: "users#add_reward"

  get     '/login', to: "sessions#new"
  post    '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
end
