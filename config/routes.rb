Rails.application.routes.draw do
  resources :franchises

  resources :movies do
    resources :ratings, only: [:new, :create, :edit, :update, :destroy]
    resources :likes, only: [:create, :update, :destroy]
    get :autocomplete_person_name, :on => :collection
    
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
  resources :crews, only: [:create]
  resources :trailers, only: [:create, :update, :destroy]
  resources :reviews, only: [:create]
  resources :quotes, only: [:create]
  resources :franchise_members, only: [:create]

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
  get 'about' => "pages#about"
  get 'remote_new_person', to: 'remote_content#remote_new_person'
  root 'movies#index'
end
