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

ActiveRecord::Schema.define(:version => 1) do

  create_table "fieldnotes", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.text     "observations", :null => false
    t.text     "reflection"
    t.datetime "visited_on",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fieldnotes", ["user_id"], :name => "index_fieldnotes_on_user_id"

  create_table :fieldnote_attachments do |t|
    t.integer   "fieldnote_id"
    t.string    "content_type"
    t.string    "file"

    t.datetime  "created_at"
    t.datetime  "updated_at"
  end

  add_index "fieldnote_attachments", ["fieldnote_id"], :name => "index_fieldnote_attachments_on_fieldnote_id"

  create_table "searches", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "terms"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "searches", ["user_id"], :name => "index_searches_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_admin", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
