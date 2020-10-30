Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'about' => 'homes#about'
  get 'search' => 'searches#search'
  get 'today_show' => 'posts#today_show'
  resources :posts, except: %i[edit update] do
    resource :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end
  resources :users, except: %i[index new create destroy] do
    get 'like' => 'users#like'
    get 'follow_index' => 'users#follow_index'
    get 'follow_timeline' => 'posts#follow_timeline'
  end
  resources :sake_breweries, only: %i[show edit update]
  resources :relationships, only: %i[create destroy]
  resources :tags, only: [:show]
end
