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

  def matricula_cell_matricula expediente
    matricula = expediente.matricula ? expediente.matricula.upcase : t( "Pendiente_html" )
  end
  def matricula_cell_pdf expediente
    return unless expediente.created_at > Matriculacion.matriculable_pdf_date.to_time
    if expediente.pdf_file_name && File.exist?(expediente.pdf.path)
      link_to expediente.pdf.url, target: "blank", class: "pdf pdf-file", title: I18n.t( "Ver PDF" ) do
        content_tag( 'i', nil, class: 'icon icon-file' )
      end
    end
  end

  def matricula_cell_actions expediente
    return unless expediente.created_at > Matriculacion.matriculable_pdf_date.to_time
    unless current_usuario.norole?
      if expediente.pdf_file_name && File.exist?(expediente.pdf.path)
        link_to edit_online_matriculacion_path( expediente ), class: "pdf pdf-edit", title: I18n.t( "Cambiar PDF" ) do
          content_tag( 'i', nil, class: 'icon icon-edit' )
        end
      else
        link_to edit_online_matriculacion_path( expediente ), class: "pdf pdf-add", title: I18n.t( "Incluir PDF" ) do
          content_tag( 'i', nil, class: 'icon icon-plus-sign' )
        end
      end
    end
  end

  def matricula_cell_incidencia expediente
    if expediente.fecha_resolucion_incidencia.nil?
      d_content = expediente.incidencia
      d_icon = "icon-info-sign"
    else
      d_content = expediente.incidencia + ". <p><strong class='solved'>" + I18n.t( "Incidencia solucionada" ) + I18n.l( expediente.fecha_resolucion_incidencia ) + "</strong></p>"
      d_icon = "icon-check"
    end
    link_to '#', class: "incidencia", 'data-html' => 'true', 'data-toggle' => 'popover', 'data-content' => d_content, 'data-original-title' => I18n.t("Incidencia"), 'data-trigger' => 'hover', 'data-placement' => 'top'  do
      content_tag( 'i', nil, class: "icon #{d_icon}" )
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
  # returns the titulo for an Aviso with a default text if empty or nil
  def aviso_titular(aviso)
    if aviso.titular
      aviso.titular.empty? ? t( "Aviso" ) : aviso.titular
    else
      t( "Aviso" )
    end
  end
  # returns the content of the Expedientes Matricula cell
  def matricula_cell_whole( expediente )
    content_tag( 'div' ) do
      concat matricula_cell_matricula expediente
      if expediente_type? expediente, 'matriculacion'
        concat matricula_cell_pdf expediente
        concat matricula_cell_actions expediente
      elsif expediente.incidencia && !expediente.incidencia.empty?
        concat matricula_cell_incidencia expediente
      elsif Transferencia.no_incidenciable
        concat content_tag( 'i', nil, title: t( "Documentacion correcta" ), class: "noincidencia icon icon-circle")
      end
    end
  end
  # return the content of the Documento Pdf cell
  def documento_cell_pdf( documento )
    content_tag( 'div' ) do
      if documento.upload_pdf == true
        link_to downdoc_online_documento_path(documento), title: "PDF", target: '_blank', class: 'download_doc' do
          concat content_tag( 'span', t( "Descargar Orden" ) )
          concat content_tag( 'i', hidden_field_tag( 'docid', documento.id ), class: 'icon icon-file' )
       end
      end
    end
  end
  # return the content of the Driver Pdf cell
  def driver_cell_pdf( driver )
    content_tag( 'div' ) do
      unless driver.pdf_file_name.nil?
          link_to driver.pdf.url, title: "PDF", target: '_blank', class: 'icon' do
          content_tag( 'i', nil, class: 'icon icon-file' )
       end
      end
    end
  end
  # returns the content of the Expedientes Documentos cell
  def documentos_cell( expediente )
    if expediente.has_documentos
      link_to pdf_path( expediente ), target: '_blank', class: 'icon' do
        concat content_tag( 'span', t( "Ver PDF" ) )
        concat content_tag( 'i', nil, class: 'icon icon-file' )
      end
    else
      content_tag( 'span', t( "PDF Pendiente" ), class: 'pendiente' )
    end
  end
  # returns the content of the Justificantes / Informes Estado cell
  def estado_cell( object )
    object.pdf_file_name.nil? ? t("En curso") : t("Finalizado")
  end
  # returns the content of the Justificantes pdf_link cell
  def pdf_link_cell( justificante )
    unless justificante.pdf_file_name.nil?
      link_to justificante.pdf.url, title: "PDF", target: 'blank' do
          content_tag( 'i', nil, class: 'icon icon-file' )
       end
    end
  end
  # send sms with code validation of Mandato
  def sms_link_cell( mandato )
    if mandato.pending_code
      link_to '#', title: "SMS" do
          content_tag( 'i', nil, class: 'icon icon-envelope' )
       end
    end
  end

  # generate the content of the Mandato pdf_link cell if code validation
  def pdf_link_cell_m( mandato )
    unless mandato.pending_code
      link_to gen_mandato_online_mandato_path(mandato, :format => 'pdf'), title: "PDF", target: 'blank' do
          content_tag( 'i', nil, class: 'icon icon-file' )
       end
    else
      link_to view_validator_online_mandato_path(mandato), title: "CODE", remote: true, data: { toggle: "modal", target: "#code_mandato_modal"} do
          content_tag( 'i', nil, class: 'icon icon-barcode' )
       end
    end
  end
  # returns the content of the Informes pdf_link cell
  def pdf_link_cell_not_empty( informe )
    unless informe.pdf_file_name.nil?
      link_to informe.pdf.url, title: "PDF", target: 'blank' do
          content_tag( 'i', nil, class: 'icon icon-file' )
       end
    else
      t( "Pendiente")
    end
  end
  # returns the content of the Justificantes edit_link cell
  def edit_link_cell( justificante )
    unless current_usuario.norole?
      link_to edit_online_justificante_path(justificante), title: "Editar" do
        content_tag( 'i', nil, class: 'icon icon-edit toedit' )
      end
    end
  end
  # returns the content of the Justificantes edit_link cell
  def edit_link_cell_m( mandato )
    unless current_usuario.norole? || !mandato.pending_code
      link_to edit_online_mandato_path(mandato), title: "Editar" do
        content_tag( 'i', nil, class: 'icon icon-edit toedit' )
      end
    end
  end
  # returns the content of the Mandatos print_link cell
  def print_link_cell_m( mandato )
    unless mandato.pending_code
      link_to '#', class: "printLinkM" do
        content_tag( 'i', hidden_field_tag( 'scod', mandato.secure_token[0..5] ), class: 'icon icon-print' )
      end
    end
  end
  # returns the content of the Informes edit_link cell
  def edit_link_cell_i( informe )
    unless current_usuario.norole?
      link_to edit_online_informe_path(informe), title: "Editar" do
        concat content_tag( 'span', t( "Incluir PDF" ), class: 'toedit' ) if informe.pdf_file_name.nil?
        concat content_tag( 'span', t( "Cambiar PDF" ), class: 'toedit' ) unless informe.pdf_file_name.nil?
        concat content_tag( 'i', nil, class: 'icon icon-edit toedit' )
      end
    end
  end
  # returns the content of the Documento edit_link cell
  def edit_link_cell_d( documento )
    unless current_usuario.norole?
      link_to edit_online_documento_path(documento), title: "Editar" do
        content_tag( 'i', nil, class: 'icon icon-edit toedit' )
      end
    end
  end
  # returns the content of the Driver edit_link cell
  def edit_link_cell_dr( driver )
    if current_usuario.role == 'employee' || current_usuario.role == 'admin'
      link_to edit_online_driver_path(driver), title: "Editar" do
        content_tag( 'i', nil, class: 'icon icon-edit toedit' )
      end
    end
  end
  # returns the content of the Justificantes print_link cell
  def print_link_cell( justificante )
    link_to '#', class: "printLink" do
      content_tag( 'i', nil, class: 'icon icon-print' )
    end
  end
  # returns the content of the Matriculaciones IVTM cell
  def ivtm_cell matriculacion
    case matriculacion.ivtm
      when 0 then number_to_currency(0, precision: 0)
      when nil then ""
      else number_to_currency(matriculacion.ivtm.round(2))
    end
  end

  ## REMARKETING
  # returns "Vendido" of "En venta" depending on stock_vehicle.vendido? value
  def vendido_cell( stock_vehicle )
    stock_vehicle.vendido? && t( "Vendido" ) || t( "En venta" )
  end
  # returns content of expediente_completo?
  def completed_cell( stock_vehicle )
    stock_vehicle.expediente_completo? && icon_done(stock_vehicle.expediente_completo?) || icon_missing(stock_vehicle.expediente_completo?)
  end
  # returns content of documentacion_enviada?
  def sent_cell( stock_vehicle )
    stock_vehicle.documentacion_enviada? && icon_done(stock_vehicle.documentacion_enviada?) || icon_missing(stock_vehicle.documentacion_enviada?)
  end
  # returns content of documentacion_recibida?
  def received_cell( stock_vehicle )
    stock_vehicle.documentacion_recibida? && icon_done(stock_vehicle.documentacion_recibida?) || icon_missing(stock_vehicle.documentacion_recibida?)
  end
  # returns content of envio_documentacion_definitiva?
  def definitive_cell( stock_vehicle )
    stock_vehicle.envio_documentacion_definitiva? && icon_done(stock_vehicle.envio_documentacion_definitiva?) || icon_missing(stock_vehicle.envio_documentacion_definitiva?)
  end
  # returns content of finalizado?
  def finished_cell( stock_vehicle )
    stock_vehicle.finalizado? && icon_done(stock_vehicle.finalizado?) || icon_missing(stock_vehicle.finalizado?)
  end
  # returns a link to see the vehicle detail
  def detail_cell( stock_vehicle )
    link_to( I18n.t( "Ver detalle" ), root_path, class: 'vehicle', 'data-remote' => true, 'data-type' => 'json' )
  end
  # returns true if at least one Cliente (current_ability) has_remarketing?
  def remarketing_links?
    clientes = current_usuario.norole? && current_usuario.organizacion.clientes || Cliente.all
    clientes.map(&:has_remarketing?).include? true
  end

  # returns a list of link to the Remarketing page for any Cliente (current_ability) that has_remarketing
  def remarketing_link_list
    clientes = current_usuario.norole? && current_usuario.organizacion.clientes || Cliente.all
    clientes.each do |c|
      if c.has_remarketing?
        concat content_tag('li', link_to( c.nombre, online_cliente_stock_vehicles_path( c ), class: "remarketing" ) )
      end
    end
    nil
  end

  # returns a simple (first) link to the Remarketing page for any Cliente (current_ability) that has_remarketing
  def remarketing_link_first
    cliente = current_usuario.norole? && current_usuario.organizacion.clientes.where("has_remarketing = true").first || Cliente.where("has_remarketing = true").first
    if cliente.has_remarketing?
      online_cliente_stock_vehicles_path( cliente ) 
    end
  end

   # returns a simple (first) title link to the Remarketing page for any Cliente (current_ability) that has_remarketing
  def remarketing_link_title
    cliente = current_usuario.norole? && current_usuario.organizacion.clientes.where("has_remarketing = true").first || Cliente.where("has_remarketing = true").first
    if cliente.has_remarketing?
      link_to( cliente.nombre, online_cliente_stock_vehicles_path( cliente ) )
    end
  end

  # helpers for Remarketing cells
  def icon_done value
    content_tag( 'i', "<span>Si</span>".html_safe, class: 'done icon-circle' )
  end
  def icon_missing value
    content_tag( 'i', "<span>No</span>".html_safe, class: 'missing icon-circle' )
  end

  # returns a value in miliseconds for the interval of pulling new Avisos
  def new_avisos_pulltime
    Rails.env.test? || Rails.env.development? ? 3000 : 30000
  end
end
