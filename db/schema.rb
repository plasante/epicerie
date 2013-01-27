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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130126133908) do

  create_table "categories", :force => true do |t|
    t.string   "nom"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["nom"], :name => "index_categories_on_nom", :unique => true

  create_table "fabricants", :force => true do |t|
    t.string   "nom"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "fabricants", ["nom"], :name => "index_fabricants_on_nom", :unique => true

  create_table "formats", :force => true do |t|
    t.string   "nom"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "formats", ["nom"], :name => "index_formats_on_nom", :unique => true

  create_table "liste_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "produit_id"
    t.integer  "qty",        :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "liste_items", ["produit_id"], :name => "index_liste_items_on_produit_id"
  add_index "liste_items", ["user_id", "produit_id"], :name => "index_liste_items_on_user_id_and_produit_id", :unique => true
  add_index "liste_items", ["user_id"], :name => "index_liste_items_on_user_id"

  create_table "magasin_produits", :force => true do |t|
    t.integer  "magasin_id"
    t.integer  "produit_id"
    t.decimal  "prix_regulier", :precision => 12, :scale => 2
    t.decimal  "prix_special",  :precision => 12, :scale => 2
    t.date     "date_debut",                                   :default => '2013-01-27'
    t.date     "date_fin",                                     :default => '2013-01-27'
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
  end

  add_index "magasin_produits", ["magasin_id"], :name => "index_magasin_produits_on_magasin_id"
  add_index "magasin_produits", ["produit_id"], :name => "index_magasin_produits_on_produit_id"

  create_table "magasin_types", :force => true do |t|
    t.string   "nom"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "magasins", :force => true do |t|
    t.string   "nom"
    t.string   "description"
    t.integer  "magasin_type_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "magasins", ["magasin_type_id"], :name => "index_magasins_on_magasin_type_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "produit_noms", :force => true do |t|
    t.string   "nom"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "produit_noms", ["nom"], :name => "index_produit_noms_on_nom", :unique => true

  create_table "produits", :force => true do |t|
    t.integer  "produit_nom_id"
    t.integer  "category_id"
    t.integer  "fabricant_id"
    t.integer  "format_id"
    t.string   "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "produits", ["category_id"], :name => "index_produits_on_category_id"
  add_index "produits", ["fabricant_id"], :name => "index_produits_on_fabricant_id"
  add_index "produits", ["format_id"], :name => "index_produits_on_format_id"
  add_index "produits", ["produit_nom_id"], :name => "index_produits_on_produit_nom_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.boolean  "family",          :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
