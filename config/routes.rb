Rails.application.routes.draw do
  get 'tags/show'

  namespace :admin do
    resources :posts
    resources :tags
    get    'login'   => 'sessions#new'
    post   'login'   => 'sessions#create'
    delete 'logout'  => 'sessions#destroy'
  end

  resources :posts, only: [:show]
  resources :tags, only: [:show]

  root to: 'posts#index'
end
