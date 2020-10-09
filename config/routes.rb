Rails.application.routes.draw do
  devise_for :users
   devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'about' => 'homes#about'
  get 'search' => 'searches#search'
  resources :posts, except: [:edit, :update] do
  	resource :likes, only: [:create, :destroy]
  	resources :comments, only: [:create, :destroy]
  end
  resources :users, except: [:index, :new, :create, :destroy] do
    get 'like' => 'users#like'
    get 'follow_index' => 'users#follow_index'
  end
  resources :sake_breweries, only: [:show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :tags, only: [:show]
end
