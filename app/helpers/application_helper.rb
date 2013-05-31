module ApplicationHelper
  
  # Returns the full title on a per-page basis.       # Documentation comment
   def full_title(page_title)                          # Method definition
     base_title = t("Brandname")  # Variable assignment
     if page_title.empty?                              # Boolean test
       base_title                                      # Implicit return
     else
       "#{page_title} | #{base_title}"                 # String interpolation
     end
   end

  # Returns the pdf route for a given expediente
  def pdf_path(expediente)
    if expediente.type == "Transferencia"
      transferencia_path(expediente, format: :pdf)
    else
      matriculacion_path(expediente, format: :pdf)
    end
  end
end
