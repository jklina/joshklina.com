Rails.application.routes.draw do
  namespace :admin do
    resources :posts
    resources :tags
    get    'login'   => 'sessions#new'
    post   'login'   => 'sessions#create'
    delete 'logout'  => 'sessions#destroy'
  end

  resources :posts, only: [:show]
  resources :tags, only: [:show]
  resources :book_reviews, only: [:index]

  root to: 'posts#index'
end
