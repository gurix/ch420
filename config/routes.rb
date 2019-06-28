Rails.application.routes.draw do
  devise_for :supporters
  root to: 'supporters#new'

  get "/pages/:page" => "pages#show"

  namespace :admin do
    get '/map', to: 'pages#map', as: :map
    resources :publicities
    # resources :supporters, only: :index
  end

  localized do
    #resources :greendays
    get '/initiative_text', to: 'pages#show', as: :initiative_text, page: 'initiative_text'
    get '/terms_and_conditions', to: 'pages#show', as: :terms_and_conditions, page: 'terms_and_conditions'
    #get '/donation', to: 'pages#show', as: :donation, page: 'donation'
  end

  get '/cities_autocomplete', to: 'cities_autocomplete#index', as: :cities_autocomplete
  scope '/:locale',  locale: /de|it|fr/ do
    get '/', to: 'supporters#new'
    resources :supporters, only: [:new, :create]
    resource :publicity
    get '/thanks', to: 'pages#thanks', as: :thanks
    resources :charges
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
