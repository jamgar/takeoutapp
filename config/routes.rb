Rails.application.routes.draw do
  resources :order_items
  resources :orders
  resources :carts do
    resources :cart_items
  end
  resources :menu_items
  resources :categories
  get 'customers/menu'
  get 'customers/checkout'
  get 'customers/confirmation/:id', to: 'customers#confirmation', as: 'customers/confirmation'

  root'customers#index'
end
