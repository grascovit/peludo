# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions',
    confirmations: 'confirmations',
    omniauth_callbacks: 'omniauth_callbacks'
  }

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      }

      resources :attachments, only: %i[destroy]
      resources :breeds
      resources :pets

      namespace :me do
        resources :pets, only: %i[index]
      end

      namespace :omniauth do
        post :google_oauth2
      end

      resources :pets, only: [] do
        resources :contact_logs, only: %i[create], controller: 'pets/contact_logs'
      end
    end
  end

  resources :lost_pets
  resources :found_pets
  resources :pets_for_adoption
  resources :pets, only: [] do
    resources :contact_logs, only: %i[create show], controller: 'pets/contact_logs'
  end

  get :home, controller: :static_pages

  root to: 'static_pages#home'
end
