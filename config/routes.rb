# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }
  devise_for :employees, path: 'employees', controllers: {
    sessions: 'employees/sessions',
    registrations: 'employees/registrations'
  }

  devise_scope :admin do
    get 'admins', to: 'admins/sessions#new'
    authenticated :admin do
      namespace :admins do
        resources :kudos
        resources :employees
        resources :company_values
        resources :rewards
        get 'pages/dashboard', as: :authenticated_root
      end
    end
  end

  resources :kudos
  root 'kudos#index'

end
