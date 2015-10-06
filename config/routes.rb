Rails.application.routes.draw do
  root 'supporters#new'

  resources :supporters

  get '/thanks', to: 'pages#thanks', as: :thanks
  get '/cities_autocomplete', to: 'cities_autocomplete#index', as: :cities_autocomplete
  get '/map', to: 'pages#map', as: :map
end
