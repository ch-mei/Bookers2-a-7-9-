Rails.application.routes.draw do
  devise_for :users

  get '/search', to: 'searches#search'

  root 'homes#top'
  get 'home/about', to: 'homes#about'
  
  get 'chat/:id' => 'chats#show', as: 'chat'

  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :books do
    resources :book_comments, onle: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :chats, only: [:create, :show]

end