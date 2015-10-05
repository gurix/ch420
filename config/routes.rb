Rails.application.routes.draw do
  root 'supporters#new'

  resources :supporters

  get '/thanks', to: 'pages#thanks', as: :thanks
end
