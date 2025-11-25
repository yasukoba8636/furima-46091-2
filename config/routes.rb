Rails.application.routes.draw do
  
  root to: 'items#index'

  devise_for :users
  
 resources :items, only: [:index, :show, :new, :create, :edit, :update, :destroy]
 
resources :items do
  resource :order, only: [:new, :create]  # singular resource: /items/:item_id/order
end

end
