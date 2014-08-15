Rorshop::Application.routes.draw do
  resources :search_suggestions, :users, :shopping_carts
  post 'sessions/create', as: 'login'
  get 'sessions/destroy', as: 'logout'
  root 'products#welcome'
  get 'products/index'
  get 'products/:id/' => 'products#show', as: 'product'
  get 'products/filter'
  get '/shopping_carts/remove_item/:product_id', to: 'shopping_carts#remove_item', as: 'remove_item'
  get '/shopping_cart/order', to: 'shopping_carts#order', as: 'order'

  # Example resource route within a namespace:
  namespace :admin do
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    resources :products, :types
    post 'type_values_controller/create'
  end

end