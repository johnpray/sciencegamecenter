SciencegamereviewsOrg::Application.routes.draw do

  root :to => 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/privacy', to: 'static_pages#privacy'
  get '/review', to: 'static_pages#review'
  get '/jam', to: 'static_pages#jam'
  get '/forum_approval', to: 'static_pages#forum_approval'
  get '/robots.txt', to: 'static_pages#robots'

  resources :users do
    member do
      get 'resend_parent_email'
      get 'confirm_child_account'
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets
  resources :games do
    resources :screenshots, shallow: true
  end
  resources :subjects, only: :index
  resources :platforms, only: :index
  resources :player_reviews
  resources :comments

  resources :stats, only: :index

  post "versions/:id/revert" => "versions#revert", as: 'revert_version'

  get '/signup',  to: 'users#new'
  get '/login',   to: 'sessions#new'
  delete '/logout',  to: 'sessions#destroy'

  get '/sso/discourse', to: 'sso#discourse'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
