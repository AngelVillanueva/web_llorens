class ExpedientesDatatable
  delegate :params, :h, :link_to, :matricula_cell_whole, :documentos_cell, to: :@view

  def initialize(view, type, current_ability)
    @view = view
    @type = type
    @current_ability = current_ability
    @columns = type_columns
    @global_search_columns = global_search_columns
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @type.count,
      iTotalDisplayRecords: expedientes.total_count,
      aaData: data
    }
  end

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << formatted( @columns )
      expedientes("csv").each do |expediente|
        campos = expediente.attributes.values_at(*@columns)
        campos[0] = expediente.cliente.nombre
        csv << campos.take( campos.size - 1 )
      end
    end
  end

  private
  def data
    case @type.to_s
    when "Matriculacion"
      expedientes.map do |expediente|
        [
          expediente.cliente.nombre,
          matricula_cell_whole( expediente ),
          expediente.bastidor,
          expediente.comprador,
          expediente.modelo,
          I18n.l(expediente.fecha_alta),
          I18n.l(expediente.fecha_sale_trafico),
          documentos_cell( expediente )
        ]
      end
    when "Transferencia"
      expedientes.map do |expediente|
        [
          expediente.cliente.nombre,
          matricula_cell_whole( expediente ),
          expediente.comprador,
          expediente.vendedor,
          expediente.marca,
          I18n.l(expediente.fecha_alta),
          I18n.l(expediente.fecha_sale_trafico),
          expediente.dias_tramite,
          documentos_cell( expediente )
        ]
      end
    end
  end

  def expedientes(format=nil)
    expedientes ||= fetch_expedientes(format)
  end

  def fetch_expedientes(format=nil)
    # fetch expedientes on page load
    if format == "csv"
      expedientes = @type.unscoped.includes(:cliente).accessible_by( @current_ability )
    else
      expedientes = @type.includes(:cliente).accessible_by( @current_ability ).page( page ).per( per_page )
    end
    # if global search refine results
    if params[:sSearch].present?
      expedientes = global_search expedientes
    end
    # if column search refine results
    expedientes = column_search expedientes
    # sort if requested
    if params[:iSortCol_0].present?
      expedientes = expedientes.unscoped.order("#{sort_column} #{sort_direction}")
    end
    expedientes
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    @columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def global_search expedientes
    searched = params[:sSearch]
    searching = @global_search_columns.join(" ilike :search or ")
    searching << " ilike :search"
    expedientes = expedientes.where(searching, search: "%#{searched}%" )
  end

  def column_search expedientes
    for i in 0..@columns.count
      p = ("sSearch_" + i.to_s ).to_sym
      if params[p].present?
        searched = params[p]
        column = @columns[i]
        if column == "has_documentos"
          filter = searched == "Ver PDF" ? "TRUE" : "FALSE"
          expedientes = expedientes.where("#{column} IS #{filter}")
        elsif column.include? "fecha"
          lapse = searched.split("~")
          unless lapse[1].nil?
            f1 = lapse[0].to_date
            f2 = lapse[1].to_date
            expedientes = expedientes.where( "#{column} between :f1 and :f2", f1: f1, f2:f2 ) unless (searched.empty? || searched == "~")
          end
        else
          expedientes = expedientes.where("#{column} ilike :search", search: "%#{searched}%" ) unless (searched.empty? || searched == "~")
        end
      end
    end
    expedientes
  end

  def type_columns
    case @type.to_s
    when "Matriculacion"
      columns = %w[clientes.nombre matricula bastidor comprador modelo fecha_alta fecha_facturacion has_documentos]
    when "Transferencia"
      columns = %w[clientes.nombre matricula comprador vendedor marca fecha_alta fecha_facturacion updated_at has_documentos]
    end
    columns
  end

  def global_search_columns
    case @type.to_s
    when "Matriculacion"
      columns = %w[clientes.nombre matricula bastidor comprador modelo]
    when "Transferencia"
      columns = %w[clientes.nombre matricula comprador vendedor marca]
    end
    columns
  end

  def formatted columns
    columns.take(columns.size - 1).map(&:capitalize).join("-").gsub( "Clientes.nombre", "Cliente" ).split("-")
  end

  def clean(string_search, chars="~")
    chars = Regexp.escape(chars)
    string_search.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, "")
  end
end