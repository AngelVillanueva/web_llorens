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

ActiveRecord::Schema.define(:version => 20130523034903) do

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
    t.integer  "organization_id"
  end

  create_table "informe_traficos", :force => true do |t|
    t.string   "matricula"
    t.date     "fecha_solicitud"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "usuario_id"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
  end

  add_index "informe_traficos", ["usuario_id"], :name => "index_informe_traficos_on_usuario_id"

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
    t.integer  "usuario_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
  end

  create_table "organizacions", :force => true do |t|
    t.string   "nombre"
    t.string   "identificador"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

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
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

end
