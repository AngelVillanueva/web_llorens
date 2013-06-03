require 'spec_helper.rb'

describe Api::V1::ExpedientesController do
  render_views
  
  describe "when the allowed attributes are sent" do
    it "should return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente( Matriculacion ) }
      post :create, json
      response.should be_success
      Expediente.count.should eql 1
      Matriculacion.count.should eql 1
    end
  end
  describe "when not allowed attributes are sent" do
    it "should return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expediente: { type: "Transferencia", identificadores: "IM1234" } }
      expect{ post :create, json}.to raise_error(ActionController::UnpermittedParameters)
      Expediente.count.should eql 0
    end
  end
  describe "when more than one is sent together" do
    it "should return successful response" do
      request.accept = "application/json"
      json = { format: 'json', expediente: mock_expediente( Transferencia ) }
      post :create, json
      response.should be_success
      Expediente.count.should eql 2
      Matriculacion.count.should eql 1
      Transferencia.count.should eql 1
    end
  end
end

private
  def mock_expediente kind
    expediente = {}
    expediente[:type] = kind.to_s.camelize
    expediente[:identificador] = "AAA"
    expediente[:bastidor] = "AAA"
    expediente[:matricula] = "AAA"
    expediente[:comprador] = "AAA"
    expediente[:vendedor] = "AAA"
    expediente[:fecha_entra_trafico] = 5.days.ago.to_date
    expediente[:fecha_alta] = 3.days.ago.to_date
    expediente[:fecha_facturacion] = 1.day.ago.to_date
    expediente[:marca] = "AAA"
    expediente[:modelo] = "AAA"
    expediente[:organizacion_id] = 1
    expediente[:observaciones] = "AAA"
    expediente
  end
