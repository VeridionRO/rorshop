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

ActiveRecord::Schema.define(version: 20140309164515) do

  create_table "images", force: true do |t|
    t.integer  "product_id",                   null: false
    t.boolean  "default_image", default: true
    t.string   "title",                        null: false
    t.string   "uri",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["product_id", "default_image"], name: "index_images_on_product_id_and_default_image", unique: true, using: :btree
  add_index "images", ["product_id"], name: "index_images_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
