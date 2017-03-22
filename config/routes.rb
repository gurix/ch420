Rails.application.routes.draw do
  root to: redirect("/#{I18n.default_locale}")

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
    get '/spenden', to: 'pages#spenden', as: :spenden
    get '/terms_and_conditions', to: 'pages#terms_and_conditions', as: :terms_and_conditions
  end
end
