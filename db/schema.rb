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

ActiveRecord::Schema.define(version: 20140629004253) do

  create_table "diners", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "diners", ["email"], name: "index_diners_on_email", unique: true
  add_index "diners", ["reset_password_token"], name: "index_diners_on_reset_password_token", unique: true

  create_table "diners_meals", id: false, force: true do |t|
    t.integer "diner_id", null: false
    t.integer "meal_id",  null: false
  end

  add_index "diners_meals", ["diner_id", "meal_id"], name: "index_diners_meals_on_diner_id_and_meal_id"
  add_index "diners_meals", ["meal_id", "diner_id"], name: "index_diners_meals_on_meal_id_and_diner_id"

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.decimal  "cost"
    t.boolean  "finished"
    t.integer  "diner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients_meals", id: false, force: true do |t|
    t.integer "ingredient_id", null: false
    t.integer "meal_id",       null: false
  end

  add_index "ingredients_meals", ["ingredient_id", "meal_id"], name: "index_ingredients_meals_on_ingredient_id_and_meal_id"
  add_index "ingredients_meals", ["meal_id", "ingredient_id"], name: "index_ingredients_meals_on_meal_id_and_ingredient_id"

  create_table "meals", force: true do |t|
    t.string   "chef"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

end
