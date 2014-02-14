describe Online::InformesController do
  #render_views
  before do
    # Sign in as a user.
    sign_in_as_a_valid_user
  end

  describe "when I access the page" do
    it "should return successfull response" do
      org = Organizacion.first
      cli = FactoryGirl.create( :cliente, organizacion: org )

      get online_cliente_path( cli )
      response.should be_success
    end
  end
end