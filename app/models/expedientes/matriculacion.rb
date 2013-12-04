# == Schema Information
#
# Table name: expedientes
#
#  id                  :integer          not null, primary key
#  identificador       :string(255)
#  matricula           :string(255)
#  bastidor            :string(255)
#  comprador           :text
#  vendedor            :text
#  marca               :string(255)
#  modelo              :string(255)
#  fecha_alta          :date
#  fecha_entra_trafico :date
#  fecha_facturacion   :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  observaciones       :text
#  type                :string(255)
#  cliente_id          :integer
#  llorens_cliente_id  :string(255)
#  pdf_file_name       :string(255)
#  pdf_content_type    :string(255)
#  pdf_file_size       :integer
#  pdf_updated_at      :datetime
#  incidencia          :text
#  has_incidencia      :boolean
#

class Matriculacion < Expediente
  has_attached_file :pdf,
    :path => ":rails_root/uploads/:class/:id/:basename.:extension",
    :url => "/online/matriculaciones/:id/matricula"
  default_scope includes(:cliente).order('created_at DESC')

  def self.matriculable_pdf_date
    if Rails.env.development?
      Date.parse('14-11-2013')
    else
      Date.parse('19-11-2013')
    end
  end

  rails_admin do
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :type
      field :identificador do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :matricula do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :bastidor do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :cliente do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :llorens_cliente_id do
        label I18n.t("llorens_cliente_id")
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :comprador do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :vendedor do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :marca do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :modelo do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :fecha_alta do
        date_format :default
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :fecha_entra_trafico do
        date_format :default
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :fecha_facturacion do
        date_format :default
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :pdf_file_name do
        label I18n.t("PDF matricula")
        read_only true
        group :advanced
      end
      field :pdf, :paperclip do
        label I18n.t("PDF")
        group :advanced
      end
    end
  end
end
