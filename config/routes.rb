Rails.application.routes.draw do
  
  root to: 'items#index'

  devise_for :users
  
resources :items
  
  get "up" => "rails/health#show", as: :rails_health_check
end
