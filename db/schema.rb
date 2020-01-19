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

ActiveRecord::Schema.define(version: 20200119134917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attributions", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "version_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_attributions_on_person_id", using: :btree
    t.index ["version_id"], name: "index_attributions_on_version_id", using: :btree
  end

  create_table "packages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "version_number"
    t.string   "title"
    t.string   "description"
    t.datetime "date_publication"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["package_id"], name: "index_versions_on_package_id", using: :btree
  end

  add_foreign_key "attributions", "people"
  add_foreign_key "attributions", "versions"
end
