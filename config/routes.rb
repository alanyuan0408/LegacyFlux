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
  
  patch '/update', to: 'users#change'
  patch '/add_tidbit', to: 'users#add_tidbit'
  patch '/savechange', to: 'users#modify'
  patch '/user_nav', to: 'users#mail_nav'
  patch '/addNewsItem', to: 'users#add_newsItem'
  patch '/removeNewsItem', to: 'users#remove_newsItem'
  patch '/deleteNewsItem', to: 'users#mail_delete_dependencies'

  get '/developer',  to: 'static_pages#developer'
  get '/jobs',     to: 'static_pages#jobs'
  get '/useraccount',   to: 'static_pages#useraccount'
  get '/expo', to: 'static_pages#expo'
  get '/home',      to: 'static_pages#home'
  get '/event',      to: 'static_pages#events'
  get '/news',      to: 'static_pages#news'
  get '/research',      to: 'static_pages#research'

  post '/register_expo', to: 'users#register_expo'
  post '/unregister_expo', to: 'users#unregister_expo'

  match '/student_account', to: 'users#student_account', via: [:get, :post]
  match '/disable_student', to: 'users#disable_student_account', via: [:get, :post]

  get '/user_info', to: 'users#show'
  patch '/generate_newsletter', to: 'users#generate_newsLetter'
  
  get "/404" => 'users#permissiondenied'
  get "/500" => 'users#permissiondenied'

  get "/feedcreate" => 'feedbanks#create'
  patch "/feedapprove" => 'feedbanks#approve_content'
  patch "/feeddisapprove" => 'feedbanks#disapprove_content'

  match '/confirmation_token', to: 'users#confirmation_token', via: [:get, :post]


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
