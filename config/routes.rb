Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update]
  resources :books
  root 'homes#top'
  get 'homes/about' => 'homes#about'
end