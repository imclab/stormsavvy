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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140127163244) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "dashboards", force: true do |t|
    t.integer  "user_id"
    t.text     "preferences"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "forecast_periods", force: true do |t|
    t.datetime "forecast_prediction_time"
    t.integer  "temperature"
    t.integer  "dewpoint"
    t.integer  "rh"
    t.integer  "sky_cover"
    t.integer  "wind_speed"
    t.integer  "wind_direction"
    t.integer  "wind_gust"
    t.integer  "pop"
    t.float    "qpf"
    t.float    "snow_amount"
    t.integer  "snow_level"
    t.string   "wx"
    t.integer  "site_id"
    t.integer  "weather_update_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "forecast_periods", ["site_id"], name: "index_forecast_periods_on_site_id"
  add_index "forecast_periods", ["weather_update_id"], name: "index_forecast_periods_on_weather_update_id"

  create_table "inspection_event_workflows", force: true do |t|
    t.integer  "hours_before_rain"
    t.boolean  "reap"
    t.boolean  "cem2023"
    t.boolean  "cem2024"
    t.boolean  "cem2034"
    t.boolean  "cem2035"
    t.boolean  "cem2040"
    t.boolean  "pre_storm_inspection"
    t.boolean  "during_storm_inspection"
    t.boolean  "post_storm_inspection"
    t.boolean  "report_sent"
    t.boolean  "report_received"
    t.boolean  "ph_sample"
    t.boolean  "turbidity"
    t.boolean  "notice_of_discharge"
    t.boolean  "quarterly_inspction"
    t.integer  "chance_of_rain"
    t.float    "amount_of_rain"
    t.float    "forecast_rain"
    t.boolean  "inspection_event"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "site_id"
  end

  create_table "inspection_events", :force => true do |t|
    t.integer  "site_id"
    t.string   "inspection_type"
    t.text     "inspection_description"
    t.datetime "inspection_date"
    t.string   "submitted_by"
    t.string   "inspected_by"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "status"
    t.boolean  "completed"
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
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "sites_count", :default => 0, :null => false
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
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "site_id"
    t.string   "project_id"
    t.string   "inspection_type"
    t.string   "status"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "sampling_event_workflows", :force => true do |t|
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "hours_before_rain"
    t.boolean  "cem2051"
    t.boolean  "cem2052"
    t.boolean  "ph_sample"
    t.boolean  "turbidity"
    t.boolean  "report_sent"
    t.boolean  "report_received"
    t.integer  "chance_of_rain"
    t.float    "amount_of_rain"
    t.float    "forecast_rain"
    t.boolean  "sampling_event"
  end

  create_table "sampling_events", :force => true do |t|
    t.integer  "site_id"
    t.string   "sampling_type"
    t.text     "sampling_description"
    t.datetime "sampling_date"
    t.string   "submitted_by"
    t.string   "sampled_by"
    t.integer  "sample_id_1"
    t.string   "sample_location_1"
    t.time     "sample_time_1"
    t.string   "analysis_type_1"
    t.string   "analysis_result_1"
    t.string   "analysis_average_1"
    t.integer  "sample_id_2"
    t.string   "sample_location_2"
    t.time     "sample_time_2"
    t.string   "analysis_type_2"
    t.string   "analysis_result_2"
    t.string   "analysis_average_2"
    t.integer  "sample_id_3"
    t.string   "sample_location_3"
    t.time     "sample_time_3"
    t.string   "analysis_type_3"
    t.string   "analysis_result_3"
    t.string   "analysis_average_3"
    t.integer  "sample_id_4"
    t.string   "sample_location_4"
    t.time     "sample_time_4"
    t.string   "analysis_type_4"
    t.string   "analysis_result_4"
    t.string   "analysis_average_4"
    t.integer  "sample_id_5"
    t.string   "sample_location_5"
    t.time     "sample_time_5"
    t.string   "analysis_type_5"
    t.string   "analysis_result_5"
    t.string   "analysis_average_5"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.boolean  "status"
    t.boolean  "completed"
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

  create_table "weather_updates", :force => true do |t|
    t.integer  "site_id"
    t.datetime "forecast_creation_time"
    t.float    "lat"
    t.float    "lng"
    t.integer  "elevation"
    t.integer  "duration"
    t.integer  "interval"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "weather_updates", ["site_id"], :name => "index_weather_updates_on_site_id"

end
