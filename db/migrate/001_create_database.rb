class CreateDatabase < ActiveRecord::Migration
  def self.up

    create_table "fieldnotes", :force => true do |t|
      t.integer  "user_id",        :null => false
      t.text     "observations",   :null => false
      t.text     "reflection"
      t.datetime "visited_on",     :null => false
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

  def self.down
    # drop all the tables if you really need
    # to support migration back to version 0
  end
end