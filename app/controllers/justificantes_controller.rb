class JustificantesController < ApplicationController
  # GET /justificantes
  # GET /justificantes.json
  def index
    @justificantes = Justificante.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @justificantes }
    end
  end

  # GET /justificantes/1
  # GET /justificantes/1.json
  def show
    @justificante = Justificante.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @justificante }
    end
  end

  # GET /justificantes/new
  # GET /justificantes/new.json
  def new
    @justificante = Justificante.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @justificante }
    end
  end

  # GET /justificantes/1/edit
  def edit
    @justificante = Justificante.find(params[:id])
  end

  # POST /justificantes
  # POST /justificantes.json
  def create
    @justificante = Justificante.new(justificante_params)

    respond_to do |format|
      if @justificante.save
        format.html { redirect_to @justificante, notice: 'Justificante was successfully created.' }
        format.json { render json: @justificante, status: :created, location: @justificante }
      else
        format.html { render action: "new" }
        format.json { render json: @justificante.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /justificantes/1
  # PATCH/PUT /justificantes/1.json
  def update
    @justificante = Justificante.find(params[:id])

    respond_to do |format|
      if @justificante.update_attributes(justificante_params)
        format.html { redirect_to @justificante, notice: 'Justificante was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @justificante.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /justificantes/1
  # DELETE /justificantes/1.json
  def destroy
    @justificante = Justificante.find(params[:id])
    @justificante.destroy

    respond_to do |format|
      format.html { redirect_to justificantes_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def justificante_params
      params.require(:justificante).permit(:bastidor, :comprador, :dias_tramite, :fecha_alta, :fecha_entra_trafico, :fecha_sale_trafico, :identificador, :marca, :matricula, :matriculacion, :modelo, :vendedor)
    end
end
