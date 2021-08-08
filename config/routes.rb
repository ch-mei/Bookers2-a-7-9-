Rails.application.routes.draw do
  get 'searches/search'
  devise_for :users
  root 'homes#top'
  get 'home/about', to: 'homes#about'
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:create, :show, :index]
  resources :books do
    resources :book_comments, onle: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get '/search', to: 'searches#search'

end