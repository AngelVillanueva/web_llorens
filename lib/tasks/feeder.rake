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

  desc 'Feeding Mauto usuarios'
  task :m_usuarios => :environment do
    # define the common organization
    org = Organizacion.find_by_identificador("EME")

    # open the csv file
    f = File.open("#{Rails.root}/db/seeds/m_usuarios.csv", "r")

    # loop through each record in the csv file, adding
    # each record as a new user
    f.each_line { |line|

      # each line has fields separated by commas, so split those fields
      fields = line.split(',')
      
      # create a new Usuario
      u = Usuario.new

      # do a little work here to get rid of double-quotes and blanks
      u.nombre = fields[0].tr_s('"', '').strip
      u.apellidos = fields[1].tr_s('"', '').strip
      u.email = fields[2].tr_s('"', '').strip
      u.password = fields[3].tr_s('"', '').strip
      u.password_confirmation = u.password
      u.organizacion = org
      u.save!
    }    
  end
  
  
  
  desc 'Run all feedings'
  task :all => [:organizaciones, :admins, :clientes]
  
  task :default => :all
  
end