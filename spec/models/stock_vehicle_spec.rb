# == Schema Information
#
# Table name: stock_vehicles
#
#  id                           :integer          not null, primary key
#  matricula                    :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  cliente_id                   :integer
#  marca                        :string(255)
#  modelo                       :string(255)
#  vendido                      :boolean          default(FALSE)
#  comprador                    :string(255)
#  ft                           :boolean          default(FALSE)
#  pc                           :boolean          default(FALSE)
#  fecha_itv                    :date
#  incidencia                   :text
#  fecha_expediente_completo    :date
#  fecha_documentacion_enviada  :date
#  fecha_documentacion_recibida :date
#  fecha_notificado_cliente     :date
#  particular                   :boolean          default(FALSE)
#  compra_venta                 :boolean          default(FALSE)
#  fecha_envio_gestoria         :date
#  baja_exportacion             :boolean          default(TRUE)
#  fecha_entregado_david        :date
#  fecha_envio_definitiva       :date
#  observaciones                :text
#

require 'spec_helper'

describe StockVehicle do
  let( :vehiculo ) { FactoryGirl.create( :stock_vehicle ) }
  subject { vehiculo }

  it { should respond_to :matricula }
  it { should validate_presence_of :matricula }
  it { should validate_uniqueness_of :matricula }
  it { should respond_to :marca }
  it { should respond_to :modelo }
  it { should respond_to :vendido }
  it { should respond_to :comprador }
  it { should respond_to :ft }
  it { should respond_to :pc }
  it { should respond_to :fecha_itv }
  it { should respond_to :incidencia }
  it { should respond_to :fecha_expediente_completo }
  it { should respond_to :fecha_documentacion_enviada }
  it { should respond_to :fecha_notificado_cliente }
  it { should respond_to :particular }
  it { should respond_to :compra_venta }
  it { should respond_to :fecha_envio_gestoria }
  it { should respond_to :baja_exportacion }
  it { should respond_to :fecha_entregado_david }
  it { should respond_to :fecha_envio_definitiva }
  it { should respond_to :observaciones }
  it { should belong_to :cliente }
  it { should be_valid }
end

describe "default scope for StockVehicle is based on Vendido status" do
  let( :vehiculo_antiguo ) { FactoryGirl.create( :stock_vehicle, matricula: "older" ) }
  let( :vehiculo_nuevo ) { FactoryGirl.create( :stock_vehicle, matricula: "sold" )}

  it "returning first the ones no Vendidos" do
    vehiculo_antiguo.vendido = false
    vehiculo_antiguo.save!
    vehiculo_nuevo.vendido = true
    vehiculo_nuevo.save!
    StockVehicle.first.matricula.should eql "sold"
  end
end

describe "default scope for StockVehicle is Vendidos first and then from older to newer" do
  let( :vehiculo_1 ) { FactoryGirl.create( :stock_vehicle, matricula: "primero" ) }
  let( :vehiculo_2 ) { FactoryGirl.create( :stock_vehicle, matricula: "segundo" ) }
  let( :vehiculo_3 ) { FactoryGirl.create( :stock_vehicle, matricula: "tercero" ) }

  it "should return the right order" do
    vehiculo_1.vendido = false
    vehiculo_1.save!
    vehiculo_2.vendido = true
    vehiculo_2.save!
    vehiculo_3.vendido = true
    vehiculo_3.save!
    StockVehicle.first.matricula.should eql "segundo"
    StockVehicle.last.matricula.should eql "primero"
  end

end

describe "a new StockVehicle should have a default Vendido FALSE value" do
  let( :nuevo_vehiculo ) { StockVehicle.new }
  subject { nuevo_vehiculo }

  its( :vendido ) { should eql false }
end

describe "a StockVehicle should have a live status" do
  let( :mi_vehiculo ) { FactoryGirl.create( :stock_vehicle ) }
  subject { mi_vehiculo }

  it { should respond_to :expediente_completo? }
  it { should respond_to :documentacion_enviada? }
  it { should respond_to :documentacion_recibida? }
  it { should respond_to :envio_documentacion_definitiva? }
  it { should respond_to :finalizado? }
  it "with FALSE as default value for all the status fields" do
    mi_vehiculo.expediente_completo?.should eql false
    mi_vehiculo.documentacion_enviada?.should eql false
    mi_vehiculo.documentacion_recibida?.should eql false
    mi_vehiculo.envio_documentacion_definitiva?.should eql false
    mi_vehiculo.finalizado?.should eql false
  end
  it "should change status if Expediente Completo" do
    mi_vehiculo.fecha_expediente_completo = Date.today
    expect( mi_vehiculo.expediente_completo? ).to eql true
  end
  it "should change status if Documentacion Enviada" do
    mi_vehiculo.fecha_documentacion_enviada = Date.today
    expect( mi_vehiculo.documentacion_enviada? ).to eql true
  end
  it "should change status if Documentacion Recibida" do
    mi_vehiculo.fecha_documentacion_recibida = Date.today
    expect( mi_vehiculo.documentacion_recibida? ).to eql true
  end
  it "should change status if Envio Documentacion Definitiva" do
    mi_vehiculo.fecha_envio_definitiva = Date.today
    expect( mi_vehiculo.envio_documentacion_definitiva? ).to eql true
  end
  it "should change status to Finalizado if all is done" do
    mi_vehiculo.fecha_expediente_completo = 4.days.ago.to_date
    mi_vehiculo.fecha_documentacion_enviada = 3.days.ago.to_date
    mi_vehiculo.fecha_documentacion_recibida = Date.yesterday
    mi_vehiculo.fecha_envio_definitiva = Date.today
    expect( mi_vehiculo.finalizado? ).to eql true
  end
end
