Stormsavvy::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  get "alert_pages/sender"
  get "alert_pages/thankyou"
  get "dashboard/index"

  get "sites", :to => "sites#users_sites"
  root to: "sites#users_sites"

  resource :location, only: [:index, :new, :create]

  get "noaa/secret"

  namespace :pdf do
    get "CEM2030"
    get "CEM2034"
    get "CEM2035"
    get "CEM2040"
    get "CEM2045"
    get "CEM2050"
    get "CEM2051"
    get "CEM2052"
    get "CEM4601"
  end

  resources :sites,
    :sampling_events,
    :inspection_events,
    :weather_events,
    :reports,
    :locations

  # Projects controller needs #show, redirect to root instead,
  # place before nested resource so that it is mapped properly.
  # get '/projects', :to => "dashboard#index"

  resources :projects, except: [:index] do
    resources :sites
    root to: "dashboard#index"
  end

  ReportsController::STATIC_REPORTS.each do |name|
    match "/reports/#{name}" => "reports##{name}"
  end

  match '/index',     :to => "pages#index",          :as => :index
  match '/about',     :to => "pages#about",          :as => :about
  match '/terms',     :to => "pages#terms",          :as => :terms
  match '/faq',       :to => "pages#faq",            :as => :faq
  match '/privacy',   :to => "pages#privacy",        :as => :privacy
  match '/contact',   :to => "pages#contact",        :as => :contact
  match '/plans',     :to => "pages#plans",          :as => :plans
  match '/features',  :to => "pages#features",       :as => :features
  match '/team',      :to => "pages#team",           :as => :team
  match '/pdf',       :to => "pages#pdf",            :as => :pdf

  root :to => "dashboard#index"

end
