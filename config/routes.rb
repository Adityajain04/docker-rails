Rails.application.routes.draw do
  devise_for :users,  :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" }
  root 'home#index'

  namespace :admin do
    get '/normal_users', to: 'users#normal_users'
    get '/admin_users', to: 'users#admin_users'
  end
end
