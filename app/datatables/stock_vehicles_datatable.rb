class StockVehiclesDatatable
  delegate :params, :h, :link_to, :online_cliente_stock_vehicle_path, :vendido_cell, :completed_cell, :sent_cell, :received_cell, :definitive_cell, :finished_cell, :detail_cell, to: :@view

  def initialize(view, current_ability, cliente)
    @view = view
    @current_ability = current_ability
    @columns = columns
    @global_search_columns = global_search_columns
    @cliente = cliente
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: StockVehicle.count,
      iTotalDisplayRecords: stock_vehicles.total_count,
      aaData: data
    }
  end

  # def to_csv(options = {})
  #   CSV.generate(options) do |csv|
  #     csv << formatted( @columns )
  #     informes("csv").each do |informe|
  #       campos = informe.attributes.values_at(*@columns)
  #       campos[0] = informe.cliente.nombre
  #       campos[3] = I18n.l( campos[3], format: "%d/%m/%Y")
  #       campos[4].nil? ? campos[4] = I18n.t( "En curso" ) : campos[4] = I18n.t( "Finalizado" )
  #       csv << campos
  #     end
  #   end
  # end

  private
  def data
    stock_vehicles.map do |vehicle|
      [
        vehicle.matricula.upcase,
        vendido_cell( vehicle ),
        completed_cell( vehicle ),
        sent_cell( vehicle ),
        received_cell( vehicle ),
        definitive_cell( vehicle ),
        finished_cell( vehicle ),
        "<span class='details'></span>#{link_to I18n.t("Ver detalle"), online_cliente_stock_vehicle_path( @cliente, vehicle ), class: 'vehicle', 'data-remote' => true, 'data-type' => 'json'}".html_safe
      ]
    end
  end

  def stock_vehicles(format=nil)
    stock_vehicles ||= fetch_vehicles(format)
  end

  def fetch_vehicles(format=nil)
    # fetch expedientes on page load
    if format == "csv"
      vehicles = StockVehicle.unscoped.accessible_by( @current_ability ).order("#{sort_default}")
    elsif params[:iSortCol_0].present? # sort if requested
      vehicles = StockVehicle.unscoped.accessible_by( @current_ability ).order("#{sort_column} #{sort_direction}").page( page ).per( per_page )
    else
      vehicles = StockVehicle.accessible_by( @current_ability ).page( page ).per( per_page )
    end
    # if global search refine results
    if params[:sSearch].present?
      vehicles = global_search vehicles
    end
    # if column search refine results
    vehicles = column_search vehicles
    # return informes
    vehicles
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

  def sort_default
    "vendido DESC, created_at ASC"
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def global_search vehicles
    searched = params[:sSearch]
    searching = @global_search_columns.join(" ilike :search or ")
    searching << " ilike :search"
    vehicles = vehicles.where(searching, search: "%#{searched}%" )
  end

  def column_search vehicles
    for i in 0..@columns.count
      p = ("sSearch_" + i.to_s ).to_sym
      if params[p].present?
        searched = params[p]
        column = @columns[i]
        if column == "vendido"
          filter = searched == "En venta" ? false : true
          vehicles = vehicles.where("#{column} IS #{filter}")
        elsif column.include? "fecha"
          filter = searched == "No" ? "NULL" : "NOT NULL"
          vehicles = vehicles.where("#{column} IS #{filter}")
        elsif column == "observaciones"
          if searched == "No"
            vehicles = vehicles.where("fecha_expediente_completo OR fecha_documentacion_enviada OR fecha_documentacion_recibida OR fecha_envio_definitiva IS NULL")
          else
            vehicles = vehicles.where("fecha_expediente_completo AND fecha_documentacion_enviada AND fecha_documentacion_recibida AND fecha_envio_definitiva IS NOT NULL")
          end
        else
          vehicles = vehicles.where("#{column} ilike :search", search: "%#{searched}%" ) unless (searched.empty? || searched == "~")
        end
      end
    end
    vehicles
  end

  def columns
    columns = %w[matricula vendido fecha_expediente_completo fecha_documentacion_enviada fecha_documentacion_recibida fecha_envio_definitiva observaciones]
  end

  def global_search_columns
    columns = %w[matricula]
  end

  def formatted columns
    columns.map(&:capitalize).join("-").gsub( "Fecha_expediente_completo", "Expediente completo" ).gsub( "Fecha_documentacion_enviada", "Documentacion enviada" ).sub( "Fecha_documentacion_recibida", "Documentacion recibida" ).sub( "Fecha_envio_definitiva", "Envio Documentacion Definitiva" ).gsub( "Observaciones", "Finalizado" ).split("-")
  end

  def clean(string_search, chars="~")
    chars = Regexp.escape(chars)
    string_search.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, "")
  end
end