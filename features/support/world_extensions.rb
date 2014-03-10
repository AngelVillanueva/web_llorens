  module KnowstheDomain
  def organizacion
    @organizacion ||= FactoryGirl.create( :organizacion )
  end
  def cliente
    @cliente ||= FactoryGirl.create( :cliente, organizacion: organizacion )
  end
  def usuario
    usuario ||= FactoryGirl.create( :usuario, organizacion: organizacion )
    usuario.clientes << cliente if usuario.clientes.empty?
    usuario
  end
  def usuario_pw_expired
    usuario_pw_expired ||= FactoryGirl.create(:usuario, organizacion: organizacion, password_changed_at: 13.months.ago )
  end
  def admin
    admin ||= FactoryGirl.create( :usuario, nombre: "super", role: "admin" )
  end
  def employee
    employee ||= FactoryGirl.create( :usuario, nombre: "semi", role: "employee" )
  end
  def remarketing_employee
    remarketing_employee ||= FactoryGirl.create( :usuario, nombre: "partial", role: "remarketing" )
  end
  def matriculacion
    @matriculacion || FactoryGirl.create( :matriculacion, cliente: cliente )
  end
  def matriculacion_sin_matricula
    @matriculacion || FactoryGirl.create( :matriculacion, matricula:nil, cliente: cliente )
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