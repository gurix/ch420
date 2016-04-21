Rails.application.routes.draw do
  root 'supporters#new'
  scope "/:locale" do
    get '/', to: 'supporters#new'
    resources :supporters

    get '/thanks', to: 'pages#thanks', as: :thanks
  end
  
  get '/cities_autocomplete', to: 'cities_autocomplete#index', as: :cities_autocomplete

  namespace :admin do
    get '/map', to: 'pages#map', as: :map

    resources :supporters, only: :index
  end
end
