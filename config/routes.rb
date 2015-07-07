Rails.application.routes.draw do
  namespace :admin do
    resources :posts
  end

  resources :post, only: [:show]

  root to: 'home#index'
end
