Tpo11::Application.routes.draw do
  resources :articles

    get "home/index"
    resources :home, only: [:index]
    root 'home#index'
    resources :projects, only: [:index, :new, :create, :destroy, :edit, :update]
    resources :sessions, only: [:new, :create, :destroy]
    match '/signout', to: 'sessions#destroy', via: 'delete'
    match '/signin', to: 'sessions#new', via: 'get'
    resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    match '/users/:id/activate', to: 'users#activate', via: 'patch', as: 'activate_users'

    resources :usertasks, only: [:index]

    resources :sprints
    match '/sprints', to: 'sprints#index', via: 'get'

    resources :stories, only: [:index, :new, :create, :edit, :update, :destroy]
    match '/stories/:id/accept', to: 'stories#accept', via: 'patch', as: 'accept_story'
    match '/stories/:id/reject', to: 'stories#reject', via: 'patch', as: 'reject_story'
    match '/stories/:id/notes', to: 'stories#notes', via: 'patch', as: 'notes_story'

    match '/addtosprint', to: 'stories#addtosprint', via: 'post'
    resources :tasks
    match 'indextask', to: 'tasks#new', via: 'get'

    match '/accept', to: 'tasks#accept', via: 'post'
    match '/release', to: 'tasks#release', via: 'post'
    match '/reject', to: 'tasks#reject', via: 'post'
    match '/startwork', to: 'usertasks#startwork', via: 'post'
    match '/stopwork', to: 'usertasks#stopwork', via: 'post'

    resources :tasks do
        member do
            post 'new'
        end
    end

    resources :worktimes, only: [:index]
    match '/worktimes', to: 'worktimes#index', via: 'post'
    match '/worksave', to: 'worktimes#update', via: 'post'

    resources :progress, only: [:index]
    resources :posts
    resources :comments
    resources :articles
    match '/articles/:id/notes', to: 'articles#notes', via: 'patch', as: 'notes_article'
    resources :pokers
    match '/pokers/new', to: 'pokers#new', via: 'post'
    match '/pokers/startgame', to: 'pokers#startgame', via: 'post'
    match '/pokers/endgame', to: 'pokers#endgame', via: 'post'

end

