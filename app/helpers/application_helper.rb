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

  # Checks if whithin the Online namespace
  def in_online?
    controller.class.name.split("::").first=="Online"
  end

  # Returns the pdf route for a given expediente
  def pdf_path(expediente)
    if expediente.type == "Transferencia"
      online_transferencia_path(expediente, format: :pdf)
    else
      online_matriculacion_path(expediente, format: :pdf)
    end
  end
  # Returns the typed route for a given expediente
  def this_expediente_path(expediente)
    if expediente.type == "Transferencia"
      online_transferencia_path(expediente)
    else
      online_matriculacion_path(expediente)
    end
  end
  # Returns the typed route for a expediente type
  def these_expedientes_path(expediente)
    if expediente.type == "Transferencia"
      online_transferencias_path
    else
      online_matriculaciones_path
    end
  end
end
