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

ActiveRecord::Schema.define(version: 20150918074913) do

  create_table "activities", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "branchoffice_id",    limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "enabled",            limit: 4,   default: 1
  end

  add_index "activities", ["branchoffice_id"], name: "index_activities_on_branchoffice_id", using: :btree

  create_table "activitiesofrooms", force: :cascade do |t|
    t.integer  "activity_id", limit: 4
    t.integer  "room_id",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "activitiesofrooms", ["activity_id"], name: "index_activitiesofrooms_on_activity_id", using: :btree
  add_index "activitiesofrooms", ["room_id"], name: "index_activitiesofrooms_on_room_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.integer  "scheduleheader_id", limit: 4
    t.integer  "schedulebody_id",   limit: 4
    t.integer  "resource_id",       limit: 4
    t.integer  "user_id",           limit: 4
    t.integer  "bookstatus_id",     limit: 4
    t.date     "date_ini"
    t.date     "date_end"
    t.time     "time_ini"
    t.time     "time_end"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "books", ["bookstatus_id"], name: "index_books_on_bookstatus_id", using: :btree
  add_index "books", ["resource_id"], name: "index_books_on_resource_id", using: :btree
  add_index "books", ["schedulebody_id"], name: "index_books_on_schedulebody_id", using: :btree
  add_index "books", ["scheduleheader_id"], name: "index_books_on_scheduleheader_id", using: :btree
  add_index "books", ["user_id"], name: "index_books_on_user_id", using: :btree

  create_table "bookstatuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "branchoffices", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "direccion",          limit: 255
    t.integer  "cp",                 limit: 4
    t.integer  "company_id",         limit: 4
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "company_type_id",    limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "enabled",            limit: 4,   default: 1
  end

  add_index "branchoffices", ["company_id"], name: "index_branchoffices_on_company_id", using: :btree
  add_index "branchoffices", ["company_type_id"], name: "index_branchoffices_on_company_type_id", using: :btree
  add_index "branchoffices", ["user_id"], name: "index_branchoffices_on_user_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id",    limit: 4
    t.integer  "enabled",    limit: 4,   default: 1
  end

  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "company_types", force: :cascade do |t|
    t.string   "tipo",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "remove_brancho_from_scheduleheaders", force: :cascade do |t|
    t.integer  "branchoffice_id_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "remove_brancho_from_scheduleheaders", ["branchoffice_id_id"], name: "index_remove_brancho_from_scheduleheaders_on_branchoffice_id_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.integer  "resourcetype_id",   limit: 4
    t.string   "name",              limit: 255
    t.integer  "scheduleheader_id", limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.boolean  "enabled",           limit: 1,   default: true
  end

  add_index "resources", ["resourcetype_id"], name: "index_resources_on_resourcetype_id", using: :btree
  add_index "resources", ["scheduleheader_id"], name: "index_resources_on_scheduleheader_id", using: :btree

  create_table "resourcetypes", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "capacity_resource", limit: 4
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "branchoffice_id", limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "enabled",         limit: 4,   default: 1
  end

  add_index "rooms", ["branchoffice_id"], name: "index_rooms_on_branchoffice_id", using: :btree

  create_table "schedulebodies", force: :cascade do |t|
    t.integer  "scheduleheader_id", limit: 4
    t.time     "time_ini"
    t.time     "time_end"
    t.boolean  "su",                limit: 1, default: true
    t.boolean  "mo",                limit: 1, default: true
    t.boolean  "tu",                limit: 1, default: true
    t.boolean  "we",                limit: 1, default: true
    t.boolean  "th",                limit: 1, default: true
    t.boolean  "fr",                limit: 1, default: true
    t.boolean  "sa",                limit: 1, default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "enabled",           limit: 1, default: true
  end

  add_index "schedulebodies", ["scheduleheader_id"], name: "index_schedulebodies_on_scheduleheader_id", using: :btree

  create_table "scheduleheaders", force: :cascade do |t|
    t.date     "date_ini"
    t.date     "date_end"
    t.integer  "capacity",        limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "resourcetype_id", limit: 4
    t.integer  "branchoffice_id", limit: 4
    t.integer  "room_id",         limit: 4
    t.integer  "activity_id",     limit: 4
    t.boolean  "enabled",         limit: 1, default: true
  end

  add_index "scheduleheaders", ["activity_id"], name: "index_scheduleheaders_on_activity_id", using: :btree
  add_index "scheduleheaders", ["branchoffice_id"], name: "index_scheduleheaders_on_branchoffice_id", using: :btree
  add_index "scheduleheaders", ["resourcetype_id"], name: "index_scheduleheaders_on_resourcetype_id", using: :btree
  add_index "scheduleheaders", ["room_id"], name: "index_scheduleheaders_on_room_id", using: :btree

  create_table "userdata", force: :cascade do |t|
    t.string   "nombre",           limit: 255
    t.string   "apellido1",        limit: 255
    t.string   "apellido2",        limit: 255
    t.date     "fecha_nacimiento"
    t.string   "dni",              limit: 255
    t.string   "sexo",             limit: 255
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "userdata", ["user_id"], name: "index_userdata_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user",                   limit: 255
    t.string   "password",               limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "auth_token",             limit: 255, default: ""
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "logged",                 limit: 4,   default: 0
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "activities", "branchoffices"
  add_foreign_key "activitiesofrooms", "activities"
  add_foreign_key "activitiesofrooms", "rooms"
  add_foreign_key "books", "bookstatuses"
  add_foreign_key "books", "resources"
  add_foreign_key "books", "schedulebodies"
  add_foreign_key "books", "scheduleheaders"
  add_foreign_key "books", "users"
  add_foreign_key "branchoffices", "companies"
  add_foreign_key "branchoffices", "company_types"
  add_foreign_key "branchoffices", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "resources", "resourcetypes"
  add_foreign_key "resources", "scheduleheaders"
  add_foreign_key "rooms", "branchoffices"
  add_foreign_key "schedulebodies", "scheduleheaders"
  add_foreign_key "scheduleheaders", "activities"
  add_foreign_key "scheduleheaders", "branchoffices"
  add_foreign_key "scheduleheaders", "resourcetypes"
  add_foreign_key "scheduleheaders", "rooms"
  add_foreign_key "userdata", "users"
end
