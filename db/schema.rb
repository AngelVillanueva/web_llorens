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

ActiveRecord::Schema.define(:version => 20130626105403) do

  create_table "clientes", :force => true do |t|
    t.string "nombre"
    t.string "identificador"
    t.string "cif"
  end

  create_table "clientes_usuarios", :id => false, :force => true do |t|
    t.integer "cliente_id"
    t.integer "usuario_id"
  end

  create_table "expedientes", :force => true do |t|
    t.string   "identificador"
    t.string   "matricula"
    t.string   "bastidor"
    t.text     "comprador"
    t.text     "vendedor"
    t.string   "marca"
    t.string   "modelo"
    t.date     "fecha_alta"
    t.date     "fecha_entra_trafico"
    t.date     "fecha_facturacion"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "observaciones"
    t.integer  "organizacion_id"
    t.string   "type"
    t.integer  "cliente_id"
  end

  add_index "expedientes", ["id", "type"], :name => "index_expedientes_on_id_and_type"
  add_index "expedientes", ["organizacion_id"], :name => "index_expedientes_on_organizacion_id"

  create_table "informes", :force => true do |t|
    t.string   "matricula"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.string   "identificador"
    t.integer  "organizacion_id"
    t.string   "solicitante"
    t.integer  "cliente_id"
  end

  add_index "informes", ["organizacion_id"], :name => "index_informes_on_organizacion_id"

  create_table "justificantes", :force => true do |t|
    t.string   "identificador"
    t.string   "nif_comprador"
    t.string   "nombre_razon_social"
    t.string   "primer_apellido"
    t.string   "segundo_apellido"
    t.string   "provincia"
    t.string   "municipio"
    t.text     "direccion"
    t.string   "matricula"
    t.string   "bastidor"
    t.string   "marca"
    t.string   "modelo"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.integer  "organizacion_id"
    t.datetime "hora_solicitud"
    t.datetime "hora_entrega"
    t.integer  "cliente_id"
  end

  add_index "justificantes", ["organizacion_id"], :name => "index_justificantes_on_organizacion_id"

  create_table "organizaciones", :force => true do |t|
    t.string   "nombre"
    t.string   "identificador"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "cif"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "usuarios", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "nombre"
    t.string   "apellidos"
    t.integer  "organizacion_id"
    t.string   "role"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["organizacion_id"], :name => "index_usuarios_on_organizacion_id"
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

end
