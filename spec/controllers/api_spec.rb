require 'spec_helper.rb'

describe Api::V1::ExpedientesController do
  render_views
  
  describe "when the allowed attributes are sent" do
    it "should return successful response" do
      pending
      # request.accept = "application/json"
      # json = { format: 'json', expediente: { identificador: "IM1234" } }
      # post :create, json
      # response.should be_success
    end
  end
  describe "when not allowed attributes are sent" do
    it "should return successful response" do
      pending
      # request.accept = "application/json"
      # json = { format: 'json', expediente: { identificadores: "IM1234" } }
      # expect{ post :create, json}.to raise_error(ActionController::UnpermittedParameters)
    end
  end
end