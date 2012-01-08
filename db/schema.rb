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

ActiveRecord::Schema.define(:version => 20120108051820) do

  create_table "battles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "winner_id"
    t.integer  "user_id"
    t.boolean  "accepted"
  end

  create_table "inputs", :force => true do |t|
    t.integer  "vegetables"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_items", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
    t.integer  "userjoules"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.string   "robot"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "joules"
    t.integer  "totalbattles"
    t.integer  "totalvictories"
    t.integer  "vegetables"
    t.integer  "vegetablesthislevel"
    t.integer  "health"
    t.integer  "maxhealth"
    t.string   "equippeditem"
    t.string   "vegtype"
  end

end
