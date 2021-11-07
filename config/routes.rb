# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/index'
  root to: 'homes#index'
  devise_for :users
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
