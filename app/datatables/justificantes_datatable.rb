class JustificantesDatatable
  delegate :params, :h, :link_to, :estado_cell, :pdf_link_cell, :edit_link_cell, :print_link_cell, to: :@view

  def initialize(view, current_ability)
    @view = view
    @current_ability = current_ability
    @columns = columns
    @global_search_columns = global_search_columns
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Justificante.count,
      iTotalDisplayRecords: justificantes.total_count,
      aaData: data
    }
  end

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << formatted( @columns )
      justificantes("csv").each do |justificante|
        campos = justificante.attributes.values_at(*@columns)
        campos[0] = justificante.cliente.nombre
        campos[13] = I18n.l( campos[13], format: "%d/%m/%Y %H:%m")
        campos[14].nil? ? campos[14] = I18n.t( "Pendiente" ) : campos[14] = I18n.l( campos[14], format: "%d/%m/%Y %H:%m")
        csv << campos.take( campos.size - 1 )
      end
    end
  end

  private
  def data
    justificantes.map do |justificante|
      [
        justificante.cliente.nombre,
        justificante.matricula.upcase,
        justificante.bastidor,
        justificante.nif_comprador,
        justificante.nombre_razon_social,
        justificante.primer_apellido,
        justificante.segundo_apellido,
        justificante.municipio,
        justificante.codpostal,
        justificante.provincia,
        justificante.direccion,
        justificante.marca,
        justificante.modelo,
        justificante.hora_solicitud.nil? ? "" : I18n.l( justificante.hora_solicitud, format: "%d/%m/%Y %H:%m" ),
        justificante.hora_entrega.nil? ? "" : I18n.l( justificante.hora_entrega, format: "%d/%m/%Y %H:%m" ),
        estado_cell( justificante ),
        pdf_link_cell( justificante ),
        edit_link_cell( justificante ),
        print_link_cell( justificante)
      ]
    end
  end

  def justificantes(format=nil)
    justificantes ||= fetch_justificantes(format)
  end

  def fetch_justificantes(format=nil)
    # fetch expedientes on page load
    if format == "csv"
      justificantes = Justificante.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_default}")
    elsif params[:iSortCol_0].present? # sort if requested
      justificantes = Justificante.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_column} #{sort_direction}").page( page ).per( per_page )
    else
      justificantes = Justificante.includes(:cliente).accessible_by( @current_ability ).page( page ).per( per_page )
    end
    # if global search refine results
    if params[:sSearch].present?
      justificantes = global_search justificantes
    end
    # if column search refine results
    justificantes = column_search justificantes
    # return justificantes
    justificantes
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_default
    "pending_pdf DESC, updated_at DESC"
  end

  def sort_column
    @columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def global_search justificantes
    searched = params[:sSearch]
    searching = @global_search_columns.join(" ilike :search or ")
    searching << " ilike :search"
    justificantes = justificantes.where(searching, search: "%#{searched}%" )
  end

  def column_search justificantes
    for i in 0..@columns.count
      p = ("sSearch_" + i.to_s ).to_sym
      if params[p].present?
        searched = params[p]
        column = @columns[i]
        justificantes = justificantes.where("#{column} ilike :search", search: "%#{searched}%" ) unless (searched.empty? || searched == "~")
      end
    end
    justificantes
  end

  def columns
    columns = %w[clientes.nombre matricula bastidor nif_comprador nombre_razon_social primer_apellido segundo_apellido municipio codpostal provincia direccion marca modelo hora_solicitud hora_entrega pdf_file_name]
  end

  def global_search_columns
    columns = %w[clientes.nombre matricula bastidor nif_comprador nombre_razon_social primer_apellido segundo_apellido municipio codpostal provincia direccion marca modelo]
  end

  def formatted columns
    columns.take(columns.size - 1).map(&:capitalize).join("-").gsub( "Clientes.nombre", "Cliente" ).split("-")
  end

  def clean(string_search, chars="~")
    chars = Regexp.escape(chars)
    string_search.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, "")
  end
end