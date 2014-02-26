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

ActiveRecord::Schema.define(:version => 20140221145633) do

  create_table "api_keys", :force => true do |t|
    t.string   "access_token"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "avisos", :force => true do |t|
    t.text     "contenido"
    t.string   "titular"
    t.date     "fecha_de_caducidad"
    t.integer  "dias_visible_desde_ultimo_login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sorting_order"
  end

  add_index "avisos", ["sorting_order"], :name => "index_avisos_on_sorting_order"

  create_table "clientes", :force => true do |t|
    t.string  "nombre"
    t.string  "identificador"
    t.string  "cif"
    t.integer "organizacion_id"
    t.string  "llorens_cliente_id"
    t.boolean "has_remarketing",    :default => false
  end

  add_index "clientes", ["has_remarketing"], :name => "index_clientes_on_has_remarketing"
  add_index "clientes", ["llorens_cliente_id"], :name => "index_clientes_on_llorens_cliente_id"

  create_table "clientes_usuarios", :id => false, :force => true do |t|
    t.integer "cliente_id"
    t.integer "usuario_id"
  end

  create_table "configurations", :force => true do |t|
    t.string   "option"
    t.boolean  "enabled",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

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
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.text     "observaciones"
    t.string   "type"
    t.integer  "cliente_id"
    t.string   "llorens_cliente_id"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.text     "incidencia"
    t.boolean  "has_incidencia"
    t.boolean  "has_documentos",              :default => false, :null => false
    t.date     "fecha_resolucion_incidencia"
  end

  add_index "expedientes", ["cliente_id"], :name => "index_expedientes_on_cliente_id"
  add_index "expedientes", ["has_incidencia"], :name => "index_expedientes_on_has_incidencia"
  add_index "expedientes", ["id", "type"], :name => "index_expedientes_on_id_and_type"
  add_index "expedientes", ["llorens_cliente_id"], :name => "index_expedientes_on_llorens_cliente_id"

  create_table "guardias", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "guardias", ["email"], :name => "index_guardias_on_email"

  create_table "informes", :force => true do |t|
    t.string   "matricula"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.string   "identificador"
    t.string   "solicitante"
    t.integer  "cliente_id"
  end

  add_index "informes", ["cliente_id"], :name => "index_informes_on_cliente_id"

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
    t.datetime "hora_solicitud"
    t.datetime "hora_entrega"
    t.integer  "cliente_id"
  end

  add_index "justificantes", ["cliente_id"], :name => "index_justificantes_on_cliente_id"

  create_table "notificaciones", :force => true do |t|
    t.integer  "aviso_id"
    t.integer  "usuario_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.date     "caducidad_relativa"
  end

  add_index "notificaciones", ["aviso_id"], :name => "index_notificaciones_pendientes_on_aviso_id"
  add_index "notificaciones", ["usuario_id"], :name => "index_notificaciones_pendientes_on_usuario_id"

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

  create_table "rich_rich_files", :force => true do |t|
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        :default => "file"
  end

  create_table "stock_vehicles", :force => true do |t|
    t.string   "matricula"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "cliente_id"
    t.string   "marca"
    t.string   "modelo"
    t.boolean  "vendido",                      :default => false
    t.string   "comprador"
    t.boolean  "ft",                           :default => false
    t.boolean  "pc",                           :default => false
    t.date     "fecha_itv"
    t.text     "incidencia"
    t.date     "fecha_expediente_completo"
    t.date     "fecha_documentacion_enviada"
    t.date     "fecha_documentacion_recibida"
    t.date     "fecha_notificado_cliente"
    t.boolean  "particular",                   :default => false
    t.boolean  "compra_venta",                 :default => false
    t.date     "fecha_envio_gestoria"
    t.boolean  "baja_exportacion",             :default => false
    t.date     "fecha_entregado_david"
    t.date     "fecha_envio_definitiva"
    t.text     "observaciones"
  end

  add_index "stock_vehicles", ["fecha_documentacion_enviada"], :name => "index_stock_vehicles_on_fecha_documentacion_enviada"
  add_index "stock_vehicles", ["fecha_documentacion_recibida"], :name => "index_stock_vehicles_on_fecha_documentacion_recibida"
  add_index "stock_vehicles", ["fecha_entregado_david"], :name => "index_stock_vehicles_on_fecha_entregado_david"
  add_index "stock_vehicles", ["fecha_envio_definitiva"], :name => "index_stock_vehicles_on_fecha_envio_definitiva"
  add_index "stock_vehicles", ["fecha_envio_gestoria"], :name => "index_stock_vehicles_on_fecha_envio_gestoria"
  add_index "stock_vehicles", ["fecha_expediente_completo"], :name => "index_stock_vehicles_on_fecha_expediente_completo"
  add_index "stock_vehicles", ["fecha_notificado_cliente"], :name => "index_stock_vehicles_on_fecha_notificado_cliente"
  add_index "stock_vehicles", ["matricula"], :name => "index_stock_vehicles_on_matricula", :unique => true

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
    t.datetime "password_changed_at"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["organizacion_id"], :name => "index_usuarios_on_organizacion_id"
  add_index "usuarios", ["password_changed_at"], :name => "index_usuarios_on_password_changed_at"
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

  create_table "xml_vehicles", :force => true do |t|
    t.string   "xml_file_name"
    t.string   "xml_content_type"
    t.integer  "xml_file_size"
    t.datetime "xml_updated_at"
    t.integer  "cliente_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "processed",        :default => false
  end

  create_table "zip_matriculas", :force => true do |t|
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "zip_file_name"
    t.string   "zip_content_type"
    t.integer  "zip_file_size"
    t.datetime "zip_updated_at"
    t.boolean  "expandido",        :default => false
  end

end
