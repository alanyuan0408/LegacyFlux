Rails.application.routes.draw do
  devise_for :users, :controllers => { :registration => "registrations", :omniauth_callbacks => "users/omniauth_callbacks"}
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
  
  patch '/add_tidbit', to: 'users#add_tidbit'
  patch '/addNewsItem', to: 'users#add_newsItem'
  patch '/removeNewsItem', to: 'users#remove_newsItem'
  patch '/deleteNewsItem', to: 'users#mail_delete_dependencies'
  patch '/send_mail', to: 'users#send_mail'

  get '/developer',  to: 'static_pages#developer'
  get '/jobs',     to: 'static_pages#jobs'
  get '/expo', to: 'static_pages#expo'
  get '/home',      to: 'static_pages#home'
  get '/news',      to: 'static_pages#news'
  match '/mailing',      to: 'static_pages#mailing', via: [:get, :post]

  post '/modify_user_setting', to: 'users#user_update'
  post '/modify_date', to: 'users#user_date'
  post '/check_admin_updates', to: 'users#admin_updates'
  post '/request_information', to: 'users#request_info'
  post '/approve_post', to: 'users#post_approval'

  post '/search_feedbank', to: 'feedbanks#search_feedbank'
  post '/search_suggestion', to: 'feedbanks#search_suggestion' 
   
  get '/usersetting',   to: 'users#usersetting'

  match '/student_account', to: 'users#student_account', via: [:get, :post]
  match '/disable_student', to: 'users#disable_student_account', via: [:get, :post]

  match '/user_info', to: 'users#add_post', via: [:get, :post]
  get '/user_admin', to: 'users#adminPanel'
  get '/user_mail', to: 'users#mailPanel'
  patch '/generate_newsletter', to: 'users#generate_newsLetter'
  patch '/generate_newsletter_md', to: 'users#generate_newsLetter_md'
  
  get "/404" => 'users#permissiondenied'
  get "/500" => 'users#permissiondenied'

  get "/feedcreate" => 'feedbanks#create'
  patch "/feedapprove" => 'feedbanks#approve_content'
  patch "/feeddisapprove" => 'feedbanks#disapprove_content'
  get '/feedbanks/:id', to: 'feedbanks#show'

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
