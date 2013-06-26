module KnowstheDomain
  def organizacion
    @organizacion ||= FactoryGirl.create( :organizacion )
  end
  def cliente
    @cliente ||= FactoryGirl.create( :cliente )
  end
  def usuario
    usuario ||= FactoryGirl.create( :usuario, organizacion: organizacion )
    usuario.clientes << cliente if usuario.clientes.empty?
    usuario
  end
  def matriculacion
    @matriculacion || FactoryGirl.create( :matriculacion, organizacion: organizacion, cliente: cliente )
  end
  def transferencia
    @transferencia || FactoryGirl.create( :transferencia, organizacion: organizacion, cliente: cliente )
  end
  def justificante
    @justificante || FactoryGirl.create( :justificante, organizacion: organizacion )
  end
  def informe
    @informe || FactoryGirl.create( :informe, organizacion: organizacion, cliente: cliente )
  end
end

World(KnowstheDomain)