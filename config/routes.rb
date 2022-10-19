# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks, except: [:index] do
    member do
      post :change_state
    end
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
    resources :users
  end
end
