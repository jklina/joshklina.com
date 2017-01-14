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

ActiveRecord::Schema.define(version: 20170114212537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_reviews", force: :cascade do |t|
    t.string   "book_title"
    t.string   "url"
    t.string   "image_url"
    t.text     "body"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "book_author"
    t.string   "slug"
    t.date     "published_at"
    t.boolean  "published",    default: false, null: false
    t.integer  "author_id"
    t.index ["slug"], name: "index_book_reviews_on_slug", unique: true, using: :btree
  end

  create_table "categorical_taggings", force: :cascade do |t|
    t.integer "taggable_id"
    t.string  "taggable_type"
    t.integer "tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_categorical_taggings_on_taggable_type_and_taggable_id", using: :btree
  end

  create_table "categorical_tags", force: :cascade do |t|
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_categorical_tags_on_slug", unique: true, using: :btree
  end

  create_table "exposition_posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "published",    default: false, null: false
    t.date     "published_at"
    t.string   "slug"
    t.integer  "author_id"
    t.text     "summary"
    t.index ["slug"], name: "index_exposition_posts_on_slug", unique: true, using: :btree
  end

  create_table "exposition_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.index ["email"], name: "index_exposition_users_on_email", unique: true, using: :btree
  end

  create_table "tools", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "body"
    t.string   "slug"
    t.integer  "author_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.date     "published_at"
    t.boolean  "published",    default: false, null: false
    t.index ["slug"], name: "index_tools_on_slug", unique: true, using: :btree
  end

end
