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


    resources :stories, only: [:index, :new, :create, :edit, :update, :destroy]
    match '/addtosprint', to: 'stories#addtosprint', via: 'post'
    resources :tasks

    match '/accept', to: 'tasks#accept', via: 'post'
    match '/release', to: 'tasks#release', via: 'post'
    match '/reject', to: 'tasks#reject', via: 'post'
    match '/addtime', to: 'stories#addtime', via: 'get'
    resources :tasks do
        member do
            post 'new'
        end
    end

end

