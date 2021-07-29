# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 5) do

  create_table "areas", force: :cascade do |t|
    t.integer "event_id"
    t.string "name", null: false
    t.string "path", null: false
    t.index ["path", "event_id"], name: "index_areas_on_path_and_event_id", unique: true
  end

  create_table "candidats", force: :cascade do |t|
    t.integer "area_id"
    t.integer "round_id"
    t.string "nom"
    t.string "liste"
    t.integer "voix", default: 0
    t.index ["nom", "area_id", "round_id"], name: "index_candidats_on_nom_and_area_id_and_round_id", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.integer "annee"
    t.boolean "populated"
    t.index ["name"], name: "index_events_on_name", unique: true
  end

  create_table "results", force: :cascade do |t|
    t.integer "area_id"
    t.integer "round_id"
    t.integer "inscrits", default: 0
    t.integer "abstentions", default: 0
    t.integer "votants", default: 0
    t.integer "blancs", default: 0
    t.integer "nuls", default: 0
    t.integer "exprimes", default: 0
    t.index ["area_id", "round_id"], name: "index_results_on_area_id_and_round_id", unique: true
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "event_id"
    t.string "name", null: false
    t.index ["name", "event_id"], name: "index_rounds_on_name_and_event_id", unique: true
  end

end
