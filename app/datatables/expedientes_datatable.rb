class ExpedientesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

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
        expediente.matricula,
        expediente.bastidor,
        expediente.comprador,
        expediente.modelo,
        expediente.fecha_alta,
        expediente.fecha_sale_trafico,
        expediente.has_documentos
      ]
    end
  end

  def expedientes
    expedientes ||= fetch_expedientes
  end

  def fetch_expedientes
    #expedientes = Expediente.includes(:cliente).order("#{sort_column} #{sort_direction}")
    #expedientes = expedientes.page(page).per(per_page)
    expedientes = @type.scoped.accessible_by( @current_ability ).page( params[ :page ] ).per( 10 )
    if params[:sSearch].present?
      expedientes = expedientes.where("bastidor like :search or comprador like :search or modelo like :search", search: "%#{params[:sSearch]}%")
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
    columns = %w[bastidor comprador]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end