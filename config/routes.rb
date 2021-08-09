Rails.application.routes.draw do
  devise_for :users

  get '/search', to: 'searches#search'

  root 'homes#top'
  get 'home/about', to: 'homes#about'

  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :books do
    resources :book_comments, onle: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :messages, only: [:create, :show]

end