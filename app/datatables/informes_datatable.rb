class InformesDatatable
  delegate :params, :h, :link_to, :estado_cell, :pdf_link_cell_not_empty, :edit_link_cell_i, :print_link_cell, to: :@view

  def initialize(view, current_ability)
    @view = view
    @current_ability = current_ability
    @columns = columns
    @global_search_columns = global_search_columns
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Informe.count,
      iTotalDisplayRecords: informes.total_count,
      aaData: data
    }
  end

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << formatted( @columns )
      informes("csv").each do |informe|
        campos = informe.attributes.values_at(*@columns)
        campos[0] = informe.cliente.nombre
        campos[3] = I18n.l( campos[3], format: "%d/%m/%Y")
        campos[4].nil? ? campos[4] = I18n.t( "En curso" ) : campos[4] = I18n.t( "Finalizado" )
        csv << campos
      end
    end
  end

  private
  def data
    informes.map do |informe|
      [
        informe.cliente.nombre,
        informe.matricula.upcase,
        informe.solicitante,
        I18n.l( informe.created_at, format: "%d/%m/%Y" ),
        estado_cell( informe ),
        pdf_link_cell_not_empty( informe ),
        edit_link_cell_i( informe ),
        print_link_cell( informe )
      ]
    end
  end

  def informes(format=nil)
    informes ||= fetch_informes(format)
  end

  def fetch_informes(format=nil)
    # fetch expedientes on page load
    if format == "csv"
      informes = Informe.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_default}")
    elsif params[:iSortCol_0].present? # sort if requested
      informes = Informe.unscoped.includes(:cliente).accessible_by( @current_ability ).order("#{sort_column} #{sort_direction}").page( page ).per( per_page )
    else
      informes = Informe.includes(:cliente).accessible_by( @current_ability ).page( page ).per( per_page )
    end
    # if global search refine results
    if params[:sSearch].present?
      informes = global_search informes
    end
    # if column search refine results
    informes = column_search informes
    # return informes
    informes
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
    "pdf_content_type DESC, created_at DESC"
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

  def column_search informes
    for i in 0..@columns.count
      p = ("sSearch_" + i.to_s ).to_sym
      if params[p].present?
        searched = params[p]
        column = @columns[i]
        if column == "pdf_file_name"
          filter = searched == "Finalizado" ? "NOT NULL" : "NULL"
          informes = informes.where("#{column} IS #{filter}")
        elsif column.include? "created"
          lapse = searched.split("~")
          unless lapse[1].nil?
            f1 = lapse[0].to_date.beginning_of_day
            f2 = lapse[1].to_date.end_of_day
            informes = informes.where( "#{column} between :f1 and :f2", f1: f1, f2:f2 ) unless (searched.empty? || searched == "~")
          end
        else
          informes = informes.where("#{column} ilike :search", search: "%#{searched}%" ) unless (searched.empty? || searched == "~")
        end
      end
    end
    informes
  end

  def columns
    columns = %w[clientes.nombre matricula solicitante created_at pdf_file_name pdf_file_name]
  end

  def global_search_columns
    columns = %w[clientes.nombre matricula solicitante]
  end

  def formatted columns
    columns.map(&:capitalize).join("-").gsub( "Clientes.nombre", "Cliente" ).gsub( "Created_at", "Fecha solicitud" ).sub( "Pdf_file_name", "Estado" ).sub( "Pdf_file_name", "Archivo PDF" ).split("-")
  end

  def clean(string_search, chars="~")
    chars = Regexp.escape(chars)
    string_search.gsub(/\A[#{chars}]+|[#{chars}]+\Z/, "")
  end
end