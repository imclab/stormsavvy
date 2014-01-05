require 'sidekiq/web'

Stormsavvy::Application.routes.draw do

  get "main/index"
  get "static_pages/index"
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  root to: 'dashboard#index'
  # root to: 'sites#users_sites'

  get "alert_pages/sender"
  get "alert_pages/thankyou"
  get "dashboard/index"
  get "noaa/secret"
  get "sites", :to => "sites#users_sites"

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

  resources :projects,
    :sites,
    :sampling_events,
    :inspection_events,
    :weather_events,
    :reports,
    :locations

  # Projects controller needs #show, redirect to root instead,
  # place before nested resource so that it is mapped properly.
  # get '/projects', :to => "dashboard#index"

  # Breaks current_user projects in dashboard view
  # resources :projects, except: [:index] do
  #   resources :sites
  #   root to: "dashboard#index"
  # end

  ReportsController::STATIC_REPORTS.each do |name|
    get "/reports/#{name}" => "reports##{name}"
    # match "/reports/#{name}" => "reports##{name}"
  end

  get '/index',     :to => "pages#index"#,          :as => :index
  get '/about',     :to => "pages#about"#,          :as => :about
  get '/terms',     :to => "pages#terms"#,          :as => :terms
  get '/faq',       :to => "pages#faq"#,            :as => :faq
  get '/privacy',   :to => "pages#privacy"#,        :as => :privacy
  get '/contact',   :to => "pages#contact"#,        :as => :contact
  get '/plans',     :to => "pages#plans"#,          :as => :plans
  get '/features',  :to => "pages#features"#,       :as => :features
  get '/team',      :to => "pages#team"#,           :as => :team
  get '/pdf',       :to => "pages#pdf"#,            :as => :pdf

  mount Sidekiq::Web, at: "/sidekiq"
end
