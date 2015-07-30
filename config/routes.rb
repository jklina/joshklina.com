Rails.application.routes.draw do
  namespace :admin do
    resources :posts
    resources :tags
    get    'login'   => 'sessions#new'
    post   'login'   => 'sessions#create'
    delete 'logout'  => 'sessions#destroy'
  end

  resources :posts, only: [:show]

  root to: 'posts#index'
end
