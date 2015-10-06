class DriversDatatable
  delegate :params, :h, :link_to, :driver_cell_pdf, :observaciones_link_cell_dr, :edit_link_cell_dr, :print_link_cell, to: :@view

  def initialize(view, current_ability)
    @view = view
    @current_ability = current_ability
    @columns = columns
    @global_search_columns = global_search_columns
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Driver.count,
      iTotalDisplayRecords: drivers.total_count,
      aaData: data
    }
  end

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << formatted( @columns )
      drivers("csv").each do |driver|
        campos = driver.attributes.values_at(*@columns)
        campos[0] = driver.cliente.nombre
        campos[12] = I18n.l( campos[12], format: "%d/%m/%Y %H:%m")
        campos[13].nil? ? campos[13] = I18n.t( "Pendiente" ) : campos[13] = I18n.l( campos[13], format: "%d/%m/%Y %H:%m")
        csv << campos.take( campos.size - 1 )
      end
    end
  end

  private
  def data
    drivers.map do |driver|
      [
        driver.matricula,
        driver.bastidor,
        driver.fecha_matriculacion.nil? ? "" : I18n.l( driver.fecha_matriculacion, format: "%d/%m/%Y" ),
        driver.envio_ok ? '<i class="icon icon-circle circle-green"></i>' : '<i class="icon icon-circle circle-red"></i>',
        driver.fecha_envio.nil? ? "" : I18n.l( driver.fecha_envio, format: "%d/%m/%Y" ),
        driver.concesionario_cliente == true ? I18n.t( "Concesionario" ) : I18n.t( "Cliente" ),
        driver.direccion,
        driver.persona_contacto,
        driver_cell_pdf( driver ),
        observaciones_link_cell_dr( driver ),
        edit_link_cell_dr( driver ),
        print_link_cell( driver)
      ]
    end
  end

  def drivers(format=nil)
    drivers ||= fetch_drivers(format)
  end

  def fetch_drivers(format=nil)
    # fetch expedientes on page load
    if format == "csv"
      drivers = Driver.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_default}")
    elsif params[:iSortCol_0].present? # sort if requested
      drivers = Driver.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_column} #{sort_direction}").page( page ).per( per_page )
    else
      drivers = Driver.includes(:cliente).accessible_by( @current_ability ).page( page ).per( per_page )
    end
    # if global search refine results
    if params[:sSearch].present?
      drivers = global_search drivers
    end
    # if column search refine results
    drivers = column_search drivers
    # return drivers
    drivers
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_default
    "envio_ok DESC, updated_at DESC"
  end

  def sort_column
    @columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def global_search drivers
    searched = params[:sSearch]
    searching = @global_search_columns.join(" ilike :search or ")
    searching << " ilike :search"
    drivers = drivers.where(searching, search: "%#{searched}%" )
  end

  # def column_search drivers
  #   for i in 0..@columns.count
  #     p = ("sSearch_" + i.to_s ).to_sym
  #     if params[p].present?
  #       searched = params[p]
  #       column = @columns[i]
  #       if column.include? "fecha"
  #         lapse = searched.split("~")
  #         unless lapse[1].nil?
  #           f1 = lapse[0].to_date.beginning_of_day
  #           f2 = lapse[1].to_date.end_of_day
  #           drivers = drivers.where( "#{column} between :f1 and :f2", f1: f1, f2:f2 ) unless (searched.empty? || searched == "~")
  #         end
  #       else
  #         drivers = drivers.where("#{column} ilike :search", search: "%#{searched}%" ) unless (searched.empty? || searched == "~")
  #     end
  #   end
  #   drivers
  # end

  def column_search drivers
    for i in 0..@columns.count
      p = ("sSearch_" + i.to_s ).to_sym
      if params[p].present?
        searched = params[p]
        column = @columns[i]
        if column == "envio_ok"
          filter = searched == "Si" ? "TRUE" : "FALSE"
          drivers = drivers.where("#{column} IS #{filter}")
        elsif column.include? "fecha"
          lapse = searched.split("~")
          unless lapse[1].nil?
            f1 = lapse[0].to_date.beginning_of_day
            f2 = lapse[1].to_date.end_of_day
            drivers = drivers.where( "#{column} between :f1 and :f2", f1: f1, f2:f2 ) unless (searched.empty? || searched == "~")
          end
        else
          drivers = drivers.where("#{column} ilike :search", search: "%#{searched}%" ) unless (searched.empty? || searched == "~")
        end
      end
    end
    drivers
  end

  def columns
    columns = %w[matricula bastidor fecha_matriculacion envio_ok fecha_envio concesionario_cliente direccion persona_contacto pdf_file_name]
  end

  def global_search_columns
    columns = %w[matricula bastidor]
  end

  def clean(string_search, chars="~")
    chars = Regexp.escape(chars)
    string_search.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, "")
  end
end