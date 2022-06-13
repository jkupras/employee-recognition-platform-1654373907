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

  # devise_scope :employee do
  #   authenticated :employee do
  #     namespace :employees do
  #       get 'kudos/index', as: :authenticated_root
  #     end
  #   end
  # end

  devise_scope :admin do
    get "admins", to: "devise/sessions#new"
    authenticated :admin do
      namespace :admins do
        resources :kudos
        get 'pages/dashboard', as: :authenticated_root
      end
    end
  end

  resources :kudos
  root 'kudos#index'

end
