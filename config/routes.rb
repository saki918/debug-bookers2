Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about' 
  resources :users,only: [:show,:index,:edit,:update]
  resources :relationships, only: [:create, :destroy, :show, :index]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
end
