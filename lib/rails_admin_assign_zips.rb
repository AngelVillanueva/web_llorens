require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
require 'zip'
 
module RailsAdminAssignZips
end

# There are several options that you can set here. Check https://github.com/sferik/rails_admin/blob/master/lib/rails_admin/config/actions/base.rb for more info. 
module RailsAdmin
  module Config
    module Actions
      class AssignZips < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :member do
          true
        end
        register_instance_option :link_icon do
          'icon-cogs'
        end
        register_instance_option :bulkable? do
          false
        end
        register_instance_option :controller do
          Proc.new do
            Zip::File.open( object.zip.path ) do |zipfile|
              found = 0
              not_found = %w[]
              zipfile.each do |file|
                bastidor = num_bastidor file.to_s
                if e = Matriculacion.where(bastidor: bastidor).first
                  file.extract(file.to_s) unless File.exist? file.to_s
                  pdf = File.open(file.to_s, "r")
                  e.pdf = pdf
                  if e.save!
                    if e.cliente_id == 108 #Ahtlon
                      unless Driver.exists?(:bastidor => e.bastidor)
                        driver = Driver.new(identificador: e.matricula, matricula: e.matricula, bastidor: e.bastidor, fecha_matriculacion: e.pdf_updated_at, envio_ok: false)
                        driver.save!
                      end
                    end
                  end
                  File.delete(file.to_s)
                  found = found + 1
                else
                  not_found << file.to_s
                end
              end
              object.expandido = true
              object.save!
              zipfile.count == found ? tipo = "success" : tipo = "alert"
              flash[tipo.to_sym] = create_unzip_message( zipfile.count, found, not_found )
              redirect_to back_or_index
            end
          end
        end
      end
    end
  end
end

def num_bastidor nombre_pdf
  # cada pdf se espera que contenga dentro del nombre la secuencia '_'+número de bastidor
  m = /[_][A-Z0-9]{17}/.match(nombre_pdf).to_s
  unless m.empty?
    nb = m.gsub("_", "")
  else
    nil
  end
end

def create_unzip_message total, found, not_found
  if total == found
    message = "Encontrados y procesados correctamente el total de #{total}."
  elsif total > found
    message = "Encontrados y procesados correctamente #{found} de #{total}, pero no se encontraron #{not_found.count}: #{not_found}"
  end
end