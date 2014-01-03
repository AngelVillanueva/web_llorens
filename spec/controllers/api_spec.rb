require 'spec_helper.rb'

describe Api::V1::ExpedientesController do
  render_views
  after(:each) do # empty custom api logger test file to avoid false positives
    api_log_file = "#{Rails.root}/log/api_test.log"
    File.open(api_log_file, 'w') {} if File.exists?(api_log_file)
  end
  
  describe "when the allowed attributes are sent" do
    it "should return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente( Matriculacion ) }
      post :create_or_update_single, json
      response.should be_success
      Expediente.count.should eql 1
      Matriculacion.count.should eql 1
      check_custom_log_file
    end
  end
  describe "when mandatory fields are missing" do
    it "should not create a record" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_bad_expediente( Matriculacion ) }
      post :create_or_update_single, json
      response.should_not be_success
      Expediente.count.should eql 0
      Matriculacion.count.should eql 0
      check_custom_log_file
    end
  end
  describe "when not mandatory fields are missing" do
    it "should create a record" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_ongoing_expediente( Matriculacion ) }
      post :create_or_update_single, json
      response.should be_success
      Expediente.count.should eql 1
      Matriculacion.count.should eql 1
      check_custom_log_file
    end
  end
  describe "when not allowed attributes are sent" do
    it "should not return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expediente: { type: "Transferencia", identificadores: "IM1234" } }
      expect{ post :create_or_update_single, json}.to raise_error(ActionController::UnpermittedParameters)
      Expediente.count.should eql 0
      check_custom_log_file(0)
    end
  end
  describe "when a non valid cliente_id is sent" do
    it "should not create a record" do
      request.accept = "application/json"
      expediente = mock_expediente( Matriculacion )
      expediente[:cliente_id] = 111
      json = { format: 'json', expediente: expediente }
      post :create_or_update_single, json
      response.should_not be_success
      Expediente.count.should eql 0
      Matriculacion.count.should eql 0
      check_custom_log_file
    end
  end
  describe "when a special cliente_id is sent" do
    it "should not create a record" do
      request.accept = "application/json"
      expediente = mock_expediente( Matriculacion )
      expediente[:cliente_id] = "4300999999"
      json = { format: 'json', expediente: expediente }
      post :create_or_update_single, json
      response.should be_success
      Expediente.count.should eql 0
      Matriculacion.count.should eql 0
      check_custom_log_file
    end
  end
  describe "when more than one is sent together" do
    it "should return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expedientes: mock_expedientes }
      post :create_batch, json
      response.should be_success
      Expediente.count.should eql 2
      Matriculacion.count.should eql 1
      Transferencia.count.should eql 1
      check_custom_log_file
    end
  end
  describe "when the Expediente already exists" do
    it "should just be updated" do
      previous = FactoryGirl.create(:matriculacion)
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente( Matriculacion, "IM-test", "BBB" ) }
      post :create_or_update_single, json
      Expediente.count.should eql 1
      Matriculacion.count.should eql 1
      check_custom_log_file
    end
  end
  describe "when updated without Fecha Alta" do
    it "should respect the previous Fecha Alta" do
      previous = FactoryGirl.create(:matriculacion)
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente_wo_alta( Matriculacion, "IM-test" ) }
      expect { post :create_or_update_single, json }.not_to change( Matriculacion.last, :fecha_alta )
      check_custom_log_file
    end
  end
  describe "when created without Matricula" do
    it "should be allowed for Matriculaciones" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente_wo_matricula( Matriculacion ) }
      post :create_or_update_single, json
      response.should be_success
      Expediente.count.should eql 1
      Matriculacion.count.should eql 1
      Transferencia.count.should eql 0
      check_custom_log_file
    end
    it "should not be allowed for Transferencias" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente_wo_matricula( Transferencia ) }
      post :create_or_update_single, json
      response.should_not be_success
      Expediente.count.should eql 0
      Matriculacion.count.should eql 0
      Transferencia.count.should eql 0
      check_custom_log_file
    end
  end
  describe "when multiple updated without Fecha Alta" do
    it "should respect the previous Fecha Alta" do
      previous = FactoryGirl.create(:matriculacion)
      request.accept = "application/json"
      json = { format: 'json', expedientes: mock_expedientes(true) }
      expect { post :create_batch, json }.not_to change( Matriculacion.first, :fecha_alta )
      check_custom_log_file
    end
  end
  describe "when multiple updated without valid cliente_id" do
    it "should not create a valid record" do
      request.accept = "application/json"
      json = { format: 'json', expedientes: mock_expedientes(false, true) }
      post :create_batch, json
      response.should be_success
      Expediente.count.should eql 1
      Matriculacion.count.should eql 0
      Transferencia.count.should eql 1
      check_custom_log_file
    end
  end
  describe "when multiple sent with some special cliente_id" do
    it "should not create a valid record" do
      request.accept = "application/json"
      json = { format: 'json', expedientes: mock_expedientes(false, true, true) }
      post :create_batch, json
      response.should be_success
      Expediente.count.should eql 1
      Matriculacion.count.should eql 0
      Transferencia.count.should eql 1
      check_custom_log_file
    end
  end
  describe "when an Incidencia is sent" do
    it "should return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente( Transferencia ) }
      post :create_or_update_single, json
      response.should be_success
      Expediente.count.should eql 1
      Transferencia.count.should eql 1
      t = Transferencia.first
      t.incidencia.should eql ("Hay tomate")
      check_custom_log_file
    end
  end
  describe "when an Incidencia is sent with solving date" do
    it "should return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente( Transferencia ) }
      post :create_or_update_single, json
      response.should be_success
      Expediente.count.should eql 1
      Transferencia.count.should eql 1
      t = Transferencia.first
      t.incidencia.should eql ("Hay tomate")
      t.fecha_resolucion_incidencia.should eql Date.today
      check_custom_log_file
    end
  end
  describe "when multiple Expedientes are sent and one Incidencia is sent with solving date" do
    it "should return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expedientes: mock_expedientes }
      post :create_batch, json
      response.should be_success
      Expediente.count.should eql 2
      Transferencia.count.should eql 1
      t = Transferencia.first
      t.incidencia.should eql ("Hay tomate")
      t.fecha_resolucion_incidencia.should eql Date.today
      check_custom_log_file
    end
  end
end

private
  def mock_expediente kind, identificador = "AAA", bastidor = "AAA"
    cliente = FactoryGirl.create( :cliente )
    expediente = {}
    expediente[:type] = kind.to_s.camelize
    expediente[:identificador] = identificador
    expediente[:bastidor] = bastidor
    expediente[:matricula] = "AAA"
    expediente[:comprador] = "AAA"
    expediente[:vendedor] = "AAA"
    expediente[:fecha_entra_trafico] = 5.days.ago.to_date
    expediente[:fecha_alta] = 3.days.ago.to_date
    expediente[:fecha_facturacion] = 1.day.ago.to_date
    expediente[:marca] = "AAA"
    expediente[:modelo] = "AAA"
    expediente[:cliente_id] = cliente.llorens_cliente_id
    expediente[:observaciones] = "AAA"
    expediente[:incidencia] = "Hay tomate"
    expediente[:fecha_resolucion_incidencia] = Date.today
    expediente
  end
  def mock_bad_expediente kind
    expediente = {}
    expediente[:type] = kind.to_s.camelize
    expediente[:identificador] = "AAA"
    expediente
  end
  def mock_ongoing_expediente kind
    cliente = FactoryGirl.create( :cliente )
    expediente = {}
    expediente[:type] = kind.to_s.camelize
    expediente[:identificador] = "AAA"
    expediente[:bastidor] = "AAA"
    expediente[:matricula] = "AAA"
    expediente[:comprador] = "AAA"
    expediente[:vendedor] = "AAA"
    expediente[:fecha_entra_trafico] = "" 
    expediente[:fecha_alta] = 2.days.ago.to_date
    expediente[:fecha_facturacion] = ""
    expediente[:marca] = "AAA"
    expediente[:modelo] = "AAA"
    expediente[:cliente_id] = cliente.llorens_cliente_id
    expediente[:observaciones] = "AAA"
    expediente
  end
  def mock_expediente_wo_alta kind, identificador = "AAA", bastidor = "AAA"
    cliente = FactoryGirl.create( :cliente )
    expediente = {}
    expediente[:type] = kind.to_s.camelize
    expediente[:identificador] = identificador
    expediente[:bastidor] = bastidor
    expediente[:matricula] = "AAA"
    expediente[:comprador] = "AAA"
    expediente[:vendedor] = "AAA"
    expediente[:fecha_entra_trafico] = 5.days.ago.to_date
    expediente[:fecha_alta] = ""
    expediente[:fecha_facturacion] = 1.days.ago.to_date
    expediente[:marca] = "AAA"
    expediente[:modelo] = "AAA"
    expediente[:cliente_id] = cliente.llorens_cliente_id
    expediente[:observaciones] = "AAA"
    expediente
  end
  def mock_expediente_wo_matricula kind
    cliente = FactoryGirl.create( :cliente )
    expediente = {}
    expediente[:type] = kind.to_s.camelize
    expediente[:identificador] = "AAA"
    expediente[:bastidor] = "BBB"
    expediente[:matricula] = nil
    expediente[:comprador] = "AAA"
    expediente[:vendedor] = "AAA"
    expediente[:fecha_entra_trafico] = 5.days.ago.to_date
    expediente[:fecha_alta] = 4.days.ago.to_date
    expediente[:fecha_facturacion] = 1.days.ago.to_date
    expediente[:marca] = "AAA"
    expediente[:modelo] = "AAA"
    expediente[:cliente_id] = cliente.llorens_cliente_id
    expediente[:observaciones] = "AAA"
    expediente
  end
  def mock_expedientes wo_alta=false, wo_cliente=false, sp_cliente=false
    expedientes = []
    matriculacion = {}
    transferencia = {}   
    matriculacion["expediente"] = mock_expediente(Matriculacion)
    if wo_alta
      matriculacion["expediente"] = mock_expediente_wo_alta(Matriculacion, "IM-test", "test")
    end
    if wo_cliente
      matriculacion["expediente"][:cliente_id] = 111
    end
    if sp_cliente
      matriculacion["expediente"][:cliente_id] = "4300999999"
    end
    transferencia["expediente"] = mock_expediente(Transferencia)
    expedientes << matriculacion
    expedientes << transferencia
    expedientes
  end
  def check_custom_log_file allowed=nil
    File.open("#{Rails.root}/log/api_test.log", "r") do |file|
      unless allowed
        file.lines.count.should_not eql 0
        file.lines.count.should_not eql 1
      else
        file.lines.count.should eql allowed
      end
    end
  end
