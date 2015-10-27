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

ActiveRecord::Schema.define(version: 20151027205457) do

  create_table "aiki_formats", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attack_heights", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attacks", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "directions", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hand_applied_tos", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kaitens", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maka_komis", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stances", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "swords", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "techniques", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "name"
    t.integer  "waza_id"
    t.integer  "aiki_format_id"
    t.integer  "rank_id"
    t.boolean  "on_test"
    t.string   "youtube_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["aiki_format_id"], name: "index_videos_on_aiki_format_id"
  add_index "videos", ["rank_id"], name: "index_videos_on_rank_id"
  add_index "videos", ["waza_id"], name: "index_videos_on_waza_id"

  create_table "wazas", force: true do |t|
    t.string   "name"
    t.integer  "stance_id"
    t.integer  "attack_id"
    t.integer  "attack_height_id"
    t.integer  "hand_applied_to_id"
    t.integer  "maka_komi_id"
    t.integer  "technique_id"
    t.integer  "direction_id"
    t.integer  "kaiten_id"
    t.integer  "sword_id"
    t.integer  "level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wazas", ["attack_height_id"], name: "index_wazas_on_attack_height_id"
  add_index "wazas", ["attack_id"], name: "index_wazas_on_attack_id"
  add_index "wazas", ["direction_id"], name: "index_wazas_on_direction_id"
  add_index "wazas", ["hand_applied_to_id"], name: "index_wazas_on_hand_applied_to_id"
  add_index "wazas", ["kaiten_id"], name: "index_wazas_on_kaiten_id"
  add_index "wazas", ["level_id"], name: "index_wazas_on_level_id"
  add_index "wazas", ["maka_komi_id"], name: "index_wazas_on_maka_komi_id"
  add_index "wazas", ["stance_id"], name: "index_wazas_on_stance_id"
  add_index "wazas", ["sword_id"], name: "index_wazas_on_sword_id"
  add_index "wazas", ["technique_id"], name: "index_wazas_on_technique_id"

end
