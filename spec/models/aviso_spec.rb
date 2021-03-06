# == Schema Information
#
# Table name: avisos
#
#  id                              :integer          not null, primary key
#  contenido                       :text
#  titular                         :string(255)
#  fecha_de_caducidad              :date
#  dias_visible_desde_ultimo_login :integer
#  created_at                      :datetime
#  updated_at                      :datetime
#  sorting_order                   :integer
#

require 'spec_helper'

describe Aviso do
  let( :aviso ) { FactoryGirl.create( :aviso ) }
  let( :usuario1 ) { FactoryGirl.create( :usuario ) }
  let( :usuario2 ) { FactoryGirl.create( :usuario, email: "el2@example.com" ) }
  let( :new_aviso ) { FactoryGirl.create( :aviso, sorting_order: 10 ) }
  subject { aviso }

  describe "with valid attributes" do
    it { should respond_to :titular }
    it { should respond_to :contenido }
    it { should respond_to :fecha_de_caducidad }
    it { should respond_to :sorting_order }
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

  describe "with valid nil value for dias visible desde ultimo login" do
    let( :aviso_wo_dias_visible ) { FactoryGirl.create( :aviso, dias_visible_desde_ultimo_login: nil ) }
    subject { aviso_wo_dias_visible }
    it "should default to 1 week from now" do
      expect( aviso_wo_dias_visible ).to be_valid
      expect( aviso_wo_dias_visible.dias_visible_desde_ultimo_login.to_i ).to eql( 7 )
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

  describe "a new Aviso is auto-assigned with the first available sorting_order if not informed" do
    it "should be the first" do
      aviso.sorting_order.should eql 1
    end
  end

  describe "when two Avisos have the same sorting order" do
    it "the newer goes first" do
      aviso_1 = FactoryGirl.create( :aviso, sorting_order: 1 )
      aviso_2 = FactoryGirl.create( :aviso, sorting_order: 1 )
      expect( Aviso.first ).to eql aviso_2
    end
  end

  describe "a destroyed Aviso should also destroy the related Notificaciones" do
    it "should destroy the related" do
      expect( usuario1 ).to be_valid
      expect( usuario2 ).to be_valid
      expect { new_aviso }.to change{ Notificacion.count }.by(2)
      expect { Aviso.last.destroy }.to change{ Notificacion.count }.by( -2 )
    end
  end

end
