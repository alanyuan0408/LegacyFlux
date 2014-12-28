Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resources :users
  resources :feedbanks
  resources :sessions, only: [:new, :create, :destroy]

  # The priority is based upon order of creation:
  # first created -> highest priority.  get "home" => "static_pages#home"

    # You can have the root of your site routed with "root"
  root to: 'static_pages#home'

  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  get '/signout', to: 'sessions#destroy'
  get '/update', to: 'users#edit'

  get '/developer',  to: 'static_pages#developer'
  get '/jobs',     to: 'static_pages#jobs'
  get '/useraccount',   to: 'static_pages#useraccount'
  get '/entrepreneur', to: 'static_pages#entrepreneur'
  get '/home',      to: 'static_pages#home'
  get '/event',      to: 'static_pages#events'
  get '/news',      to: 'static_pages#news'
  get '/research',      to: 'static_pages#research'
  
  get '/register_expo', to: 'users#register_expo'
  get '/unregister_expo', to: 'users#unregister_expo'

  get '/student_account', to: 'users#student_account'
  get '/creator_account', to: 'users#creator_account'

  get '/approve', to: 'users#approve_creator'
  get '/request', to: 'users#request_creator'
  get '/certify', to: 'users#certify'

  get '/confirmation_token', to: 'users#confirmation_token'
  
  get "/404" => 'users#permissiondenied'
  get "/500" => 'users#permissiondenied'

  get "/feedbanks" => 'feedbanks#show'
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
