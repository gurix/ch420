Rails.application.routes.draw do
  root 'supporters#new'

  namespace :admin do
    get '/map', to: 'pages#map', as: :map
    # resources :supporters, only: :index
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '/cities_autocomplete', to: 'cities_autocomplete#index', as: :cities_autocomplete
  scope '/:locale' do
    get '/', to: 'supporters#new'
    resources :supporters

    get '/thanks', to: 'pages#thanks', as: :thanks
  end
end
