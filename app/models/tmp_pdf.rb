class TmpPdf
  def initialize base_pdf, initial_page=1, tmp_path="#{Rails.root}/base_pdf_tmp.pdf"
    @path = tmp_path
    @initial_page = initial_page
    final_page = PDF::Reader.new(base_pdf).page_count + 1
    @final_page = final_page

    step1 = RGhost::Convert.new(base_pdf)
    step2 = step1.to :pdf, filename: tmp_path, range: initial_page..final_page

  end

  def initial_page
    @initial_page
  end

  def final_page
    @final_page
  end

  def path
    @path
  end
  
end