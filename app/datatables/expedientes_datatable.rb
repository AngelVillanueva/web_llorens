class ExpedientesDatatable
  delegate :params, :h, :link_to, :matricula_cell_whole, :documentos_cell, :ivtm_cell, to: :@view

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
      if @type.to_s == "Matriculacion"
        csv << ["Cliente", "Matricula", "Fecha_matriculacion", "Bastidor", "Comprador", "Modelo", "Fecha_alta", "Fecha_facturacion", "Ivtm"] ## Header values of CSV
      else
        csv << formatted( @columns )
      end
      expedientes("csv").each do |expediente|
        campos = expediente.attributes.values_at(*@columns)
        campos[0] = expediente.cliente.nombre
        if @type.to_s == "Transferencia"
          # empty Incidencia value if already solved
          campos[8] = "" unless campos[7].nil?
          # substitute fecha_resolucion_incidencia value for dias_tramite calculation
          campos[6].nil? ? campos[7] = "" : campos[7] = (campos[6] - campos[5]).to_i
          campos[5] = I18n.l( campos[5], format: "%d/%m/%Y")
          campos[6].nil? ? campos[6] = "" : campos[6] = I18n.l( campos[6], format: "%d/%m/%Y")
        end
        
        if @type.to_s == "Matriculacion"
          campos[2] = I18n.l( campos[2], format: "%d/%m/%Y")
          campos[6] = I18n.l( campos[6], format: "%d/%m/%Y")
          campos[7].nil? ? campos[7] = "" : campos[7] = I18n.l( campos[7], format: "%d/%m/%Y")
        end

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
          expediente.pdf_updated_at.nil? ? "" : I18n.l(expediente.pdf_updated_at, :format => :date),
          expediente.bastidor,
          expediente.comprador,
          expediente.modelo,
          I18n.l(expediente.fecha_alta),
          expediente.fecha_sale_trafico.nil? ? "" : I18n.l(expediente.fecha_sale_trafico),
          ivtm_cell( expediente ),
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
          expediente.fecha_sale_trafico.nil? ? "" : I18n.l(expediente.fecha_sale_trafico),
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
      expedientes = @type.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_default}")
    elsif params[:iSortCol_0].present?
      expedientes = @type.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_column} #{sort_direction}").page( page ).per( per_page )
    else
      expedientes = @type.includes(:cliente).accessible_by( @current_ability ).page( page ).per( per_page )
    end
    # if global search refine results
    if params[:sSearch].present?
      expedientes = global_search expedientes
    end
    # if column search refine results
    expedientes = column_search expedientes
    # return expedientes
    expedientes
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_default
    case @type.to_s
    when "Matriculacion"
      sort_default = "created_at DESC"
    when "Transferencia"
      sort_default = "has_incidencia DESC, fecha_resolucion_incidencia DESC, updated_at DESC"
    end
    sort_default
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
        elsif column == "ivtm"
          filter = searched.gsub(",", ".").to_f
          expedientes = expedientes.where("#{column} = ?", filter)
        elsif column.include? "fecha"
          lapse = searched.split("~")
          unless lapse[1].nil?
            f1 = lapse[0].to_date
            f2 = lapse[1].to_date
            expedientes = expedientes.where( "#{column} between :f1 and :f2", f1: f1, f2:f2 ) unless (searched.empty? || searched == "~")
          end
        elsif column.include? "pdf_updated_at"
          lapse = searched.split("~")
          unless lapse[1].nil?
            f1 = lapse[0].to_datetime.beginning_of_day
            f2 = lapse[1].to_datetime.end_of_day
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
      columns = %w[clientes.nombre matricula pdf_updated_at bastidor comprador modelo fecha_alta fecha_facturacion ivtm has_documentos]
    when "Transferencia"
      columns = %w[clientes.nombre matricula comprador vendedor marca fecha_alta fecha_facturacion fecha_resolucion_incidencia has_documentos]
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
    case @type.to_s
    when "Matriculacion"
      columns.take(columns.size - 1).map(&:capitalize).join("-").gsub( "Clientes.nombre", "Cliente" ).split("-")
    when "Transferencia"
      # take last element to re-insert later
      last = columns.pop
      # add Transferencia.incidencia
      columns << "incidencia"
      # re-insert last column
      columns << last
      # format columns
      columns.take(columns.size - 1).map(&:capitalize).join("-").gsub( "Clientes.nombre", "Cliente" ).gsub( "Fecha_resolucion_incidencia", "Dias tramite" ).split("-")
    end
  end

  def clean(string_search, chars="~")
    chars = Regexp.escape(chars)
    string_search.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, "")
  end
end