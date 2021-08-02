Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about', to: 'homes#about'
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followed_users' => 'relationships#followed_users', as: 'followed_users'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books do
    resources :book_comments, onle: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

end