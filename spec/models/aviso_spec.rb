require 'spec_helper'

describe Aviso do
  let( :aviso ) { FactoryGirl.create( :aviso ) }
  let( :usuario1 ) { FactoryGirl.create( :usuario ) }
  let( :usuario2 ) { FactoryGirl.create( :usuario, email: "el2@example.com" ) }
  subject { aviso }

  describe "with valid attributes" do
    it { should respond_to :titular }
    it { should respond_to :contenido }
    it { should respond_to :fecha_de_caducidad }
    it { should respond_to :notificaciones }
    it { should respond_to :usuarios }

    it { should be_valid }
  end

  describe "with mandatory fields" do
    it { should validate_presence_of :contenido }
  end

  describe "with valid nil value for fecha de caducidad" do
    let( :aviso_wo_fecha ) { FactoryGirl.create( :aviso, fecha_de_caducidad: nil ) }
    subject { aviso_wo_fecha }
    it "should default to 1 year from now" do
      expect( aviso_wo_fecha ).to be_valid
      expect( aviso_wo_fecha.fecha_de_caducidad.to_i ).to eql( 1.year.from_now.to_i )
    end
  end

  describe "a new Aviso should create as many Notificaciones as Usuarios" do
    it "should increment the count" do
      expect( usuario1 ).to be_valid
      expect( usuario2 ).to be_valid
      expect( Usuario.count ).to eql(2)
      expect { new_aviso = FactoryGirl.create( :aviso ) }.to change{ Notificacion.count }.by(2)
    end
  end

end