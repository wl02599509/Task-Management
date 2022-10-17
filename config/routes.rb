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
end
