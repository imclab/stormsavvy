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

ActiveRecord::Schema.define(:version => 20120304021655) do

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
    t.integer  "zipcode"
    t.float    "lat"
    t.float    "long"
    t.integer  "address_1"
    t.integer  "address_2"
    t.string   "city"
    t.string   "state"
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
