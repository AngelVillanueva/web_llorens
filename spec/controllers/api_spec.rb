require 'spec_helper.rb'

describe Api::V1::ExpedientesController do
  render_views
  
  describe "when the allowed attributes are sent" do
    it "should return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente( Matriculacion ) }
      post :create_update, json
      response.should be_success
      Expediente.count.should eql 1
      Matriculacion.count.should eql 1
    end
  end
  describe "when mandatory fields are missing" do
    it "should not create a record" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_bad_expediente( Matriculacion ) }
      post :create_update, json
      response.should_not be_success
      Expediente.count.should eql 0
      Matriculacion.count.should eql 0
    end
  end
  describe "when not mandatory fields are missing" do
    it "should create a record" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_ongoing_expediente( Matriculacion ) }
      post :create_update, json
      response.should be_success
      Expediente.count.should eql 1
      Matriculacion.count.should eql 1
    end
  end
  describe "when not allowed attributes are sent" do
    it "should not return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expediente: { type: "Transferencia", identificadores: "IM1234" } }
      expect{ post :create_update, json}.to raise_error(ActionController::UnpermittedParameters)
      Expediente.count.should eql 0
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
    end
  end
  describe "when the Expediente already exists" do
    it "should just be updated" do
      previous = FactoryGirl.create(:matriculacion)
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente( Matriculacion, "IM-test", "BBB" ) }
      post :create_update, json
      Expediente.count.should eql 1
      Matriculacion.count.should eql 1
    end
  end
end

private
  def mock_expediente kind, identificador = "AAA", bastidor = "AAA"
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
    expediente[:cliente_id] = 1
    expediente[:observaciones] = "AAA"
    expediente
  end
  def mock_bad_expediente kind
    expediente = {}
    expediente[:type] = kind.to_s.camelize
    expediente[:identificador] = "AAA"
    expediente
  end
  def mock_ongoing_expediente kind
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
    expediente[:cliente_id] = 1
    expediente[:observaciones] = "AAA"
    expediente
  end
  def mock_expedientes
    expedientes = []
    matriculacion = {}
    transferencia = {}   
    matriculacion["expediente"] = mock_expediente(Matriculacion)
    transferencia["expediente"] = mock_expediente(Transferencia)
    expedientes << matriculacion
    expedientes << transferencia
    expedientes
  end
