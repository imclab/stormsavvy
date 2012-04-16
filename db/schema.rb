# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120416032616) do

  create_table "dashboards", :force => true do |t|
    t.integer  "user_id"
    t.text     "preferences"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "inspection_events", :force => true do |t|
    t.integer  "site_id"
    t.string   "type"
    t.text     "description"
    t.datetime "date"
    t.datetime "submitted"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "locations", :force => true do |t|
    t.integer  "zipcode"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
  end

  add_index "locations", ["zipcode"], :name => "index_locations_on_zipcode"

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.date     "startdate"
    t.date     "finishdate"
    t.boolean  "active"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rain_event_workflows", :force => true do |t|
    t.integer  "hours_before_rain"
    t.boolean  "reap"
    t.boolean  "cem2030"
    t.boolean  "ph_sample"
    t.boolean  "turbidity"
    t.boolean  "report_sent"
    t.boolean  "report_received"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "chance_of_rain"
    t.float    "amount_of_rain"
  end

  create_table "reports", :force => true do |t|
    t.datetime "created_at",                                                                      :null => false
    t.datetime "updated_at",                                                                      :null => false
    t.string   "type"
    t.integer  "site_id"
    t.string   "project_id"
    t.string   "site_information_name"
    t.string   "site_address_1"
    t.string   "site_address_2"
    t.string   "site_city"
    t.string   "site_state"
    t.integer  "site_zipcode"
    t.string   "contractor_name"
    t.string   "contractor_address_1"
    t.string   "contractor_address_2"
    t.string   "contractor_city"
    t.string   "contract_number"
    t.string   "project_identifer_number"
    t.string   "wdid_number"
    t.integer  "project_risk_level"
    t.string   "inspector_name"
    t.date     "date_of_inspection"
    t.string   "weather_condition"
    t.string   "precipitation_condition"
    t.string   "wind_condition"
    t.string   "construction_phase"
    t.decimal  "site_information_acres_total_project_area"
    t.decimal  "site_information_acres_total_project_disturbed_soil_area"
    t.decimal  "site_information_acres_current_phase_disturbed_soil_area"
    t.decimal  "site_information_acres_current_phase_inactive_disturbed_soil_area"
    t.string   "inspection_type"
    t.string   "storm_information_time_elapsed_since_last_storm"
    t.datetime "storm_information_time_storm_is_expected"
    t.decimal  "storm_information_time_elapsed_since_storm_began"
    t.decimal  "storm_information_time_elapsed_since_storm"
    t.decimal  "storm_information_percipitation_amount_from_storm_recorded_from_site_rain_gauge"
    t.string   "status"
    t.date     "submitted_by_contractor"
    t.date     "submitted_by_date"
    t.string   "wpc_manager"
    t.string   "wpc_phone"
    t.string   "wpc_emergency_phone"
    t.date     "inspection_date"
    t.decimal  "total_area"
    t.decimal  "total_DSA"
    t.decimal  "current_DSA"
    t.decimal  "inactive_DSA"
    t.decimal  "time_elapsed_last_storm"
    t.decimal  "precipitation_received"
    t.decimal  "time_storm_expected"
    t.decimal  "expected_precipitation_amount"
    t.decimal  "time_elapsed_during_storm"
    t.decimal  "gauge_reading_during_storm"
    t.decimal  "time_elapsed_post_storm"
    t.decimal  "gauge_reading_post_storm"
    t.string   "contractor_state"
    t.integer  "contractor_zipcode"
    t.string   "water_pollution_control_manager_name"
    t.string   "water_pollution_control_manager_company_name"
    t.string   "water_pollution_control_manager_phone_number"
    t.string   "water_pollution_control_manager_emergency_phone_number"
    t.decimal  "storm_information_expected_precipitation_amount"
    t.decimal  "storm_information_precipitation_amount_from_last_form"
  end

  create_table "site_pops", :force => true do |t|
    t.datetime "date"
    t.integer  "pop"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "costcode"
    t.string   "size"
    t.string   "exposed_area"
    t.string   "location"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "zipcode"
    t.float    "lat"
    t.float    "long"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "risk_level"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "contractor_name"
    t.string   "contractor_address_1"
    t.string   "contractor_address_2"
    t.string   "contractor_city"
    t.string   "contractor_state"
    t.string   "contractor_zipcode"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "weather_events", :force => true do |t|
    t.integer  "site_id"
    t.datetime "eventdate"
    t.float    "duration"
    t.float    "rainfall"
    t.boolean  "inspected"
    t.boolean  "qualifying"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "workflows", :force => true do |t|
    t.integer  "hours_before_rain"
    t.boolean  "reap"
    t.boolean  "cem2030"
    t.boolean  "ph_sample"
    t.boolean  "turbidity"
    t.boolean  "report_sent"
    t.boolean  "report_received"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
