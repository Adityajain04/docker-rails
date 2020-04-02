# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root 'home#index'

  namespace :admin do
    get '/normal_users', to: 'users#normal_users'
    get '/admin_users', to: 'users#admin_users'
    resources :users, only: %i[edit update]
    resources :roles, :categories, :brands, :stores, only: %i[index new create edit update destroy]
    resources :products, only: %i[index new create edit update destroy] do
      member do
        delete '/remove_attachment/:attachment_id', to: 'products#remove_attachment'
      end
    end
    resources :attributes, only: %i[index new create edit update destroy] do
      resources :attribute_values, only: %i[index new create edit update destroy]
    end
  end
end
