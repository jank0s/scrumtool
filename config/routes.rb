Tpo11::Application.routes.draw do
    get "home/index"
    resources :home, only: [:index]
    root 'home#index'
    resources :projects, only: [:index, :new, :create, :destroy, :edit, :update]
    resources :sessions, only: [:new, :create, :destroy]
    match '/signout', to: 'sessions#destroy', via: 'delete'
    match '/signin', to: 'sessions#new', via: 'get'
    resources :users, only: [:index, :show, :new, :create, :edit, :update]

    resources :sprints
    match '/sprints', to: 'sprints#index', via: 'get'
    resources :stories, only: [:index, :new]
end

