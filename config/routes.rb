# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tasks#index'
  
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'

  resources :tasks, except: [:index] do
    member do
      post :change_state
    end
    resources :tags
  end
  resources :searches, only: [:index]
  resources :priorities, only: [:index]
  resources :users, only: [:create] do
    collection do
      get :sign_up
      get :sign_in
    end
  end
  resources :sessions, only: [:create, :destroy]

  namespace :admin, path: "admin" do
    resources :users, except: [:show] do
      resources :tasks, only: [:index]
    end
  end
end
