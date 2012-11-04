Stormsavvy::Application.routes.draw do

  get "alert_pages/sender"

  get "alert_pages/thankyou"

  get "dashboard/index"

  get "sites", :to => "sites#users_sites"

  get "location/index"
  get "location/new"
  get "location/create"
  get "noaa/secret"

  resources :inspection_events
  resources :weather_events
  resources :reports 
  resources :locations

  ReportsController::STATIC_REPORTS.each do |name|
    match "/reports/#{name}" => "reports##{name}"
  end

  # Projects controller needs #show, redirect to root instead.
  match '/projects' => 'dashboard#index', :via => :get

  resources :user do
    resources :projects do
      resources :sites
    end
  end

  match '/footer',    :to => "pages#footer",         :as => :footer

  match '/index',     :to => "pages#index",          :as => :index
  match '/about',     :to => "pages#about",          :as => :about
  match '/terms',     :to => "pages#terms",          :as => :terms
  match '/faq',       :to => "pages#faq",            :as => :faq
  match '/privacy',   :to => "pages#privacy",        :as => :privacy
  match '/contact',   :to => "pages#contact",        :as => :contact
  match '/plans-and-pricing',  :to => "pages#plans", :as => :plans
  match '/features',  :to => "pages#features",       :as => :features
  match '/team',      :to => "pages#team",           :as => :team
  match '/popemail',  :to => "pages#popemail",       :as => :popemail
  match '/sendemail', :to => "pages#sendemail",      :as => :sendemail

  devise_for :users

  root :to => "dashboard#index"

end
