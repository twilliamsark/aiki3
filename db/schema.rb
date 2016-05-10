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

ActiveRecord::Schema.define(version: 20160509225550) do

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

  create_table "entrances", force: true do |t|
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

  create_table "katas", force: true do |t|
    t.string   "name"
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

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "sensei_notes", force: true do |t|
    t.string   "note"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sensei_notes", ["video_id"], name: "index_sensei_notes_on_video_id"

  create_table "senseis", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stances", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "styles", force: true do |t|
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

  create_table "user_remember_tokens", force: true do |t|
    t.string   "remember_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip"
    t.datetime "expires_at"
    t.datetime "signed_out_at"
  end

  add_index "user_remember_tokens", ["signed_out_at", "remember_token", "expires_at"], name: "index_urt_search"
  add_index "user_remember_tokens", ["user_id"], name: "index_user_remember_tokens_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "demo"
    t.date     "demo_user_expires_on"
    t.boolean  "cotu",                   default: false
    t.boolean  "reviewer"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email"

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

  create_table "videos", force: true do |t|
    t.string   "name"
    t.integer  "waza_id"
    t.integer  "aiki_format_id"
    t.integer  "rank_id"
    t.boolean  "on_test",        default: false
    t.boolean  "primary",        default: false
    t.string   "youtube_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sensei_id"
    t.integer  "style_id"
    t.text     "keywords"
    t.integer  "kata_id"
    t.boolean  "needs_review"
    t.boolean  "public",         default: false
  end

  add_index "videos", ["aiki_format_id"], name: "index_videos_on_aiki_format_id"
  add_index "videos", ["kata_id"], name: "index_videos_on_kata_id"
  add_index "videos", ["rank_id"], name: "index_videos_on_rank_id"
  add_index "videos", ["sensei_id"], name: "index_videos_on_sensei_id"
  add_index "videos", ["style_id"], name: "index_videos_on_style_id"
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
    t.integer  "entrance_id"
  end

  add_index "wazas", ["attack_height_id"], name: "index_wazas_on_attack_height_id"
  add_index "wazas", ["attack_id"], name: "index_wazas_on_attack_id"
  add_index "wazas", ["direction_id"], name: "index_wazas_on_direction_id"
  add_index "wazas", ["entrance_id"], name: "index_wazas_on_entrance_id"
  add_index "wazas", ["hand_applied_to_id"], name: "index_wazas_on_hand_applied_to_id"
  add_index "wazas", ["kaiten_id"], name: "index_wazas_on_kaiten_id"
  add_index "wazas", ["level_id"], name: "index_wazas_on_level_id"
  add_index "wazas", ["maka_komi_id"], name: "index_wazas_on_maka_komi_id"
  add_index "wazas", ["stance_id"], name: "index_wazas_on_stance_id"
  add_index "wazas", ["sword_id"], name: "index_wazas_on_sword_id"
  add_index "wazas", ["technique_id"], name: "index_wazas_on_technique_id"

end
