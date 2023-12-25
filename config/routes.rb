Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_closed', on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'breweries#index'
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:index, :create, :destroy]
  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'
end
