Tpo11::Application.routes.draw do
	resources :projects, only: [:index, :new, :create, :destroy]
	root 'projects#index'
	resources :sessions, only: [:new, :create, :destroy]
	match '/signout', to: 'sessions#destroy', via: 'delete'
	match '/signin',  to: 'sessions#new',         via: 'get'
	resources :users, only: [:index, :show, :new, :create, :edit, :update]
end

