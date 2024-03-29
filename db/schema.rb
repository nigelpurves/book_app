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

ActiveRecord::Schema.define(:version => 20120810112244) do

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "spotify_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "track_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "source"
    t.string   "url"
    t.integer  "artist_id"
    t.string   "type"
    t.datetime "last_notified_at"
  end

  add_index "interests", ["user_id", "track_id"], :name => "index_interests_on_user_id_and_track_id"

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "spotify_link"
    t.string   "itunes_link"
    t.integer  "artist_id"
    t.datetime "discovered_at"
  end

  add_index "tracks", ["created_at"], :name => "index_tracks_on_created_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",             :default => false
    t.string   "bookmarklet_token"
    t.string   "skusername"
  end

  add_index "users", ["bookmarklet_token"], :name => "index_users_on_bookmarklet_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
