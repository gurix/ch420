Rails.application.routes.draw do
  devise_for :supporters
  root to: 'supporters#new' 

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get "/pages/:page" => "pages#show"

  namespace :admin do
    get '/map', to: 'pages#map', as: :map
    # resources :supporters, only: :index
  end

  localized do
    get '/initiative_text', to: 'pages#show', as: :initiative_text, page: 'initiative_text'
    get '/arguments', to: 'pages#show', as: :arguments, page: 'arguments'
  end

  get '/cities_autocomplete', to: 'cities_autocomplete#index', as: :cities_autocomplete
  scope '/:locale' do
    get '/', to: 'supporters#new'
    resources :supporters
    get '/thanks', to: 'pages#thanks', as: :thanks
    get '/spenden', to: 'pages#spenden', as: :spenden
    get '/terms_and_conditions', to: 'pages#terms_and_conditions', as: :terms_and_conditions
  end
end
