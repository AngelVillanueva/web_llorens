# rake fakefeed:all
# rake RAILS_ENV=test fakefeed:all 

namespace :fakefeed do

  desc 'Feeding ApiKeys'
  task :apikeys => :environment do
    ApiKey.delete_all
    apikey = ApiKey.create!()
    apikey.access_token = "f85b0cbe9e00194304c0d9bd7208e0e8"
    apikey.save!
  end

  desc 'Feeding Clientes'
  task :matriculaciones => :environment do
    Matriculacion.delete_all
    5000.times do
      Matriculacion.create!(
        identificador: "#{Faker::Lorem.characters(3).upcase}-#{Faker::Lorem.characters(3).upcase}",
        matricula: Faker::Lorem.characters(6).upcase,
        bastidor: Faker::Lorem.characters(17).upcase,
        comprador: Faker::Name.name,
        vendedor: Faker::Name.name,
        marca: ["BMW", "Seat", "Opel", "Citroen", "Mercedes"].sample,
        modelo: Faker::Lorem.word.capitalize,
        fecha_alta: fa = Random.new.rand(10).days.ago.to_date,
        fecha_entra_trafico: ft = fa + Random.new.rand(3),
        fecha_facturacion: ff = ft + Random.new.rand(2),
        observaciones: Faker::Lorem.sentence,
        cliente: Cliente.all.sample
      )
    end
  end

  task :transferencias => :environment do
    Transferencia.delete_all
    5.times do
      Transferencia.create!(
        identificador: "#{Faker::Lorem.characters(3).upcase}-#{Faker::Lorem.characters(3).upcase}",
        matricula: Faker::Lorem.characters(6).upcase,
        bastidor: Faker::Lorem.characters(17).upcase,
        comprador: Faker::Name.name,
        vendedor: Faker::Name.name,
        marca: ["BMW", "Seat", "Opel", "Citroen", "Mercedes"].sample,
        modelo: Faker::Lorem.word.capitalize,
        fecha_alta: fa = Random.new.rand(10).days.ago.to_date,
        fecha_entra_trafico: ft = fa + Random.new.rand(3),
        fecha_facturacion: ff = ft + Random.new.rand(2),
        observaciones: Faker::Lorem.sentence,
        cliente: Cliente.all.sample
      )
    end
  end
  
  task :justificantes => :environment do
    Justificante.delete_all
    10.times do
      j = Justificante.create(
        identificador: "#{Faker::Lorem.characters(3).upcase}-#{Faker::Lorem.characters(3).upcase}",
        nif_comprador: "00000000T",
        nombre_razon_social: Faker::Name.first_name,
        primer_apellido: Faker::Name.last_name,
        segundo_apellido: Faker::Name.last_name,
        provincia: Faker::Address.state,
        municipio: Faker::Address.city,
        direccion: Faker::Address.street_address,
        matricula: Faker::Lorem.characters(6).upcase,
        bastidor: Faker::Lorem.characters(17).upcase,
        marca: ["BMW", "Seat", "Opel", "Citroen", "Mercedes"].sample,
        modelo: Faker::Lorem.word.capitalize,
        cliente: Cliente.all.sample
      )
      j.created_at = Time.at( rand * ( Time.now.to_f - 1.year.ago.to_f ) + 1.year.ago.to_f )
      j.hora_solicitud = j.created_at
      j.save!
    end
  end

  task :informes => :environment do
    Informe.delete_all
    10.times do
      i = Informe.create(
        identificador: "#{Faker::Lorem.characters(3).upcase}-#{Faker::Lorem.characters(3).upcase}",
        solicitante: Faker::Name.name,
        matricula: Faker::Lorem.characters(6).upcase,
        cliente: Cliente.all.sample
      )
      i.created_at = Time.at( rand * ( Time.now.to_f - 1.year.ago.to_f ) + 1.year.ago.to_f )
      i.save!
    end
  end
  
  
  desc 'Run all fake feedings'
  task :all => [:apikeys, :matriculaciones, :transferencias, :justificantes, :informes]
  
  task :default => :all
end
