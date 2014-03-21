Tpo11::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  root 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/signin',  to: 'sessions#new',         via: 'get'
end

