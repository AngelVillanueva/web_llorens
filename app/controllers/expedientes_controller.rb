class ExpedientesController < ApplicationController
  expose(:expedientes)
  expose(:expediente)

  def create
    if expediente.save
      redirect_to(expediente)
    else
      render :new
    end
  end

end