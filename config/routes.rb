Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  # =========================================
  # resources :admin

  # get 'pages', controller: 'pages'
  # 
  # get 'pages/:controller'
  
  # namespace :pages do
  #   # Directs /pages/products/* to Pages::ProductsController
  #   # (app/controllers/pages/products_controller.rb)
  #   resources :products
  # end
  
  namespace :admin do
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    get 'settings/:action', controller: 'settings'
    resources :settings
    resources :users
    resources :roles
  end
  
  resources :pages, only: [:index] do
    # resources :charts, :tables, :forms
    # resource :seller
  end
  
  # resources :charts, only: [:index] do 
  #   get 'flot' => 'charts#flot'
  #   get 'morris', action: 'morris'
  # end
  
  # get 'tables/:action', controller: 'tables', action: 'index'
  # get 'forms/:action', controller: 'forms'
  get 'elements/:action', controller: 'elements'
  get 'dropdowns/:action', controller: 'dropdowns'
  get 'samples/:action', controller: 'samples'

  get 'contents/:action', controller: 'contents'

  resources :charts
  resources :forms
  resources :tables
  
  resources :banners  
  resources :news
  resources :galleries
  resources :events
  
  resources :categories
  
  post 'admin/login', controller: 'admin', action: 'authenticate'
  post 'admin/signup', controller: 'admin', action: 'register'
  post 'admin/profile', controller: 'admin', action: 'update_profile'
  
  get 'admin/:action', controller: 'admin', as: 'admin_action'

  post 'banners/sort', controller: 'banners', action: 'sort'
  post 'categories/sort', controller: 'categories', action: 'sort'

  get 'charts/:action', controller: 'charts'
  
  get '/', controller: 'admin', action: 'index'  
end
