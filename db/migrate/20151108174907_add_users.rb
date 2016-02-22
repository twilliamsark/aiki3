class AddUsers < ActiveRecord::Migration
  def up
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

  end

  def down
    remove_index "user_remember_tokens", name: "index_urt_search"
    remove_index "user_remember_tokens", name: "index_user_remember_tokens_on_user_id"
    drop_table "user_remember_tokens"

    remove_index "users", name: "index_users_on_email"
    drop_table "users"
  end
end
