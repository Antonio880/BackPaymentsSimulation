Rails.application.routes.draw do
  resources :pix_transactions, only: [:create, :index, :destroy]
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
