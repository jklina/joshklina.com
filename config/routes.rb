Rails.application.routes.draw do
  namespace :admin do
    resources :posts
  end

  resources :posts, only: [:show]

  root to: 'posts#index'
end
