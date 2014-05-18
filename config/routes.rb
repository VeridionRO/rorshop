Rorshop::Application.routes.draw do
  resources :users
  post 'sessions/create', as: 'login'
  get 'sessions/destroy', as: 'logout'
  root 'products#welcome'
  get 'products/index'
  get 'product/:id/' => 'products#show'
  get 'products/filter'

  # Example resource route within a namespace:
  namespace :admin do
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    resources :products, :types
  end

end