Pickem::Application.routes.draw do
  resources :pages

  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :currencies
  resources :users
  resources :seasons do
    member do
      get :join
    end
  end
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
  
  root 'seasons#latest'
  get '/:year/:week/' => 'weeks#show'
  post '/:year/:week/' => 'comments#update'
  

end
