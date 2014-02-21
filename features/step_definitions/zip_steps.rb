Given(/^there are some Matriculaciones with pending temporary matricula pdf$/) do
  m1 = FactoryGirl.create( :matriculacion, bastidor: "UU15SDA4550075095" )
  m2 = FactoryGirl.create( :matriculacion, bastidor: "UU1HSDCL650118120" )
  m2 = FactoryGirl.create( :matriculacion, bastidor: "123456789ASDFREWQ" )
end

Given(/^I have created a new zipped bundled of temporary matricula pdfs$/) do
  step "I upload a zip file containing one or more temporary matricula pdfs"
end

When(/^I upload a zip file containing one or more temporary matricula pdfs$/) do
  visit rails_admin.dashboard_path
  find( "li[data-model=zip_matricula] a" ).click
  first( '.new_collection_link a').click
  attach_file "zip_matricula_zip", "#{Rails.root}/spec/fixtures/my.zip"
  first( "button[type=submit]" ).click
end

When(/^I unzip the bundle$/) do
  find( "li.read_xml_member_link a").click
end

Then(/^a new zip file with one or more temporary matricula pdfs should be created$/) do
  ZipMatricula.count.should eql(1)
end

Then(/^the matching Matriculaciones should be updated with their temporary pdfs$/) do
  m1 = Matriculacion.where( bastidor: "UU15SDA4550075095" ).first
  m2 = Matriculacion.where( bastidor: "UU1HSDCL650118120" ).first
  m3 = Matriculacion.where( bastidor: "123456789ASDFREWQ" ).first
  expect( m1.pdf_file_name ).to eq( "8007HTX_UU15SDA4550075095_MT13_0000305526.pdf" )
  expect( m2.pdf_file_name ).to eq( "8010HTX_UU1HSDCL650118120_MT13_0000305529.pdf" )
  expect( m3.pdf.to_s ).to eql( "/pdfs/original/missing.png" )
  m3.pdf_file_size.should be nil
end

Then(/^the bundle should be marked as unbundled$/) do
  ZipMatricula.last.expandido.should eql true
end