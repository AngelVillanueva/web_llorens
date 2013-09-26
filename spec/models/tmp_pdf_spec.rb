

describe TmpPdf do
  after(:all) do
    File.delete "#{Rails.root}/base_pdf_tmp.pdf"
  end
  let( :temporary_file ) { TmpPdf.new( "#{Rails.root}/app/assets/pdfs/expedientes/TR-TRANSFERENCIAS/TR-2000-01271.pdf" ) }
  subject { temporary_file }

  describe "as a Model" do
    it { should respond_to :initial_page }
    it { should respond_to :final_page }
    it { should respond_to :path}

    its(:initial_page) { should eql 1 }
    its(:path) { should eql "#{Rails.root}/base_pdf_tmp.pdf" }
  end

  describe "when created from a base pdf" do
    it "should create a temporary file via rghost" do
      expect(File.exists? "#{Rails.root}/base_pdf_tmp.pdf").to eql true
    end
  end
end