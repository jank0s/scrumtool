Tpo11::Application.routes.draw do
  get "projects/index"
  root 'projects#index'
  resources :sessions, only: [:new, :create, :destroy]
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/signin',  to: 'sessions#new',         via: 'get'
end

