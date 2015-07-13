Rails.application.routes.draw do
  namespace :admin do
    resources :posts
    get    'login'   => 'sessions#new'
    post   'login'   => 'sessions#create'
    delete 'logout'  => 'sessions#destroy'
  end

  resources :posts, only: [:show]

  root to: 'posts#index'
end
