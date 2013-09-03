Pickem::Application.routes.draw do
  resources :pages

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :currencies
  resources :users
  resources :weeks do
    resources :comments
    member do
      get :score
    end
  end
  resources :comments do
    member do
      get :publish
      get :cancel
    end
  end
  
  root 'seasons#index'
  get '/:year/:week/' => 'weeks#show'
  post '/:year/:week/' => 'comments#update'
  

end
