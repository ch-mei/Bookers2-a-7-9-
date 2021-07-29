Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about', to: 'homes#about'
  resources :users, only: [:show, :index, :edit, :update]
  resources :books do
    resources :book_comments, onle: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

end