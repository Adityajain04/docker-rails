# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root 'home#index'

  namespace :admin do
    get '/normal_users', to: 'users#normal_users'
    get '/admin_users', to: 'users#admin_users'
    resources :users, only: %i[edit update]
    resources :roles, only: %i[index new create edit update destroy]
    resources :categories, only: %i[index new create edit update destroy] do
      member do
        put '/change_status', to: 'categories#change_status'
      end
    end
    resources :brands, only: %i[index new create edit update destroy] do
      member do
        put '/change_status', to: 'brands#change_status'
      end
    end
    resources :stores, only: %i[index new create edit update destroy] do
      member do
        put '/change_status', to: 'stores#change_status'
      end
    end
    resources :products, only: %i[index new create edit update destroy] do
      member do
        delete '/remove_attachment/:attachment_id', to: 'products#remove_attachment'
      end
    end
    resources :attributes, only: %i[index new create edit update destroy] do
      member do
        put '/change_status', to: 'attributes#change_status'
      end
      resources :attribute_values, only: %i[index new create edit update destroy]
    end
    resources :attribute_values, only: [] do
      member do
        put '/change_status', to: 'attribute_values#change_status'
      end
    end
  end
end
