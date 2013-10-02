require 'spec_helper'

describe ApiMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  describe '.api_error_messsage' do
    let(:respuesta) { "resultado:" }

    describe 'one email to one user' do
      subject { ApiMailer.api_error_message(respuesta) }
      it { should deliver_to     "elance@sinapse.es"                                                  }
      it { should deliver_from   'gestoriallorens@gestoriallorens.com'                                    }
      it { should have_subject   I18n.t("Error creando Expedientes")         }
      it { should have_body_text "resultado:"                                    }
    end
  end
end