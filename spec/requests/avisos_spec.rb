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
end