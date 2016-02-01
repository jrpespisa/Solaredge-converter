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

ActiveRecord::Schema.define(version: 20160201172848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "queries", force: :cascade do |t|
    t.float    "kwh_rate",                    null: false
    t.float    "kwh_credit",                  null: false
    t.float    "kwh_generated",               null: false
    t.float    "consumed",                    null: false
    t.float    "sent_to_grid",                null: false
    t.float    "savings_consumed",            null: false
    t.float    "credit_grid",                 null: false
    t.float    "savings_before_distribution", null: false
    t.float    "distribution_charge",         null: false
    t.float    "total_savings",               null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
