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

ActiveRecord::Schema.define(:version => 20100117012916) do

  create_table "reports", :force => true do |t|
    t.string   "note_record_id"
    t.string   "entry_date"
    t.string   "author_name"
    t.string   "author_email"
    t.string   "author_phone"
    t.date     "source_date"
    t.boolean  "found"
    t.string   "email_of_found"
    t.string   "phone_of_found"
    t.string   "laset_known_location"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
