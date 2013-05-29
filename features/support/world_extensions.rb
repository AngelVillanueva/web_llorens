module KnowstheDomain
  def organizacion
    @organizacion ||= FactoryGirl.create( :organizacion )
  end
  def usuario
    usuario ||= FactoryGirl.create( :usuario, organizacion: organizacion )
  end
  def expediente
    @expediente || FactoryGirl.create( :expediente, organizacion: organizacion )
  end
end

World(KnowstheDomain)