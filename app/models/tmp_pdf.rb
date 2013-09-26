class TmpPdf
  def initialize base_pdf, initial_page=1
    final_page = PDF::Reader.new(base_pdf).page_count + 1

    step1 = RGhost::Convert.new(base_pdf)
    step2 = step1.to :pdf, filename: "#{Rails.root}/base_pdf_tmp.pdf", range: initial_page..final_page
  end

  def initial_page
    self.initial_page
  end

  def final_page
    self.final_page
  end
  
end