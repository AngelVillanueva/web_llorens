class InformeTraficosController < ApplicationController
  # GET /informe_traficos
  # GET /informe_traficos.json
  def index
    @informe_traficos = InformeTrafico.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @informe_traficos }
    end
  end

  # GET /informe_traficos/1
  # GET /informe_traficos/1.json
  def show
    @informe_trafico = InformeTrafico.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @informe_trafico }
    end
  end

  # GET /informe_traficos/new
  # GET /informe_traficos/new.json
  def new
    @informe_trafico = InformeTrafico.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @informe_trafico }
    end
  end

  # GET /informe_traficos/1/edit
  def edit
    @informe_trafico = InformeTrafico.find(params[:id])
  end

  # POST /informe_traficos
  # POST /informe_traficos.json
  def create
    @informe_trafico = InformeTrafico.new(informe_trafico_params)

    respond_to do |format|
      if @informe_trafico.save
        format.html { redirect_to @informe_trafico, notice: 'Informe trafico was successfully created.' }
        format.json { render json: @informe_trafico, status: :created, location: @informe_trafico }
      else
        format.html { render action: "new" }
        format.json { render json: @informe_trafico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /informe_traficos/1
  # PATCH/PUT /informe_traficos/1.json
  def update
    @informe_trafico = InformeTrafico.find(params[:id])

    respond_to do |format|
      if @informe_trafico.update_attributes(informe_trafico_params)
        format.html { redirect_to @informe_trafico, notice: 'Informe trafico was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @informe_trafico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /informe_traficos/1
  # DELETE /informe_traficos/1.json
  def destroy
    @informe_trafico = InformeTrafico.find(params[:id])
    @informe_trafico.destroy

    respond_to do |format|
      format.html { redirect_to informe_traficos_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def informe_trafico_params
      params.require(:informe_trafico).permit(:fecha_solicitud, :matricula, :solicitante)
    end
end
