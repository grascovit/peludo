# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions',
    confirmations: 'confirmations'
  }

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      }
    end
  end

  resources :lost_pets
  resources :found_pets
  resources :pets_for_adoption
  resources :contact_logs, only: %i[create show]

  get :home, controller: :static_pages

  root to: 'static_pages#home'
end
