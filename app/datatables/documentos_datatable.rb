class DocumentosDatatable
  delegate :params, :h, :link_to, :documento_cell_pdf, :observaciones_link_cell_d, :edit_link_cell_d, :print_link_cell, to: :@view

  def initialize(view, current_ability)
    @view = view
    @current_ability = current_ability
    @columns = columns
    @global_search_columns = global_search_columns
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Documento.count,
      iTotalDisplayRecords: documentos.total_count,
      aaData: data
    }
  end

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["Bastidor", "Ficha Tecnica", "Concesionario", "Contrato", "Fecha Recepcion", "Orden Matriculacion", "Fecha Carga", "Observaciones", "Doc Cargado", "Doc Descargado"] ## Header values of CSV
      documentos("csv").each do |documento|
        campos = documento.attributes.values_at(*@columns)
        campos[1] = campos[1] ? "Normal" : "Electronica"
        campos[6] = campos[6].nil? ? "" : I18n.l( campos[6], format: "%d/%m/%Y %H:%m")
        campos[8] = campos[8] ? "Si" : "No"
        campos[9] = campos[9] ? "Si" : "No"
        campos[10] = ""
        csv << campos.take( campos.size - 1 )
      end
    end
  end

  private
  def data
    documentos.map do |documento|
      [
        documento.bastidor,
        documento.ficha_tecnica == true ? I18n.t( "Electronica" ) : I18n.t( "Normal" ),
        documento.concesionario,
        documento.contrato,
        documento.fecha_recepcion.nil? ? "" : I18n.l( documento.fecha_recepcion, format: "%d/%m/%Y" ),
        documento_cell_pdf( documento ),
        documento.pdf_updated_at.nil? ? "" : I18n.l( documento.pdf_updated_at, format: "%d/%m/%Y" ),
        documento.observaciones,
        documento.upload_pdf ? '<i class="icon icon-circle circle-green"></i>' : '<i class="icon icon-circle circle-red"></i>',
        documento.download_pdf ? '<i class="icon icon-circle circle-green"></i>' : '<i class="icon icon-circle circle-red"></i>',
        observaciones_link_cell_d( documento ),
        edit_link_cell_d( documento ),
        print_link_cell( documento)
      ]
    end
  end

  def documentos(format=nil)
    documentos ||= fetch_documentos(format)
  end

  def fetch_documentos(format=nil)
    # fetch expedientes on page load
    if format == "csv"
      documentos = Documento.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_default}")
    elsif params[:iSortCol_0].present? # sort if requested
      documentos = Documento.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_column} #{sort_direction}").page( page ).per( per_page )
    else
      documentos = Documento.includes(:cliente).accessible_by( @current_ability ).page( page ).per( per_page )
    end
    # if global search refine results
    if params[:sSearch].present?
      documentos = global_search documentos
    end
    # if column search refine results
    documentos = column_search documentos
    # return documentos
    documentos
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_default
    "upload_pdf DESC, download_pdf DESC, updated_at DESC"
  end

  def sort_column
    @columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def global_search documentos
    searched = params[:sSearch]
    searching = @global_search_columns.join(" ilike :search or ")
    searching << " ilike :search"
    documentos = documentos.where(searching, search: "%#{searched}%" )
  end

  def column_search documentos
    for i in 0..@columns.count
      p = ("sSearch_" + i.to_s ).to_sym
      if params[p].present?
        searched = params[p]
        column = @columns[i]
        if column == "download_pdf" || column == "upload_pdf"
          filter = searched == "Si" ? "TRUE" : "FALSE"
          documentos = documentos.where("#{column} IS #{filter}")
        elsif column.include? "fecha"
          lapse = searched.split("~")
          unless lapse[1].nil?
            f1 = lapse[0].to_date
            f2 = lapse[1].to_date
            documentos = documentos.where( "#{column} between :f1 and :f2", f1: f1, f2:f2 ) unless (searched.empty? || searched == "~")
          end
        elsif column.include? "pdf_updated_at"
          lapse = searched.split("~")
          unless lapse[1].nil?
            f1 = lapse[0].to_datetime.beginning_of_day
            f2 = lapse[1].to_datetime.end_of_day
            documentos = documentos.where( "#{column} between :f1 and :f2", f1: f1, f2:f2 ) unless (searched.empty? || searched == "~")
          end 
        else
          documentos = documentos.where("#{column} ilike :search", search: "%#{searched}%" ) unless (searched.empty? || searched == "~")
        end
      end
    end
    documentos
  end

  def columns
    columns = %w[bastidor ficha_tecnica concesionario contrato fecha_recepcion pdf_file_name pdf_updated_at observaciones upload_pdf download_pdf]
  end

  def global_search_columns
    columns = %w[bastidor ficha_tecnica concesionario contrato]
  end

  def formatted columns
    columns
  end

  def clean(string_search, chars="~")
    chars = Regexp.escape(chars)
    string_search.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, "")
  end
end