class MandatosDatatable
  delegate :params, :h, :link_to, :estado_cell, :sms_link_cell, :pdf_link_cell_m, :edit_link_cell_m, :print_link_cell_m, to: :@view

  def initialize(view, current_ability)
    @view = view
    @current_ability = current_ability
    @columns = columns
    @global_search_columns = global_search_columns
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Mandato.count,
      iTotalDisplayRecords: mandatos.total_count,
      aaData: data
    }
  end

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << formatted( @columns )
      mandatos("csv").each do |mandato|
        campos = mandato.attributes.values_at(*@columns)
        campos[0] = mandato.cliente.nombre
        campos[12] = I18n.l( campos[12], format: "%d/%m/%Y %H:%m")
        campos[13].nil? ? campos[13] = I18n.t( "Pendiente" ) : campos[13] = I18n.l( campos[13], format: "%d/%m/%Y %H:%m")
        csv << campos.take( campos.size - 1 )
      end
    end
  end

  private
  def data
    mandatos.map do |mandato|
      [
        mandato.cliente.nombre,
        mandato.matricula_bastidor.upcase,
        mandato.nif_comprador,
        mandato.nombre_razon_social,
        mandato.primer_apellido,
        mandato.segundo_apellido,
        mandato.municipio,
        mandato.provincia,
        mandato.direccion,
        mandato.telefono,
        mandato.marca,
        mandato.modelo,
        mandato.hora_solicitud.nil? ? "" : I18n.l( mandato.hora_solicitud, format: "%d/%m/%Y %H:%M" ),
        mandato.hora_entrega.nil? ? "" : I18n.l( mandato.hora_entrega, format: "%d/%m/%Y %H:%M" ),
        estado_cell( mandato ),
        sms_link_cell( mandato),
        pdf_link_cell_m( mandato ),
        edit_link_cell_m( mandato ),
        print_link_cell_m( mandato)
      ]
    end
  end

  def mandatos(format=nil)
    mandatos ||= fetch_mandatos(format)
  end

  def fetch_mandatos(format=nil)
    # fetch expedientes on page load
    if format == "csv"
      mandatos = Mandato.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_default}")
    elsif params[:iSortCol_0].present? # sort if requested
      mandatos = Mandato.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_column} #{sort_direction}").page( page ).per( per_page )
    else
      mandatos = Mandato.includes(:cliente).accessible_by( @current_ability ).page( page ).per( per_page )
    end
    # if global search refine results
    if params[:sSearch].present?
      mandatos = global_search mandatos
    end
    # if column search refine results
    mandatos = column_search mandatos
    # return mandatos
    mandatos
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_default
    "pending_code DESC, updated_at DESC"
  end

  def sort_column
    @columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def global_search mandatos
    searched = params[:sSearch]
    searching = @global_search_columns.join(" ilike :search or ")
    searching << " ilike :search"
    mandatos = mandatos.where(searching, search: "%#{searched}%" )
  end

  def column_search mandatos
    for i in 0..@columns.count
      p = ("sSearch_" + i.to_s ).to_sym
      if params[p].present?
        searched = params[p]
        column = @columns[i]
        mandatos = mandatos.where("#{column} ilike :search", search: "%#{searched}%" ) unless (searched.empty? || searched == "~")
      end
    end
    mandatos
  end

  def columns
    columns = %w[clientes.nombre matricula_bastidor nif_comprador nombre_razon_social primer_apellido segundo_apellido municipio provincia direccion telefono marca modelo hora_solicitud hora_entrega pdf_file_name]
  end

  def global_search_columns
    columns = %w[clientes.nombre matricula_bastidor nif_comprador nombre_razon_social primer_apellido segundo_apellido  municipio provincia direccion telefono marca modelo]
  end

  def formatted columns
    columns.take(columns.size - 1).map(&:capitalize).join("-").gsub( "Clientes.nombre", "Cliente" ).split("-")
  end

  def clean(string_search, chars="~")
    chars = Regexp.escape(chars)
    string_search.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, "")
  end
end