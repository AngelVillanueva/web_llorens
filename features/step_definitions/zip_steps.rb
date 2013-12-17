Given(/^there are some Matriculaciones with pending temporary matricula pdf$/) do
  m1 = FactoryGirl.create( :matriculacion, bastidor: "UU15SDA4550075095" )
  m2 = FactoryGirl.create( :matriculacion, bastidor: "UU1HSDCL650118120" )
  m2 = FactoryGirl.create( :matriculacion, bastidor: "123456789ASDFREWQ" )
end

When(/^I upload a zip file containing one or more temporary matricula pdfs$/) do
  visit rails_admin.dashboard_path
  find( "li[data-model=zip_matricula] a" ).click
  first( '.new_collection_link a').click
  attach_file "zip_matricula_zip", "#{Rails.root}/spec/fixtures/my.zip"
  first( "button[type=submit]" ).click
end

Then(/^the matching Matriculaciones should be updated with their temporary pdfs$/) do
  m1 = Expediente.where( bastidor: "UU15SDA4550075095" ).first
  m2 = Expediente.where( bastidor: "UU1HSDCL650118120" ).first
  m3 = Expediente.where( bastidor: "123456789ASDFREWQ" ).first
  m1.pdf_file_name.should be "8007HTX_UU15SDA4550075095_MT13_0000305526.pdf"
  m2.pdf_file_name.should be "8010HTX_UU1HSDCL650118120_MT13_0000305529.pdf"
  m3.pdf.should be nil
end