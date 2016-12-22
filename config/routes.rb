Rails.application.routes.draw do
  resources :users, only: [:show]  
  
  namespace :admin do
    resources :users, only: [:new, :create, :index, :edit, :update, :show]  
    resources :rewards, except: [:patch]
  end

  get 'admin/users/:id/remove-points', to: "admin/users#remove_points"
  post 'admin/users/:id/remove-points', to: "admin/users#destroy_points"

  resources :rewards, only: [:index, :show]
  get 'buy/:id', to: "users#buy"
  post 'buy/:id', to: "users#add_reward"

  get     '/login', to: "sessions#new"
  post    '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
end
