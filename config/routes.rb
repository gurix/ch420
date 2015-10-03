Rails.application.routes.draw do
  root 'supporters#new'

  resources :supporters
end
