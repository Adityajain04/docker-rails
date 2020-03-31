Rails.application.routes.draw do
  devise_for :users,  :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" }
  root 'home#index'

  namespace :admin do
    get '/normal_users', to: 'users#normal_users'
    get '/admin_users', to: 'users#admin_users'
    resources :users, only: [:edit, :update]
    resources :roles, :products, :categories, :brands, :stores, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :attributes, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :attribute_values, only: [:index, :new, :create, :edit, :update, :destroy]
    end
  end
end
