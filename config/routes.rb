Rails.application.routes.draw do
  mount Exposition::Engine, at: "/"
  namespace :admin do
    resources :book_reviews
    resources :tools
  end

  resources :book_reviews, only: [:index]
  resources :tools, only: [:index]

  # Mapping high voltage to custom controller
  get "/pages/*id" => 'pages#show', as: :page, format: false
end
