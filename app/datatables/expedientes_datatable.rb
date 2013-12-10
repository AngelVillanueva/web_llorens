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

  private
  def data
    expedientes.map do |expediente|
      [
        expediente.cliente.nombre,
        matricula_cell_whole( expediente ),
        expediente.bastidor,
        expediente.comprador,
        expediente.modelo,
        expediente.fecha_alta,
        expediente.fecha_sale_trafico,
        documentos_cell( expediente )
      ]
    end
  end

  def expedientes
    expedientes ||= fetch_expedientes
  end

  def fetch_expedientes
    # fetch expedientes on page load
    expedientes = @type.unscoped.includes(:cliente).accessible_by( @current_ability ).page( page ).per( per_page )
    # if global search refine results
    if params[:sSearch].present?
      expedientes = global_search expedientes
    end
    # if column search refine results
    expedientes = column_search expedientes
    # sort if requested
    if params[:iSortCol_0].present?
      expedientes = expedientes.order("#{sort_column} #{sort_direction}")
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
        expedientes = expedientes.where("#{column} ilike :search", search: "%#{searched}%" ) unless searched == "~"
      end
    end
    expedientes
  end

  def type_columns
    case @type.to_s
    when "Matriculacion"
      columns = %w[clientes.nombre matricula bastidor comprador modelo fecha_alta fecha_sale_trafico has_documentos]
    when "Transferencia"
      columns = %w[clientes.nombre]
    end
    columns
  end

  def global_search_columns
    case @type.to_s
    when "Matriculacion"
      columns = %w[clientes.nombre matricula bastidor comprador modelo]
    when "Transferencia"
      columns = %w[clientes.nombre]
    end
    columns
  end
end