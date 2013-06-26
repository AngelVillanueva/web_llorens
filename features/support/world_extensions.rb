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
  def matriculacion
    @matriculacion || FactoryGirl.create( :matriculacion, cliente: cliente )
  end
  def transferencia
    @transferencia || FactoryGirl.create( :transferencia, cliente: cliente )
  end
  def justificante
    @justificante || FactoryGirl.create( :justificante, cliente: cliente )
  end
  def informe
    @informe || FactoryGirl.create( :informe, cliente: cliente )
  end
end

World(KnowstheDomain)