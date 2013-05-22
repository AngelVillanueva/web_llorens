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

ActiveRecord::Schema.define(:version => 20130522113614) do

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
    t.boolean  "matriculacion"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "observaciones"
  end

  create_table "informe_traficos", :force => true do |t|
    t.string   "matricula"
    t.text     "solicitante"
    t.date     "fecha_solicitud"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "status"
  end

  create_table "justificantes", :force => true do |t|
    t.string   "identificador"
    t.string   "matricula"
    t.string   "bastidor"
    t.text     "comprador"
    t.text     "vendedor"
    t.string   "marca"
    t.string   "modelo"
    t.date     "fecha_alta"
    t.date     "fecha_entra_trafico"
    t.date     "fecha_sale_trafico"
    t.integer  "dias_tramite"
    t.boolean  "matriculacion"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "status"
  end

end
