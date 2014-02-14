describe Online::ClientesController do
  #render_views
  before do
    # Sign in as a user.
    sign_in_as_a_valid_user
  end

  describe "when I access the page" do
    it "should return successfull response" do
      org = Organizacion.first
      cli = FactoryGirl.create( :cliente, organizacion: org )
      current_usuario = Usuario.first
      current_usuario.clientes << cli

      get online_cliente_path( cli )
      response.should be_success
    end
    it "should not return successfull response if Cliente is not mine" do
      org = FactoryGirl.create( :organizacion )
      cli = FactoryGirl.create( :cliente, organizacion: org )

      get online_cliente_path( cli )
      response.should_not be_success
    end
    it "should return successfull response if I am admin" do
      org = FactoryGirl.create( :organizacion )
      cli = FactoryGirl.create( :cliente, organizacion: org )
      current_usuario = Usuario.first
      current_usuario.role = "admin"
      current_usuario.save!

      get online_cliente_path( cli )
      response.should be_success
    end
    it "should return successfull response if I am employee" do
      org = FactoryGirl.create( :organizacion )
      cli = FactoryGirl.create( :cliente, organizacion: org )
      current_usuario = Usuario.first
      current_usuario.role = "employee"
      current_usuario.save!

      get online_cliente_path( cli )
      response.should be_success
    end
  end
end