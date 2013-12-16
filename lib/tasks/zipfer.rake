# rake ziper:all
# rake RAILS_ENV=test ziper:all

require 'zip'

namespace :ziper do

  desc 'unzipping a zip'
  task :unzip => :environment do
    Zip::File.open("#{Rails.root}/spec/fixtures/my.zip") do |zipfile|
      found = 0
      zipfile.each do |file|
        bastidor = num_bastidor file.to_s
        if e = Expediente.where(bastidor: bastidor).first
          file.extract(file.to_s) unless File.exist? file.to_s
          pdf = File.open(file.to_s, "r")
          e.pdf = pdf
          e.save!
          File.delete(file.to_s)
          found = found + 1
        end
      end
      puts "Procesados: #{zipfile.count}. Encontrados: #{found}"
    end
  end

  desc 'Run all zipers'
  task :all => [:unzip]
  
  task :default => :all

  ## Aux methods
  def folder_name(type)
    case type
    when "Matriculacion"
      folder_name = "TU-MATRICULACIONES/"
    when "Transferencia"
      folder_name = "TR-TRANSFERENCIAS/"
    else
      folder_name = ""
    end
    folder_name
  end

  def num_bastidor nombre_pdf
    m = /[_][A-Z0-9]{17}/.match(nombre_pdf).to_s
    unless m.empty?
      nb = m.gsub("_", "")
    else
      nil
    end
  end

end