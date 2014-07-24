require 'spec_helper'

describe Online::AvisosController do
  before do
    # Sign in as a user.
    sign_in_as_a_valid_user
    aviso = FactoryGirl.create( :aviso )
    aviso_2 = FactoryGirl.create( :aviso )
  end
  it "should accept json requests" do
    get '/online/avisos', format: :json
    response.should be_success
  end
  it "should return a json message with the living Avisos" do
    get '/online/avisos', format: :json
    body = JSON.parse(response.body)
    body.should include('avisos')
    avisos = body['avisos']
    avisos.should have(2).items
    avisos.all? {|aviso| aviso.key?('titular')}.should be_true
    avisos.any? {|aviso| aviso.key?('contenido')}.should be_true
    avisos.any? {|aviso| aviso.key?('bad_key')}.should be_false
  end
  it "should change the shown status of an Aviso" do
    post online_aviso_change_shown_status_path( Aviso.first, shown: true ), format: :json
    response.should be_success
    body = JSON.parse(response.body)
    body['shown'].should eql "true"
    post online_aviso_change_shown_status_path( Aviso.last, shown: false ), format: :json
    response.should be_success
    body = JSON.parse(response.body)
    body['shown'].should eql "false"
  end
  it "should return true if an Aviso is already shown" do
    post online_aviso_change_shown_status_path( Aviso.first, shown: true ), format: :json
    get online_aviso_path( Aviso.first ), format: :json
    response.should be_success
    body = JSON.parse(response.body)
    body['shown'].should be_true
  end
end