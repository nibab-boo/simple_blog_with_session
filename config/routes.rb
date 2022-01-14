Rails.application.routes.draw do
  get 'likes/new'
  get 'likes/create'
  get 'likes/destroy'
  resources :sessions, only: [:create]
  get 'signup', to: "users#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  
  resources :users, except: [:index] do
    resources :articles, only: [:new, :create, :edit, :update]
    # member do
    #   get :articles
    # end
  end
  
  resources :articles, only: [:index, :destroy, :show] do
    collection do
      get :recent
      get :top
      get :my
    end

    resources :likes, only: [:create]
  end
  resources :likes, only: [:destroy]
  
  root 'articles#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
