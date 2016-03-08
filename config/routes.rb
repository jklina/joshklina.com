Rails.application.routes.draw do
  mount Exposition::Engine, at: "/"
  namespace :admin do
    resources :book_reviews
  end
  #
  # resources :tags, only: [:show]
  resources :book_reviews, only: [:index]
end
