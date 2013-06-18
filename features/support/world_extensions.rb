module KnowstheDomain
  def organizacion
    @organizacion ||= FactoryGirl.create( :organizacion )
  end
  def usuario
    usuario ||= FactoryGirl.create( :usuario, organizacion: organizacion )
  end
  def matriculacion
    @matriculacion || FactoryGirl.create( :matriculacion, organizacion: organizacion )
  end
  def transferencia
    @transferencia || FactoryGirl.create( :transferencia, organizacion: organizacion )
  end
  def justificante
    @justificante || FactoryGirl.create( :justificante, organizacion: organizacion )
  end
  def informe
    @informe || FactoryGirl.create( :informe, organizacion: organizacion )
  end
end

World(KnowstheDomain)