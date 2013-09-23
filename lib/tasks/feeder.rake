# rake feed:all
# rake RAILS_ENV=test feed:all 

namespace :feed do

  desc 'Feeding Organizaciones'
  task :organizaciones => :environment do
    Organizacion.delete_all
    FastSeeder.seed_csv!(Organizacion, "organizaciones.csv", :id, :nombre, :identificador)
  end

  desc 'Feeding Clientes'
  task :clientes => :environment do
    Cliente.delete_all
    FastSeeder.seed_csv!(Cliente, "clientes.csv", :nombre, :identificador, :cif, :organizacion_id, :llorens_cliente_id)
  end
  
  
  
  desc 'Run all feedings'
  task :all => [:organizaciones, :clientes]
  
  task :default => :all
  
end