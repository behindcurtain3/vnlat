Rails.application.routes.draw do
  resources :movies do
    resources :ratings, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :people do
  end

  namespace :api do
    namespace :v1 do
      resources :movies, only: [:show, :index], defaults: { format: 'json' }
    end
    
    get 'v:api/*path', :to => redirect("/api/v1/%{path}")
    get '*path', :to => redirect("/api/v1/%{path}")
  end

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  resources :users, only: [:show]

  get 'tags/:tag', to: 'movies#index', as: :tag
  get 'about' => "pages#about"
  root 'movies#index'
end
