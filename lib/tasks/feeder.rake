# rake feed:all
# rake RAILS_ENV=test feed:all 

namespace :feed do

  desc 'Feeding Organizaciones'
  task :organizaciones => :environment do
    Organizacion.delete_all
    FastSeeder.seed_csv!(Organizacion, "organizaciones.csv", :id, :nombre, :identificador)
  end

  desc 'Feeding Admin users'
  task :admins => :environment do
    Usuario.where(role: "admin").delete_all
    # Main admin user
    superadmin = Usuario.find_or_create_by_nombre(
        nombre: "Administrador",
        apellidos: "Total",
        email: "info@sinapse.es",
        password: "foobarfoo",
        password_confirmation: "foobarfoo",
        organizacion: Organizacion.find_by_identificador("LLORENS"),
        role: "admin"
      )
  end

  desc 'Feeding Clientes'
  task :clientes => :environment do
    Cliente.delete_all
    FastSeeder.seed_csv!(Cliente, "clientes.csv", :nombre, :identificador, :cif, :organizacion_id, :llorens_cliente_id)
  end
  
  
  
  desc 'Run all feedings'
  task :all => [:organizaciones, :admins, :clientes]
  
  task :default => :all
  
end