Stormsavvy::Application.routes.draw do

  get "dashboard/index"
  get "dashboard/edit"

  get "sites", :to => "sites#users_sites"

  get "location/index"

  get "location/new"

  get "location/create"

  resources :inspection_events
  resources :weather_events

  resources :projects do
    resources :sites
  end



  resources :locations

  get "pages/index"

  match '/about',    :to => "pages#about", :as => :about
  match '/terms',    :to => "pages#terms", :as => :terms
  match '/faq',      :to => "pages#faq", :as => :faq
  match '/privacy',  :to => "pages#privacy", :as => :privacy
  match '/contact',  :to => "pages#contact", :as => :contact
  match '/plans-and-pricing',  :to => "pages#plans", :as => :plans
  match '/features',  :to => "pages#features", :as => :features

  devise_for :users
  # This is not needed when the sign_out method is changed from
  # :delete to :get in config/initializers/devise.rb
  # devise_for :users do get '/users/sign_out' => 'devise/sessions#destroy' end


  root :to => "dashboard#index"

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
