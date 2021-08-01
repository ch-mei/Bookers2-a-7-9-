Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about', to: 'homes#about'
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'following_user' => 'relationships#following_user', as: 'following_user'
    get 'follower_user' => 'relationships#follower_user', as: 'follower_user'
  end
  resources :books do
    resources :book_comments, onle: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

end