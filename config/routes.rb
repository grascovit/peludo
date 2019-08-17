# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :lost_pets
  resources :found_pets
  resources :contact_logs, only: %i[create show]

  root to: 'found_pets#index'
end
