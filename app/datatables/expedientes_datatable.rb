class ExpedientesDatatable
  delegate :params, :h, :link_to, :matricula_cell_whole, :documentos_cell, to: :@view

  def initialize(view, type, current_ability)
    @view = view
    @type = type
    @current_ability = current_ability
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
    expedientes = @type.scoped.accessible_by( @current_ability ).page( page ).per( per_page )
    if params[:sSearch].present?
      expedientes = expedientes.where("bastidor like :search or comprador like :search or modelo like :search", search: "%#{params[:sSearch]}%")
    end
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
    columns = %w[clientes.nombre matricula bastidor comprador modelo fecha_alta fecha_sale_trafico has_documentos]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end