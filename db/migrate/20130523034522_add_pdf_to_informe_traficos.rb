class AddPdfToInformeTraficos < ActiveRecord::Migration
  def up
    add_attachment :informe_traficos, :pdf
  end
  def down
    remove_attachment :informe_traficos, :pdf
  end
end
