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

ActiveRecord::Schema.define(version: 2018_07_15_034138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deposits", force: :cascade do |t|
    t.boolean "completed"
    t.string "currency"
    t.float "amount"
    t.datetime "date"
    t.string "address"
    t.string "txid"
  end

  create_table "trades", force: :cascade do |t|
    t.datetime "date"
    t.string "pair"
    t.string "exchange"
    t.string "buy_or_sell"
    t.float "price"
    t.float "amount"
    t.float "total"
    t.float "fee"
    t.string "fee_coin"
  end

  create_table "withdrawals", force: :cascade do |t|
    t.boolean "completed"
    t.string "currency"
    t.float "amount"
    t.datetime "date"
    t.string "address"
    t.string "txid"
  end

end
