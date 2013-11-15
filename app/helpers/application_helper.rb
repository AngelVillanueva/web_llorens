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

  # Returns the folder name for the PDFs in the server
  def folder_name(type)
    case type
    when "Matriculacion"
      folder_name = "TU-MATRICULACIONES/"
    when "Transferencia"
      folder_name = "TR-TRANSFERENCIAS/"
    else
      folder_name = ""
    end
    folder_name
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
  # Returns the expediente type
  def expediente_type? expediente, type
    if expediente.type.downcase == type.downcase
      true
    else
      false
    end
  end

  # Section header helper
  def section_header header_text, organizacion
    content_tag 'h2', class: 'section_header' do
      # content_tag 'hr', class: 'left visible-desktop'
      # "<span>#{header_text}</span>"
      # content_tag 'hr', class: 'right visible-desktop'
      concat content_tag( 'hr', '', class: 'left visible-desktop' )
      concat content_tag( 'span', header_text )
      #concat content_tag( 'small', link_to( t( "volver inicio" ), online_root_path ) )
      concat content_tag( 'hr', '', class: 'right visible-desktop' )
      concat content_tag( 'span', organizacion , class: 'org' )
    end
  end

          # <% if expediente.matricula %>
          #   <%= expediente.matricula.upcase %>
          #   <% unless current_usuario.norole? %>
          #     <%= link_to t( "edit_matricula_PDF" ), edit_online_matriculacion_path( expediente ) %>
          #   <% end %>
          # <% else %>
          #   <% unless current_usuario.norole? %>
          #     <%= link_to t( "add_matricula_PDF" ), edit_online_matriculacion_path( expediente ) %>
          #   <% end %>
          # <% end %>
          # <% if expediente.pdf_file_name && File.exist?(expediente.pdf.path) %>
          #   <%= link_to t( "PDF matricula" ), expediente.pdf.url, target: "blank" %>
          # <% end %>

  def matricula_cell_matricula expediente
    matricula = expediente.matricula ? expediente.matricula.upcase : ""
  end
  def matricula_cell_pdf expediente
    if expediente.pdf_file_name && File.exist?(expediente.pdf.path)
      link_to expediente.pdf.url, target: "blank", class: "pdf-file" do
        content_tag( 'i', nil, class: 'icon icon-file' )
      end
    end
  end

  def matricula_cell_actions expediente
    unless current_usuario.norole?
      if expediente.pdf_file_name && File.exist?(expediente.pdf.path)
        link_to edit_online_matriculacion_path( expediente ), class: "pdf-edit" do
          content_tag( 'i', nil, class: 'icon icon-edit' )
        end
      else
        link_to t( "add_matricula_PDF" ), edit_online_matriculacion_path( expediente ), class: "pdf-add"
      end
    end
  end
  
  def tool_link_to_home
    link_to online_root_path, class:'pie', 'rel' => 'tooltip', 'data-original-title' => I18n.t("Inicio") do
      content_tag( 'i', nil, class: 'icon icon-2x icon-home' )
    end
  end
  def tool_link_to_table model
    link_to url_for(controller: model, action: 'index'), class: 'pie', 'rel' => 'tooltip', 'data-original-title' => I18n.t("Ver listado") do
      content_tag( 'i', nil, class: 'icon icon-2x icon-table' )
    end
  end
  def tool_link_to_print element
    link_to '#', class: 'print pie', 'data-print-area' => element, 'rel' => 'tooltip', 'data-original-title' => I18n.t("Imprimir") do
      content_tag( 'i', nil, class: 'icon icon-2x icon-print' )
    end
  end
  def tool_link_to_pdf linked
    link_to linked.pdf.url, class: 'pie','rel' => 'tooltip', 'data-original-title' => I18n.t("Ver PDF") do
      content_tag( 'i', nil, class: 'icon icon-2x icon-file' )
    end
  end
  def tool_link_to_new model
    link_to url_for(controller: model, action: 'new'), class: 'pie', 'rel' => 'tooltip', 'data-original-title' => I18n.t("Solicitar nuevo") do
      content_tag( 'i', nil, class: 'icon icon-2x icon-plus' )
    end
  end
  def tool_search_box
    link_to '#', class: 'search pie', 'rel' => 'tooltip', 'data-original-title' => I18n.t("Buscar") do
      content_tag( 'i', nil, class: 'icon icon-2x icon-search' )
    end
  end
  def tool_link_to_filter
    link_to '#', id: 'filtering', class: 'filtering pie', 'rel' => 'tooltip', 'data-original-title' => I18n.t("Filtrar") do
      content_tag( 'i', nil, class: 'icon icon-2x icon-signal' )
    end
  end
  def tool_link_to_reload model
    link_to online_expedientes_path(type: model), class: 'update pie', 'rel' => 'tooltip', 'data-original-title' => I18n.t("Actualizar") do
      content_tag( 'i', nil, class: 'icon icon-2x icon-undo' )
    end
  end

  def edit_pdf_label item
    if item.pdf_file_name.nil?
      I18n.t "Incluir PDF"
    else
      I18n.t "Cambiar PDF"
    end
  end

  def home_somos_link
    if request.fullpath == '/'
      link_to t('Quienes somos'), root_path, class: 'scroller', 'data-section' => '#somos'
    else
      link_to t('Quienes somos'), root_path(anchor: 'somos')
    end
  end
  def home_ofrecemos_link
    if request.fullpath == '/'
      link_to t('Que ofrecemos'), '#', class: 'scroller', 'data-section' => '#ofrecemos'
    else
      link_to t('Que ofrecemos'), root_path(anchor: 'ofrecemos')
    end
  end
  def home_equipo_link
    if request.fullpath == '/'
      link_to t('Nuestro equipo'), '#', class: 'scroller', 'data-section' => '#equipo'
    else
      link_to t('Nuestro equipo'), root_path(anchor: 'equipo')
    end
  end

  # Returns a pdf path if pdf is in the server
  def llorens_base_pdf expediente
    if Rails.env.production?
      template_pdf = "#{Rails.root}/public/assets/expedientes/#{folder_name(expediente.type)}#{expediente.identificador}.pdf"
    else
      template_pdf = "#{Rails.root}/app/assets/pdfs/expedientes/#{folder_name(expediente.type)}#{expediente.identificador}.pdf"
    end
  end
  # Returns true if a given expediente pdf is on the server
  def pdf_file(expediente)
    if Rails.env.production?
      the_pdf_file = "#{Rails.root}/public/assets/expedientes/#{folder_name(expediente.type)}#{expediente.identificador}.pdf"
    else
      the_pdf_file = "#{Rails.root}/app/assets/pdfs/expedientes/#{folder_name(expediente.type)}#{expediente.identificador}.pdf"
    end
    File.exist? the_pdf_file
  end
end
