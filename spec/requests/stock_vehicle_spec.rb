describe Online::StockVehiclesController do
  before do
    # Sign in as a user.
    sign_in_as_a_valid_user
  end

  describe "when I request the page in json format" do
    it "should return successfull response" do
      org = Organizacion.first
      cli = FactoryGirl.create( :cliente, organizacion: org, has_remarketing: true )
      current_usuario = Usuario.first
      current_usuario.clientes << cli
      vehicle = FactoryGirl.create( :stock_vehicle, cliente: cli)

      get online_cliente_stock_vehicles_path( cli, format: "json" )
      response.should be_success
    end
  end
end