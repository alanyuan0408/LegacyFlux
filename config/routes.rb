Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { :registration => "registrations" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resources :users
  resources :feedbanks

  # The priority is based upon order of creation:
  # first created -> highest priority.  get "home" => "static_pages#home"

    # You can have the root of your site routed with "root"
  root to: 'static_pages#home'

  post '/update', to: 'users#edit'

  get '/developer',  to: 'static_pages#developer'
  get '/jobs',     to: 'static_pages#jobs'
  get '/useraccount',   to: 'static_pages#useraccount'
  get '/expo', to: 'static_pages#expo'
  get '/home',      to: 'static_pages#home'
  get '/event',      to: 'static_pages#events'
  get '/news',      to: 'static_pages#news'
  get '/research',      to: 'static_pages#research'
  post '/request', to: 'users#request_creator'

  post '/register_expo', to: 'users#register_expo'
  post '/unregister_expo', to: 'users#unregister_expo'

  match '/student_account', to: 'users#student_account', via: [:get, :post]
  match '/creator_account', to: 'users#creator_account', via: [:get, :post]
  get '/user_info', to: 'users#show'

  get '/approve', to: 'users#approve_creator'
  get '/request', to: 'users#request_creator'
  get '/certify', to: 'users#certify'
  
  get "/404" => 'users#permissiondenied'
  get "/500" => 'users#permissiondenied'

  get "/feedcreate" => 'feedbanks#create'
  get "/feedapprove" => 'feedbanks#approve_content'
  get "/feeddisapprove" => 'feedbanks#disapprove_content'


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
end
