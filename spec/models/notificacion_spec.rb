# == Schema Information
#
# Table name: notificaciones
#
#  id                 :integer          not null, primary key
#  aviso_id           :integer
#  usuario_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  caducidad_relativa :date
#

require 'spec_helper'

describe Notificacion do
  describe "as a model" do
    it { should respond_to :caducidad_relativa }

    it { should be_valid }
  end
end
