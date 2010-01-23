# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100123215933) do

  create_table "reports", :force => true do |t|
    t.string   "yql_id"
    t.string   "provenance"
    t.string   "content"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "upvotes",                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user"
    t.string   "user_profile_image_url"
    t.string   "user_provenance_key"
    t.string   "user_homepage_url"
    t.integer  "views"
    t.integer  "downvotes",              :default => 0
  end

end
