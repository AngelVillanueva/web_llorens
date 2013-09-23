module KnowstheDomain
  def organizacion
    @organizacion ||= FactoryGirl.create( :organizacion )
  end
  def cliente
    @cliente ||= FactoryGirl.create( :cliente )
  end
  def usuario
    usuario ||= FactoryGirl.create( :usuario )
    usuario.clientes << cliente if usuario.clientes.empty?
    usuario
  end
  def admin
    admin ||= FactoryGirl.create( :usuario, nombre: "super", role: "admin" )
  end
  def matriculacion
    @matriculacion || FactoryGirl.create( :matriculacion, cliente: cliente )
  end
  def matriculacion_incomplete
    @matriculacion || FactoryGirl.create( :matriculacion, cliente: cliente, identificador: "Missing" )
  end
  def transferencia
    @transferencia || FactoryGirl.create( :transferencia, cliente: cliente )
  end
  def transferencia_incomplete
    @transferencia || FactoryGirl.create( :transferencia, cliente: cliente, identificador: "Missing" )
  end
  def justificante
    @justificante || FactoryGirl.create( :justificante, cliente: cliente )
  end
  def informe
    @informe || FactoryGirl.create( :informe, cliente: cliente )
  end
end

World(KnowstheDomain)