Rails.application.routes.draw do
  resources :franchises

  resources :movies do
    resources :ratings, only: [:new, :create, :edit, :update, :destroy]
    resources :likes, only: [:create, :update, :destroy]
    get :autocomplete_person_name, :on => :collection
    get :autocomplete_character_name, :on => :collection
    
    member do
      get :boxoffice
      get :trailers
      get :reviews
      get :quotes
    end
    
    resources :versions, only: [:destroy] do
      member do
        get :diff, to: 'versions#diff'
        patch :rollback, to: 'versions#rollback'
      end
    end
    
  end

  resources :people do
  end

  resources :characters
  resources :appearances, only: [:create]
  resources :crews, only: [:create]
  resources :trailers, only: [:create, :update, :destroy]
  resources :reviews, only: [:create]
  resources :quotes, only: [:create]
  resources :franchise_members, only: [:create]
  resources :earnings, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :movies, only: [:show, :index], defaults: { format: 'json' }
      resources :people, only: [:show, :index], defaults: { format: 'json' }
    end
    
    get 'v:api/*path', :to => redirect("/api/v1/%{path}")
    get '*path', :to => redirect("/api/v1/%{path}")
  end

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  resources :users, only: [:show]

  get 'genres/:genre', to: 'movies#index', as: :genre
  get 'year/:year', to: 'movies#index', as: :year
  get 'about' => 'pages#about'
  get 'the-real-chris' => 'pages#chris'
  get 'top-movies' => 'pages#top_movies'
  get 'top-actors' => 'pages#top_actors'
  get 'coming-soon' => 'pages#soon'
  get 'remote_new_person', to: 'remote_content#remote_new_person'
  get 'remote_new_character', to: 'remote_content#remote_new_character'
  root 'movies#index'
end
