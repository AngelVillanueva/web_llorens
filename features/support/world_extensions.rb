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
end

World(KnowstheDomain)