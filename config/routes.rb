Tpo11::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  root 'sessions#new'
end
