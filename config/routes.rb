Tpo11::Application.routes.draw do
    get "home/index"
    resources :home, only: [:index]
    root 'home#index'
    resources :projects, only: [:index, :new, :create, :destroy, :edit, :update]
    resources :sessions, only: [:new, :create, :destroy]
    match '/signout', to: 'sessions#destroy', via: 'delete'
    match '/signin', to: 'sessions#new', via: 'get'
    resources :users, only: [:index, :show, :new, :create, :edit, :update]
    resources :usertasks, only: [:index]

    resources :sprints
    match '/sprints', to: 'sprints#index', via: 'get'

    resources :stories, only: [:index, :new, :create, :edit, :update, :destroy]
    match '/stories/:id/accept', to: 'stories#accept', via: 'patch', as: 'accept_story'
    match '/stories/:id/reject', to: 'stories#reject', via: 'patch', as: 'reject_story'

    match '/addtosprint', to: 'stories#addtosprint', via: 'post'
    resources :tasks
    match 'indextask', to: 'tasks#new', via: 'get'

    match '/accept', to: 'tasks#accept', via: 'post'
    match '/release', to: 'tasks#release', via: 'post'
    match '/reject', to: 'tasks#reject', via: 'post'
    resources :tasks do
        member do
            post 'new'
        end
    end



end

