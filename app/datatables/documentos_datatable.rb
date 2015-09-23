class DocumentosDatatable
  delegate :params, :h, :link_to, :documento_cell_pdf, :edit_link_cell_d, :print_link_cell, to: :@view

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
      csv << formatted( @columns )
      documentos("csv").each do |documento|
        campos = documento.attributes.values_at(*@columns)
        campos[0] = documento.cliente.nombre
        campos[12] = I18n.l( campos[12], format: "%d/%m/%Y %H:%m")
        campos[13].nil? ? campos[13] = I18n.t( "Pendiente" ) : campos[13] = I18n.l( campos[13], format: "%d/%m/%Y %H:%m")
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
        documento.fecha_recepcion.nil? ? "" : I18n.l( documento.fecha_recepcion, format: "%d/%m/%Y" ),
        documento_cell_pdf( documento ),
        documento.pdf_updated_at.nil? ? "" : I18n.l( documento.pdf_updated_at, format: "%d/%m/%Y" ),
        documento.observaciones,
        documento.upload_pdf.nil? ? '<i class="icon icon-circle circle-red"></i>' : '<i class="icon icon-circle circle-green"></i>',
        documento.download_pdf.nil? ? '<i class="icon icon-circle circle-red"></i>' : '<i class="icon icon-circle circle-green"></i>',
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
        if column.include? "fecha"
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
    columns = %w[bastidor ficha_tecnica concesionario fecha_recepcion pdf_file_name pdf_updated_at observaciones upload_pdf download_pdf]
  end

  def global_search_columns
    columns = %w[bastidor ficha_tecnica concesionario]
  end

  def clean(string_search, chars="~")
    chars = Regexp.escape(chars)
    string_search.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, "")
  end
end