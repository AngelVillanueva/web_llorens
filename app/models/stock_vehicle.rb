# == Schema Information
#
# Table name: stock_vehicles
#
#  id                           :integer          not null, primary key
#  matricula                    :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  cliente_id                   :integer
#  marca                        :string(255)
#  modelo                       :string(255)
#  vendido                      :boolean          default(FALSE)
#  comprador                    :string(255)
#  ft                           :boolean          default(FALSE)
#  pc                           :boolean          default(FALSE)
#  fecha_itv                    :date
#  incidencia                   :text
#  fecha_expediente_completo    :date
#  fecha_documentacion_enviada  :date
#  fecha_documentacion_recibida :date
#  fecha_notificado_cliente     :date
#  particular                   :boolean          default(FALSE)
#  compra_venta                 :boolean          default(FALSE)
#  fecha_envio_gestoria         :date
#  baja_exportacion             :boolean          default(TRUE)
#  fecha_entregado_david        :date
#  fecha_envio_definitiva       :date
#  observaciones                :text
#

class StockVehicle < ActiveRecord::Base
  belongs_to :cliente
  validates :matricula, presence: true, uniqueness: true
  default_scope order('vendido ASC')
  paginates_per 10

  def expediente_completo?
    !fecha_expediente_completo.nil?
  end
  def documentacion_enviada?
    !fecha_documentacion_enviada.nil?
  end
  def documentacion_recibida?
    !fecha_documentacion_recibida.nil?
  end
  def envio_documentacion_definitiva?
    !fecha_envio_definitiva.nil?
  end
  def finalizado?
    expediente_completo? && documentacion_enviada? && documentacion_recibida? && envio_documentacion_definitiva?
  end

  rails_admin do
    navigation_label I18n.t( "REMARKETING")
    label I18n.t( "Stock Vehicles")
    list do
      field :id do
        column_width 50
      end
      field :cliente do
        column_width 100
      end
      field :vendido do
        column_width 75
      end
      field :matricula do
        column_width 100
      end
      field :expediente_completo? do
        column_width 50
        label I18n.t( "Expediente completo_short")
        pretty_value do
          if bindings[:object].expediente_completo?
            "<i class='icon-circle yes' title='#{I18n.t("Expediente completo")}'></i>".html_safe
          else
            "<i class='icon-circle no' title='#{I18n.t("Expediente completo")}'></i>".html_safe
          end
        end
      end
      field :documentacion_enviada? do
        column_width 50
        label I18n.t( "Documentacion enviada_short")
        pretty_value do
          if bindings[:object].documentacion_enviada?
            "<i class='icon-circle yes' title='#{I18n.t("Documentacion enviada")}'></i>".html_safe
          else
            "<i class='icon-circle no' title='#{I18n.t("Documentacion enviada")}'></i>".html_safe
          end
        end
      end
      field :documentacion_recibida? do
        column_width 50
        label I18n.t( "Documentacion recibida_short")
        pretty_value do
          if bindings[:object].documentacion_recibida?
            "<i class='icon-circle yes' title='#{I18n.t("Documentacion recibida")}'></i>".html_safe
          else
            "<i class='icon-circle no' title='#{I18n.t("Documentacion recibida")}'></i>".html_safe
          end
        end
      end
      field :envio_documentacion_definitiva? do
        column_width 50
        label I18n.t( "Envio documentacion definitiva_short")
        pretty_value do
          if bindings[:object].envio_documentacion_definitiva?
            "<i class='icon-circle yes' title='#{I18n.t("Envio documentacion definitiva")}'></i>".html_safe
          else
            "<i class='icon-circle no' title='#{I18n.t("Envio documentacion definitiva")}'></i>".html_safe
          end
        end
      end
      field :finalizado? do
        column_width 50
        label I18n.t( "Finalizado_short")
        pretty_value do
          if bindings[:object].finalizado?
            "<i class='icon-circle yes' title='#{I18n.t("Finalizado")}'></i>".html_safe
          else
            "<i class='icon-circle no' title='#{I18n.t("Finalizado")}'></i>".html_safe
          end
        end
      end
      field :marca
      field :modelo
      field :created_at do
        label I18n.t( "Created" )
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y %H:%M" )
        end
      end
      field :updated_at do
        label I18n.t( "Updated" )
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y %H:%M" )
        end
      end
      field :comprador
      field :ft do
        label I18n.t( "Ft" )
      end
      field :pc
      field :fecha_itv do
        label I18n.t( "Fecha itv" )
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y" ) unless value.nil?
        end
      end
      field :incidencia
      field :fecha_expediente_completo do
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y" ) unless value.nil?
        end
      end
      field :fecha_documentacion_enviada do
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y" ) unless value.nil?
        end
      end
      field :fecha_documentacion_recibida do
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y" ) unless value.nil?
        end
      end
      field :fecha_notificado_cliente do
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y" ) unless value.nil?
        end
      end
      field :particular
      field :compra_venta
      field :fecha_envio_gestoria do
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y" ) unless value.nil?
        end
      end
      field :baja_exportacion
      field :fecha_entregado_david do
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y" ) unless value.nil?
        end
      end
      field :fecha_envio_definitiva do
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y" ) unless value.nil?
        end
      end
      field :observaciones
    end
    edit do
      field :cliente_id, :hidden do
        default_value do
          Cliente.where(llorens_cliente_id: "4300189329").first.id
        end
      end
      field :matricula
      field :vendido
      field :marca
      field :modelo
      field :comprador
      field :ft do
        label I18n.t( "Ft" )
      end
      field :pc do
        label I18n.t( "Pc" )
      end
      field :fecha_itv do
        date_format :default
        label I18n.t( "Fecha itv" )
      end
      field :incidencia
      field :fecha_expediente_completo do
        date_format :default
      end
      field :fecha_documentacion_enviada do
        date_format :default
      end
      field :fecha_documentacion_recibida do
        date_format :default
      end
      field :fecha_notificado_cliente do
        date_format :default
      end
      field :particular
      field :compra_venta do
        label I18n.t( "Compra_venta")
      end
      field :fecha_envio_gestoria do
        date_format :default
      end
      field :baja_exportacion
      field :fecha_entregado_david do
        date_format :default
      end
      field :fecha_envio_definitiva do
        date_format :default
      end
      field :observaciones
    end
  end
end
