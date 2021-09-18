Rails.application.routes.draw do
  devise_for :users
  root to: "tops#index"
  get 'users/search'
  resources :tops, only: :index
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end
  get 'direct_message/:id' => 'direct_messages#show', as: 'direct_message'
  resources :direct_messages, only: [:create]
end
