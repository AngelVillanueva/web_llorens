# rake pdfer:all
# rake RAILS_ENV=test pdfer:all 

namespace :pdfer do

  desc 'Looking for PDFs'
  task :match => :environment do
    Expediente.all.each do |exp|
      if Rails.env.production?
      the_pdf_file = "#{Rails.root}/public/assets/expedientes/#{folder_name(exp.type)}#{exp.identificador}.pdf"
      else
        the_pdf_file = "#{Rails.root}/app/assets/pdfs/expedientes/#{folder_name(exp.type)}#{exp.identificador}.pdf"
      end
      exp.has_documentos = File.exist? the_pdf_file
      exp.save!
    end
  end

  task :testing => :environment do
    puts "ok"
  end

  desc 'Run all pdfers'
  task :all => [:match]
  
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

end