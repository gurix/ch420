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
    get '/initiative_text', to: 'pages#show', as: :initiative_text, page: 'initiative_text'
    get '/arguments', to: 'pages#show', as: :arguments, page: 'arguments'
    get '/faq', to: 'pages#show', as: :faq, page: 'faq'
    get '/terms_and_conditions', to: 'pages#show', as: :terms_and_conditions, page: 'terms_and_conditions'
    get '/sponsoring', to: 'pages#show', as: :sponsoring, page: 'sponsoring'
    get '/numbers', to: 'pages#show', as: :numbers, page: 'numbers'
  end

  get '/cities_autocomplete', to: 'cities_autocomplete#index', as: :cities_autocomplete
  scope '/:locale' do
    get '/', to: 'supporters#new'
    resources :supporters
    resource :publicity
    get '/thanks', to: 'pages#thanks', as: :thanks
    get '/spenden', to: 'pages#spenden', as: :spenden
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
